import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/widgets/city_dropdown_field/city_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/in_memory_bundle.dart';

void main() {
  group('CityDropdownField', () {
    Widget wrap({
      required int? stateId,
      required GeoRepository repo,
      ValueChanged<City?>? onChanged,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: CityDropdownField(
            stateId: stateId,
            repository: repo,
            onChanged: onChanged,
          ),
        ),
      );
    }

    testWidgets('shows placeholder when no state is set', (tester) async {
      await tester.pumpWidget(wrap(stateId: null, repo: buildFixtureRepository()));
      await tester.pumpAndSettle();
      expect(find.text('Select city'), findsOneWidget);
    });

    testWidgets('opens picker and emits city selection', (tester) async {
      City? picked;
      await tester.pumpWidget(wrap(
        stateId: 3172,
        repo: buildFixtureRepository(),
        onChanged: (c) => picked = c,
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CityDropdownField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Karachi'));
      await tester.pumpAndSettle();

      expect(picked?.name, 'Karachi');
      expect(find.text('Karachi'), findsOneWidget);
    });

    testWidgets('clears city when stateId changes', (tester) async {
      final repo = buildFixtureRepository();
      final notifier = ValueNotifier<int?>(3172);
      City? last;
      addTearDown(notifier.dispose);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ValueListenableBuilder<int?>(
            valueListenable: notifier,
            builder: (_, value, __) => CityDropdownField(
              stateId: value,
              repository: repo,
              onChanged: (c) => last = c,
            ),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CityDropdownField));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Karachi'));
      await tester.pumpAndSettle();
      expect(last?.name, 'Karachi');

      last = const City(id: -1, name: 'sentinel', stateId: 0);
      notifier.value = 3173;
      await tester.pumpAndSettle();
      expect(last, isNull);
    });
  });
}
