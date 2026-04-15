import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_bundle.dart';

void main() {
  group('CountryStateCityField', () {
    testWidgets('renders three cascading dropdowns', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CountryStateCityField(
            repository: buildFixtureRepository(),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      // Labels appear as both floating label and placeholder text.
      expect(find.text('Country'), findsWidgets);
      expect(find.text('State / Province'), findsWidgets);
      expect(find.text('City'), findsWidgets);
    });

    test('CountryStateCitySelection value-equality', () {
      expect(
        const CountryStateCitySelection(),
        equals(const CountryStateCitySelection()),
      );
      expect(
        const CountryStateCitySelection().isComplete,
        isFalse,
      );
    });

    test('CountryStateCitySelection.isComplete flips when all fields set', () {
      const selection = CountryStateCitySelection(
        country: null,
        state: CountryState(id: 1, name: 'S', countryIso2: 'PK'),
        city: City(id: 1, name: 'C', stateId: 1),
      );
      expect(selection.isComplete, isFalse);
    });
  });
}
