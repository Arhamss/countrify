import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/state_picker/state_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/in_memory_bundle.dart';

void main() {
  group('StatePicker', () {
    Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

    testWidgets('renders the loaded states sorted by name', (tester) async {
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
      )));
      await tester.pumpAndSettle();

      expect(find.text('Punjab'), findsOneWidget);
      expect(find.text('Sindh'), findsOneWidget);
    });

    testWidgets('filters by name when search text is entered', (tester) async {
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
      )));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'pun');
      await tester.pumpAndSettle();

      expect(find.text('Punjab'), findsOneWidget);
      expect(find.text('Sindh'), findsNothing);
    });

    testWidgets('matches accent-folded queries by default', (tester) async {
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
      )));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'sao');
      await tester.pumpAndSettle();

      expect(find.text('São Paulo-ish'), findsOneWidget);
    });

    testWidgets('fires onStateSelected when a row is tapped', (tester) async {
      CountryState? picked;
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        onStateSelected: (s) => picked = s,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sindh'));
      await tester.pump();

      expect(picked, isNotNull);
      expect(picked!.name, 'Sindh');
    });

    testWidgets('fires onSearchChanged and onResultsChanged', (tester) async {
      final queries = <String>[];
      final resultCounts = <int>[];
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
        onSearchChanged: queries.add,
        onResultsChanged: (list) => resultCounts.add(list.length),
      )));
      await tester.pumpAndSettle();
      expect(resultCounts.isNotEmpty, isTrue);

      await tester.enterText(find.byType(TextField), 'pun');
      await tester.pumpAndSettle();

      expect(queries, contains('pun'));
      expect(resultCounts.last, 1);
    });

    testWidgets('uses customMatcher when provided', (tester) async {
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
        // Match by exact iso2 code only.
        customMatcher: (state, q) => (state.iso2 ?? '').toLowerCase() == q,
      )));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'sd');
      await tester.pumpAndSettle();

      expect(find.text('Sindh'), findsOneWidget);
      expect(find.text('Punjab'), findsNothing);
    });

    testWidgets('shows empty state when no states match', (tester) async {
      await tester.pumpWidget(wrap(StatePicker(
        countryIso2: 'PK',
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
        emptyStateText: 'Nothing found',
      )));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'zzzzzz');
      await tester.pumpAndSettle();

      expect(find.text('Nothing found'), findsOneWidget);
    });
  });
}
