import 'dart:async';
import 'dart:convert';

import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// {@template geo_repository}
/// Lazy loader for the bundled state / city dataset.
///
/// Country data ships eagerly via `all_countries.dart`, but states (~5,300)
/// and cities (~154,000) are split into per-country / per-state JSON files
/// under `assets/geo/` and loaded on demand. Results are cached in memory for
/// the process lifetime so repeated lookups do not re-decode JSON.
///
/// ```dart
/// final repo = GeoRepository.instance;
/// final states = await repo.statesOf('PK');
/// final cities = await repo.citiesOf(states.first.id);
/// ```
/// {@endtemplate}
class GeoRepository {
  /// {@macro geo_repository}
  GeoRepository({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  /// Shared singleton backed by [rootBundle]. Use this in app code; construct
  /// a fresh instance only when injecting a custom [AssetBundle] for tests.
  static final GeoRepository instance = GeoRepository();

  final AssetBundle _bundle;

  final Map<String, List<CountryState>> _statesCache = {};
  final Map<int, List<City>> _citiesCache = {};
  final Map<String, Future<List<CountryState>>> _statesInflight = {};
  final Map<int, Future<List<City>>> _citiesInflight = {};

  /// Returns all states / provinces for the country identified by [iso2].
  ///
  /// [iso2] is case-insensitive. Returns an empty list if no states are
  /// available for the country (some microstates have no subdivisions).
  Future<List<CountryState>> statesOf(String iso2) {
    final key = iso2.toUpperCase();
    final cached = _statesCache[key];
    if (cached != null) return Future.value(cached);
    return _statesInflight.putIfAbsent(key, () async {
      try {
        final raw = await _bundle.loadString('packages/countrify/assets/geo/states/$key.json');
        final list = (jsonDecode(raw) as List)
            .cast<Map<String, dynamic>>()
            .map((m) => CountryState.fromJson(m, countryIso2: key))
            .toList(growable: false);
        _statesCache[key] = list;
        return list;
      } on Exception {
        _statesCache[key] = const [];
        return const [];
        // ignore: avoid_catching_errors, asset-missing is an expected FlutterError and safe to degrade to an empty list
      } on FlutterError {
        _statesCache[key] = const [];
        return const [];
      } finally {
        unawaited(_statesInflight.remove(key) ?? Future<void>.value());
      }
    });
  }

  /// Returns all cities belonging to the state identified by [stateId].
  ///
  /// Returns an empty list if the state has no city data.
  Future<List<City>> citiesOf(int stateId) {
    final cached = _citiesCache[stateId];
    if (cached != null) return Future.value(cached);
    return _citiesInflight.putIfAbsent(stateId, () async {
      try {
        final raw = await _bundle.loadString('packages/countrify/assets/geo/cities/$stateId.json');
        final list = (jsonDecode(raw) as List)
            .cast<Map<String, dynamic>>()
            .map((m) => City.fromJson(m, stateId: stateId))
            .toList(growable: false);
        _citiesCache[stateId] = list;
        return list;
      } on Exception {
        _citiesCache[stateId] = const [];
        return const [];
        // ignore: avoid_catching_errors, asset-missing is an expected FlutterError and safe to degrade to an empty list
      } on FlutterError {
        _citiesCache[stateId] = const [];
        return const [];
      } finally {
        unawaited(_citiesInflight.remove(stateId) ?? Future<void>.value());
      }
    });
  }

  /// Searches all cities across all states for [countryIso2].
  ///
  /// Loads state files lazily and caches them. Returns matching cities
  /// (capped at [limit]) sorted by relevance — exact prefix matches first,
  /// then contains matches, each group alphabetical.
  ///
  /// ```dart
  /// final results = await GeoRepository.instance.searchCities(
  ///   countryIso2: 'US',
  ///   query: 'san',
  /// );
  /// for (final (:city, :state) in results) {
  ///   print('${city.name}, ${state.name}');
  /// }
  /// ```
  Future<List<({City city, CountryState state})>> searchCities({
    required String countryIso2,
    required String query,
    int limit = 20,
  }) async {
    final q = SearchNormalizer.foldAccents(query);
    if (q.isEmpty) return const [];

    final states = await statesOf(countryIso2);
    if (states.isEmpty) return const [];

    final results = <({City city, CountryState state})>[];

    // Load cities in batches of 10 states to avoid loading all files at once
    // on the first search. Cached states resolve instantly on subsequent calls.
    const batchSize = 10;
    for (var i = 0; i < states.length; i += batchSize) {
      final batch = states.sublist(
        i,
        (i + batchSize).clamp(0, states.length),
      );
      final cityLists = await Future.wait(
        batch.map((s) => citiesOf(s.id)),
      );
      for (var j = 0; j < batch.length; j++) {
        final state = batch[j];
        for (final city in cityLists[j]) {
          if (SearchNormalizer.foldAccents(city.name).contains(q)) {
            results.add((city: city, state: state));
          }
        }
      }
      // Stop early if we already have more than enough results.
      if (results.length >= limit * 2) break;
    }

    // Sort: prefix matches first, then contains, each group alphabetical.
    results.sort((a, b) {
      final aNorm = SearchNormalizer.foldAccents(a.city.name);
      final bNorm = SearchNormalizer.foldAccents(b.city.name);
      final aPrefix = aNorm.startsWith(q);
      final bPrefix = bNorm.startsWith(q);
      if (aPrefix != bPrefix) return aPrefix ? -1 : 1;
      return a.city.name.compareTo(b.city.name);
    });

    return results.length > limit ? results.sublist(0, limit) : results;
  }

  /// Pre-loads all city files for [countryIso2] in the background.
  ///
  /// Call this on screen init so that subsequent [searchCities] calls are
  /// instant. Safe to call multiple times — already-cached states are skipped.
  Future<void> preloadCities(String countryIso2) async {
    final states = await statesOf(countryIso2);
    // Fire all loads concurrently; citiesOf deduplicates in-flight requests.
    await Future.wait(states.map((s) => citiesOf(s.id)));
  }

  /// Drops every cached states / cities entry. Useful in long-running tests
  /// or when memory pressure makes the ~10 MB worst-case footprint a concern.
  void clearCache() {
    _statesCache.clear();
    _citiesCache.clear();
  }
}
