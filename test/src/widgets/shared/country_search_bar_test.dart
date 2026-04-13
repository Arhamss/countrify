import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/country_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp({
    ValueChanged<String>? onChanged,
    String hintText = 'Search countries',
    Duration debounceDuration = const Duration(milliseconds: 200),
    CountryPickerTheme? theme,
    bool autofocus = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CountrySearchBar(
          onChanged: onChanged,
          hintText: hintText,
          debounceDuration: debounceDuration,
          theme: theme,
          autofocus: autofocus,
        ),
      ),
    );
  }

  group('CountrySearchBar', () {
    testWidgets('renders with hint text', (tester) async {
      await tester.pumpWidget(buildApp(hintText: 'Find a country'));
      expect(find.text('Find a country'), findsOneWidget);
    });

    testWidgets('shows clear button when text is entered', (tester) async {
      await tester.pumpWidget(buildApp());

      // Initially no clear button.
      expect(find.byTooltip('Clear search'), findsNothing);

      // Enter text.
      await tester.enterText(find.byType(TextField), 'Canada');
      await tester.pump();

      // Clear button should now be visible.
      expect(find.byTooltip('Clear search'), findsOneWidget);
    });

    testWidgets('clears text when clear button is tapped', (tester) async {
      await tester.pumpWidget(buildApp());

      await tester.enterText(find.byType(TextField), 'Canada');
      await tester.pump();

      // Tap the clear button.
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pump();

      // Text field should be empty.
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller!.text, isEmpty);

      // Clear button should be gone.
      expect(find.byTooltip('Clear search'), findsNothing);
    });

    testWidgets('fires onChanged after debounce period', (tester) async {
      String? lastValue;
      await tester.pumpWidget(
        buildApp(
          debounceDuration: const Duration(milliseconds: 300),
          onChanged: (value) => lastValue = value,
        ),
      );

      // Enter text.
      await tester.enterText(find.byType(TextField), 'US');
      await tester.pump();

      // Before debounce elapses, onChanged should not have fired.
      await tester.pump(const Duration(milliseconds: 100));
      expect(lastValue, isNull);

      // After debounce elapses, onChanged should fire.
      await tester.pump(const Duration(milliseconds: 200));
      expect(lastValue, equals('US'));
    });

    testWidgets('has semantics label "Search countries"', (tester) async {
      await tester.pumpWidget(buildApp());

      // Verify a Semantics widget with the correct label wraps the field.
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Semantics && widget.properties.label == 'Search countries',
        ),
        findsOneWidget,
      );
    });
  });
}
