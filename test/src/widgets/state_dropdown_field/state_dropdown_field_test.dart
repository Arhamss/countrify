import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/widgets/state_dropdown_field/state_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/in_memory_bundle.dart';

void main() {
  group('StateDropdownField', () {
    Widget wrap({
      required String? countryIso2,
      required GeoRepository repo,
      ValueChanged<CountryState?>? onChanged,
      bool searchable = false,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: StateDropdownField(
            countryIso2: countryIso2,
            repository: repo,
            onChanged: onChanged,
            searchable: searchable,
          ),
        ),
      );
    }

    testWidgets('shows placeholder when no country is set', (tester) async {
      final repo = buildFixtureRepository();
      await tester.pumpWidget(wrap(countryIso2: null, repo: repo));
      await tester.pumpAndSettle();
      expect(find.text('Select state'), findsOneWidget);
    });

    testWidgets('opens bottom sheet and emits selected state on tap',
        (tester) async {
      final repo = buildFixtureRepository();
      CountryState? picked;
      await tester.pumpWidget(wrap(
        countryIso2: 'PK',
        repo: repo,
        onChanged: (s) => picked = s,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(StateDropdownField));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sindh'));
      await tester.pumpAndSettle();

      expect(picked, isNotNull);
      expect(picked!.name, 'Sindh');
      expect(find.text('Sindh'), findsOneWidget);
    });

    testWidgets('clears selection when countryIso2 changes', (tester) async {
      final repo = buildFixtureRepository();
      final notifier = ValueNotifier<String?>('PK');
      CountryState? last;
      addTearDown(notifier.dispose);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<String?>(
            valueListenable: notifier,
            builder: (_, value, __) => StateDropdownField(
              countryIso2: value,
              repository: repo,
              searchable: false,
              onChanged: (s) => last = s,
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Open sheet, select Sindh.
      await tester.tap(find.byType(StateDropdownField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sindh'));
      await tester.pumpAndSettle();
      expect(last?.name, 'Sindh');

      // Switch country; onChanged(null) must fire.
      last = const CountryState(id: -1, name: 'sentinel', countryIso2: '');
      notifier.value = 'US';
      await tester.pumpAndSettle();
      expect(last, isNull);
    });
  });
}
