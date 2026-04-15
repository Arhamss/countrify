// ignore_for_file: avoid_print
/// Regenerates `assets/geo/states/*.json` and `assets/geo/cities/*.json` from
/// the dr5hn/countries-states-cities-database upstream.
///
/// The package vendors a split, minified subset of the dataset. This script
/// is the single source of truth for how that subset is produced so future
/// refreshes stay reproducible.
///
/// Usage:
///   dart run tool/sync_geo_data.dart               # pull master tarball
///   dart run tool/sync_geo_data.dart --ref v2.6    # pull a tagged release
///   dart run tool/sync_geo_data.dart --input /path/to/countries+states+cities.json
///
/// When --input is omitted the script downloads
/// https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/{ref}/json/countries+states+cities.json
/// into a temp file, then writes split outputs under assets/geo/.
library;

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final ref = _flag(args, '--ref') ?? 'master';
  final inputPath = _flag(args, '--input');
  final projectRoot = _findProjectRoot();
  final statesDir = Directory('${projectRoot.path}/assets/geo/states');
  final citiesDir = Directory('${projectRoot.path}/assets/geo/cities');

  final sourceJson = inputPath != null
      ? await File(inputPath).readAsString()
      : await _download(
          'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/$ref/json/countries+states+cities.json',
        );

  final data = jsonDecode(sourceJson) as List;
  print('loaded ${data.length} countries from upstream');

  await _reset(statesDir);
  await _reset(citiesDir);

  var stateCount = 0;
  var cityCount = 0;
  for (final entry in data) {
    final country = entry as Map<String, dynamic>;
    final iso2 = country['iso2'] as String?;
    if (iso2 == null) continue;
    final states = (country['states'] as List? ?? const []).cast<Map<String, dynamic>>();
    final compactStates = <Map<String, dynamic>>[];
    for (final state in states) {
      compactStates.add({
        'id': state['id'],
        'name': state['name'],
        'iso2': state['iso2'],
        'type': state['type'],
        'lat': _asDouble(state['latitude']),
        'lng': _asDouble(state['longitude']),
      });
      final cities = (state['cities'] as List? ?? const []).cast<Map<String, dynamic>>();
      final compactCities = cities
          .map((c) => {
                'id': c['id'],
                'name': c['name'],
                'lat': _asDouble(c['latitude']),
                'lng': _asDouble(c['longitude']),
              })
          .toList(growable: false);
      await File('${citiesDir.path}/${state['id']}.json')
          .writeAsString(jsonEncode(compactCities));
      cityCount += compactCities.length;
      stateCount++;
    }
    await File('${statesDir.path}/$iso2.json')
        .writeAsString(jsonEncode(compactStates));
  }
  print('wrote ${data.length} state files, $stateCount states, $cityCount cities');
}

String? _flag(List<String> args, String name) {
  final idx = args.indexOf(name);
  return idx == -1 || idx + 1 >= args.length ? null : args[idx + 1];
}

double? _asDouble(Object? v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

Directory _findProjectRoot() {
  var dir = Directory.current;
  while (!File('${dir.path}/pubspec.yaml').existsSync()) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('pubspec.yaml not found; run from the package root');
    }
    dir = parent;
  }
  return dir;
}

Future<void> _reset(Directory dir) async {
  if (dir.existsSync()) await dir.delete(recursive: true);
  await dir.create(recursive: true);
}

Future<String> _download(String url) async {
  print('downloading $url');
  final client = HttpClient();
  try {
    final req = await client.getUrl(Uri.parse(url));
    final res = await req.close();
    if (res.statusCode != 200) {
      throw HttpException('GET $url returned ${res.statusCode}');
    }
    return res.transform(utf8.decoder).join();
  } finally {
    client.close();
  }
}
