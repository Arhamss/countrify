import 'dart:convert';

import 'package:countrify/src/data/geo_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal in-memory [AssetBundle] used so repository tests don't depend on
/// the real 28 MB vendored asset directory.
class _InMemoryBundle extends CachingAssetBundle {
  _InMemoryBundle(this.assets, {this.onLoad});

  final Map<String, String> assets;
  final ValueChanged<String>? onLoad;
  int loadCount = 0;

  @override
  Future<ByteData> load(String key) async {
    onLoad?.call(key);
    loadCount++;
    final raw = assets[key];
    if (raw == null) {
      throw Exception('Unable to load asset: $key');
    }
    final bytes = utf8.encode(raw);
    return ByteData.sublistView(Uint8List.fromList(bytes));
  }
}

void main() {
  group('GeoRepository', () {
    late _InMemoryBundle bundle;
    late GeoRepository repo;

    setUp(() {
      bundle = _InMemoryBundle({
        'packages/countrify/assets/geo/states/PK.json': jsonEncode([
          {
            'id': 3172,
            'name': 'Sindh',
            'iso2': 'SD',
            'type': 'province',
            'lat': 25.0,
            'lng': 68.0,
          },
          {
            'id': 3173,
            'name': 'Punjab',
            'iso2': 'PB',
            'type': 'province',
            'lat': 31.0,
            'lng': 72.0,
          },
        ]),
        'packages/countrify/assets/geo/cities/3172.json': jsonEncode([
          {'id': 1, 'name': 'Karachi', 'lat': 24.86, 'lng': 67.00},
          {'id': 2, 'name': 'Hyderabad', 'lat': 25.39, 'lng': 68.37},
        ]),
      });
      repo = GeoRepository(bundle: bundle);
    });

    test('statesOf loads and parses the per-country asset', () async {
      final states = await repo.statesOf('PK');
      expect(states, hasLength(2));
      expect(states.first.name, 'Sindh');
      expect(states.first.countryIso2, 'PK');
      expect(states.first.iso2, 'SD');
      expect(states.first.latitude, 25.0);
    });

    test('statesOf is case-insensitive on the iso2 key', () async {
      final states = await repo.statesOf('pk');
      expect(states, hasLength(2));
    });

    test('statesOf caches results so repeat calls skip the bundle', () async {
      await repo.statesOf('PK');
      await repo.statesOf('PK');
      await repo.statesOf('PK');
      expect(bundle.loadCount, 1);
    });

    test('statesOf deduplicates concurrent loads', () async {
      final futures = [
        repo.statesOf('PK'),
        repo.statesOf('PK'),
        repo.statesOf('PK')
      ];
      await Future.wait(futures);
      expect(bundle.loadCount, 1);
    });

    test('statesOf returns empty list when the asset is missing', () async {
      expect(await repo.statesOf('ZZ'), isEmpty);
    });

    test('citiesOf loads and parses the per-state asset', () async {
      final cities = await repo.citiesOf(3172);
      expect(cities, hasLength(2));
      expect(cities.first.name, 'Karachi');
      expect(cities.first.stateId, 3172);
      expect(cities.last.name, 'Hyderabad');
    });

    test('citiesOf caches results', () async {
      final before = bundle.loadCount;
      await repo.citiesOf(3172);
      await repo.citiesOf(3172);
      expect(bundle.loadCount, before + 1);
    });

    test('citiesOf returns empty list when the asset is missing', () async {
      expect(await repo.citiesOf(999999), isEmpty);
    });

    test('clearCache drops prior results', () async {
      // First load caches 2 states.
      final first = await repo.statesOf('PK');
      expect(first, hasLength(2));
      // Mutate the underlying asset so a re-fetch returns different data,
      // then verify clearCache actually re-reads from the bundle.
      bundle.assets['packages/countrify/assets/geo/states/PK.json'] =
          jsonEncode([
        {'id': 1, 'name': 'New State', 'iso2': 'NS', 'type': 'region'},
      ]);
      // Without clearCache the old list would still be returned.
      repo.clearCache();
      bundle.clear();
      final second = await repo.statesOf('PK');
      expect(second, hasLength(1));
      expect(second.first.name, 'New State');
    });
  });
}
