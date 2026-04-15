import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeoPickerTheme', () {
    test('default constructor leaves all fields null', () {
      const theme = GeoPickerTheme();
      expect(theme.backgroundColor, isNull);
      expect(theme.itemSelectedColor, isNull);
      expect(theme.elevation, isNull);
    });

    test('light preset populates sensible defaults', () {
      final theme = GeoPickerTheme.light();
      expect(theme.backgroundColor, Colors.white);
      expect(theme.itemSelectedColor, isNotNull);
    });

    test('dark preset populates dark-mode defaults', () {
      final theme = GeoPickerTheme.dark();
      expect(theme.backgroundColor, const Color(0xFF1E1E1E));
      expect(theme.itemNameTextStyle?.color, Colors.white);
    });

    test('resolved icon getters fall back to defaults', () {
      const theme = GeoPickerTheme();
      expect(theme.resolvedCloseIcon, isNotNull);
      expect(theme.resolvedSearchIcon, isNotNull);
      expect(theme.resolvedClearIcon, isNotNull);
      expect(theme.resolvedSelectedIcon, isNotNull);
      expect(theme.resolvedEmptyStateIcon, isNotNull);
    });

    test('resolved icons respect overrides', () {
      const theme = GeoPickerTheme(closeIcon: Icons.arrow_back);
      expect(theme.resolvedCloseIcon, Icons.arrow_back);
    });

    test('copyWith replaces only the specified fields', () {
      const original = GeoPickerTheme(
        backgroundColor: Colors.red,
        itemSelectedColor: Colors.blue,
        elevation: 2,
      );
      final copy = original.copyWith(backgroundColor: Colors.green);
      expect(copy.backgroundColor, Colors.green);
      expect(copy.itemSelectedColor, Colors.blue);
      expect(copy.elevation, 2);
    });

    test('is annotated immutable', () {
      // Compile-time proof: if CountryState's fields were ever mutated the
      // analyzer would flag @immutable violations. Here we simply confirm
      // the class compiles under `const` instantiation.
      const first = GeoPickerTheme(backgroundColor: Colors.white);
      const second = GeoPickerTheme(backgroundColor: Colors.white);
      expect(identical(first, second), isTrue);
    });
  });

  group('GeoPickerConfig', () {
    test('defaults are safe for production pickers', () {
      const config = GeoPickerConfig();
      expect(config.searchEnabled, isTrue);
      expect(config.hapticFeedback, isTrue);
      expect(config.enableScrollbar, isTrue);
      expect(config.autofocusSearch, isFalse);
      expect(config.accentInsensitiveSearch, isTrue);
      expect(config.showSelectedIcon, isTrue);
      expect(config.minHeight, 240);
      expect(config.searchDebounce, const Duration(milliseconds: 250));
    });

    test('copyWith replaces only the specified fields', () {
      const original = GeoPickerConfig(
        searchDebounce: Duration(milliseconds: 500),
        hapticFeedback: false,
      );
      final copy = original.copyWith(searchEnabled: false);
      expect(copy.searchEnabled, isFalse);
      expect(copy.hapticFeedback, isFalse);
      expect(copy.searchDebounce, const Duration(milliseconds: 500));
    });

    test('initialSearchText and autofocus round-trip via copyWith', () {
      const original = GeoPickerConfig();
      final copy = original.copyWith(
        initialSearchText: 'sao',
        autofocusSearch: true,
      );
      expect(copy.initialSearchText, 'sao');
      expect(copy.autofocusSearch, isTrue);
    });
  });
}
