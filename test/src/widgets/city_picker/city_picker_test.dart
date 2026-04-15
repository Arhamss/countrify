import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/widgets/city_picker/city_picker.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/in_memory_bundle.dart';

void main() {
  group('CityPicker', () {
    Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

    testWidgets('renders cities sorted by name', (tester) async {
      await tester.pumpWidget(wrap(CityPicker(
        stateId: 3172,
        repository: buildFixtureRepository(),
      )));
      await tester.pumpAndSettle();
      expect(find.text('Hyderabad'), findsOneWidget);
      expect(find.text('Karachi'), findsOneWidget);
    });

    testWidgets('filters cities by name', (tester) async {
      await tester.pumpWidget(wrap(CityPicker(
        stateId: 3172,
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(searchDebounce: Duration.zero),
      )));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'kar');
      await tester.pumpAndSettle();

      expect(find.text('Karachi'), findsOneWidget);
      expect(find.text('Hyderabad'), findsNothing);
    });

    testWidgets('fires onCitySelected on tap', (tester) async {
      City? picked;
      await tester.pumpWidget(wrap(CityPicker(
        stateId: 3172,
        repository: buildFixtureRepository(),
        onCitySelected: (c) => picked = c,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Karachi'));
      await tester.pump();

      expect(picked, isNotNull);
      expect(picked!.name, 'Karachi');
    });

    testWidgets('showCoordinates renders lat/lng subtitle', (tester) async {
      await tester.pumpWidget(wrap(CityPicker(
        stateId: 3172,
        repository: buildFixtureRepository(),
        showCoordinates: true,
      )));
      await tester.pumpAndSettle();
      expect(find.textContaining('24.860'), findsOneWidget);
    });

    testWidgets('initialSearchText pre-filters the list', (tester) async {
      await tester.pumpWidget(wrap(CityPicker(
        stateId: 3172,
        repository: buildFixtureRepository(),
        config: const GeoPickerConfig(initialSearchText: 'kar'),
      )));
      await tester.pumpAndSettle();
      expect(find.text('Karachi'), findsOneWidget);
      expect(find.text('Hyderabad'), findsNothing);
    });
  });
}
