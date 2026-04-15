import 'dart:async';
import 'dart:convert';

import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/models/state.dart';
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

  /// Drops every cached states / cities entry. Useful in long-running tests
  /// or when memory pressure makes the ~10 MB worst-case footprint a concern.
  void clearCache() {
    _statesCache.clear();
    _citiesCache.clear();
  }
}
