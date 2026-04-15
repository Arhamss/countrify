import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testCountry = CountryUtils.getCountryByAlpha2Code('US')!;

  group('CountryFlag', () {
    testWidgets('renders with correct size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryFlag(country: testCountry, size: const Size(32, 24)),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.width, 32);
      expect(sizedBox.height, 24);
    });

    testWidgets('has correct semantics label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryFlag(country: testCountry),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Flag of United States'), findsOneWidget);
    });

    testWidgets('applies border radius', (tester) async {
      const radius = BorderRadius.all(Radius.circular(8));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryFlag(country: testCountry, borderRadius: radius),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clipRRect.borderRadius, radius);
    });
  });
}
