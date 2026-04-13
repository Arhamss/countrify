import 'package:countrify/countrify.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:countrify/src/widgets/shared/country_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testCountry = CountryUtils.getCountryByAlpha2Code('US')!;

  Widget buildSubject({
    Country? country,
    ValueChanged<Country>? onTap,
    bool isSelected = false,
    bool showFlag = true,
    bool showCountryName = true,
    bool showDialCode = true,
    String? displayName,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CountryListTile(
          country: country ?? testCountry,
          onTap: onTap ?? (_) {},
          isSelected: isSelected,
          showFlag: showFlag,
          showCountryName: showCountryName,
          showDialCode: showDialCode,
          displayName: displayName,
        ),
      ),
    );
  }

  group('CountryListTile', () {
    testWidgets('renders country name and dial code text', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.text('United States'), findsOneWidget);
      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('shows CountryFlag widget', (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byType(CountryFlag), findsOneWidget);
    });

    testWidgets('shows checkmark icon when isSelected is true',
        (tester) async {
      await tester.pumpWidget(buildSubject(isSelected: true));

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not show checkmark icon when isSelected is false',
        (tester) async {
      await tester.pumpWidget(buildSubject());

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('fires onTap callback when tapped', (tester) async {
      Country? tappedCountry;
      await tester.pumpWidget(
        buildSubject(onTap: (country) => tappedCountry = country),
      );

      await tester.tap(find.byType(InkWell));
      expect(tappedCountry, equals(testCountry));
    });

    testWidgets('has correct semantics label', (tester) async {
      await tester.pumpWidget(buildSubject());

      final semantics = tester.widget<Semantics>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'United States, dial code +1',
        ),
      );
      expect(semantics, isNotNull);
    });

    testWidgets('uses displayName when provided', (tester) async {
      await tester.pumpWidget(
        buildSubject(displayName: 'Estados Unidos'),
      );

      expect(find.text('Estados Unidos'), findsOneWidget);

      final semantics = tester.widget<Semantics>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label == 'Estados Unidos, dial code +1',
        ),
      );
      expect(semantics, isNotNull);
    });
  });
}
