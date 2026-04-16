import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/widgets/city_search_field/city_search_field.dart';
import 'package:countrify/src/widgets/geo_picker/geo_search_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/in_memory_bundle.dart';

void main() {
  group('GeoRepository.searchCities', () {
    late GeoRepository repo;

    setUp(() => repo = buildFixtureRepository());

    test('returns cities matching query across multiple states', () async {
      // "la" matches Lahore (Punjab) and Faisalabad (Punjab)
      final results = await repo.searchCities(
        countryIso2: 'PK',
        query: 'la',
      );
      final names = results.map((r) => r.city.name).toList();
      expect(names, contains('Lahore'));
      expect(names, contains('Faisalabad'));
    });

    test('returns empty list for empty query', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: '',
      );
      expect(results, isEmpty);
    });

    test('returns empty list for whitespace-only query', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: '   ',
      );
      expect(results, isEmpty);
    });

    test('respects country boundary', () async {
      // "la" should only match US cities when searching US.
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: 'la',
      );
      final names = results.map((r) => r.city.name).toList();
      expect(names, contains('Las Vegas'));
      // "Los Angeles" does not contain "la" as a substring.
      expect(names, isNot(contains('Lahore')));
    });

    test('includes parent state in results', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: 'san',
      );
      expect(results, hasLength(1));
      expect(results.first.city.name, 'San Francisco');
      expect(results.first.state.name, 'California');
    });

    test('prefix matches sort before contains matches', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: 'las',
      );
      // "Las Vegas" is a prefix match, should come first.
      expect(results.first.city.name, 'Las Vegas');
    });

    test('respects limit parameter', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: 'l',
        limit: 1,
      );
      expect(results, hasLength(1));
    });

    test('case insensitive matching', () async {
      final results = await repo.searchCities(
        countryIso2: 'US',
        query: 'SAN',
      );
      expect(results, hasLength(1));
      expect(results.first.city.name, 'San Francisco');
    });
  });

  group('CitySearchField', () {
    Widget wrap({
      required GeoRepository repo,
      String countryIso2 = 'US',
      ValueChanged<CitySearchResult?>? onChanged,
      int? initialCityId,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CitySearchField(
              countryIso2: countryIso2,
              repository: repo,
              onChanged: onChanged,
              initialCityId: initialCityId,
            ),
          ),
        ),
      );
    }

    testWidgets('renders with placeholder text', (tester) async {
      await tester.pumpWidget(wrap(repo: buildFixtureRepository()));
      await tester.pumpAndSettle();
      expect(find.text('Search city'), findsOneWidget);
    });

    testWidgets('searches and shows results from multiple states',
        (tester) async {
      final repo = buildFixtureRepository();
      await tester.pumpWidget(wrap(repo: repo));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      // "l" matches Los Angeles (California) and Las Vegas (Nevada).
      await tester.enterText(find.byType(TextField), 'l');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('Las Vegas'), findsOneWidget);
      expect(find.text('Los Angeles'), findsOneWidget);
      // Subtitles — state names.
      expect(find.text('Nevada'), findsOneWidget);
      expect(find.text('California'), findsOneWidget);
    });

    testWidgets('selecting a result updates field and fires onChanged',
        (tester) async {
      final repo = buildFixtureRepository();
      CitySearchResult? result;
      await tester.pumpWidget(wrap(
        repo: repo,
        onChanged: (r) => result = r,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'san');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Simulate selection via the overlay's onSelected callback.
      // CompositedTransformFollower hit-testing is unreliable in widget tests.
      final overlay = tester.widget<GeoSearchOverlay<CitySearchResult>>(
        find.byType(GeoSearchOverlay<CitySearchResult>),
      );
      overlay.onSelected(overlay.items.first);
      await tester.pumpAndSettle();

      expect(result, isNotNull);
      expect(result!.city.name, 'San Francisco');
      expect(result!.state.name, 'California');
      expect(find.text('San Francisco'), findsOneWidget);
    });

    testWidgets('empty query clears selection', (tester) async {
      final repo = buildFixtureRepository();
      CitySearchResult? result;
      await tester.pumpWidget(wrap(
        repo: repo,
        onChanged: (r) => result = r,
      ));
      await tester.pumpAndSettle();

      // Select a city first via overlay callback.
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'reno');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      final overlay = tester.widget<GeoSearchOverlay<CitySearchResult>>(
        find.byType(GeoSearchOverlay<CitySearchResult>),
      );
      overlay.onSelected(overlay.items.first);
      await tester.pumpAndSettle();
      expect(result?.city.name, 'Reno');

      // Clear the field.
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(result, isNull);
    });

    testWidgets('respects countryIso2 — only searches within that country',
        (tester) async {
      final repo = buildFixtureRepository();
      await tester.pumpWidget(wrap(repo: repo, countryIso2: 'PK'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      // "la" matches Lahore (PK) but should NOT show Las Vegas (US).
      await tester.enterText(find.byType(TextField), 'la');
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('Lahore'), findsOneWidget);
      expect(find.text('Las Vegas'), findsNothing);
      expect(find.text('Los Angeles'), findsNothing);
    });
  });
}
