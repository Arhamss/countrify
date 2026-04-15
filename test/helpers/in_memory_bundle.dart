import 'dart:convert';

import 'package:countrify/src/data/geo_repository.dart';
import 'package:flutter/services.dart';

/// Test-only [AssetBundle] that serves pre-seeded strings instead of reading
/// real asset files. Combined with a fresh [GeoRepository] (not the global
/// singleton), this lets widget tests run without the 28 MB bundled dataset.
class InMemoryBundle extends AssetBundle {
  InMemoryBundle(this.assets);

  final Map<String, String> assets;

  @override
  Future<ByteData> load(String key) async {
    final raw = assets[key];
    if (raw == null) throw Exception('asset not found: $key');
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(raw)));
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final raw = assets[key];
    if (raw == null) throw Exception('asset not found: $key');
    return raw;
  }
}

/// Convenience builder that creates a repository seeded with the common
/// "Pakistan with Sindh + Karachi/Hyderabad" fixture used by most widget
/// tests in this package.
GeoRepository buildFixtureRepository() {
  return GeoRepository(
    bundle: InMemoryBundle({
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
        {
          'id': 3174,
          'name': 'São Paulo-ish',
          'iso2': 'SP',
          'type': 'province',
        },
      ]),
      'packages/countrify/assets/geo/states/US.json': jsonEncode([
        {'id': 1, 'name': 'California', 'iso2': 'CA', 'type': 'state'},
        {'id': 2, 'name': 'Nevada', 'iso2': 'NV', 'type': 'state'},
      ]),
      'packages/countrify/assets/geo/cities/3172.json': jsonEncode([
        {'id': 100, 'name': 'Karachi', 'lat': 24.86, 'lng': 67.00},
        {'id': 101, 'name': 'Hyderabad', 'lat': 25.39, 'lng': 68.37},
      ]),
      'packages/countrify/assets/geo/cities/3173.json': jsonEncode([
        {'id': 200, 'name': 'Lahore'},
        {'id': 201, 'name': 'Faisalabad'},
      ]),
      'packages/countrify/assets/geo/cities/1.json': jsonEncode([
        {'id': 300, 'name': 'San Francisco'},
        {'id': 301, 'name': 'Los Angeles'},
      ]),
    }),
  );
}
