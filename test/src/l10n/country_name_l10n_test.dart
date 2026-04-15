import 'package:countrify/src/l10n/country_name_l10n.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryNameL10n', () {
    test('getTranslations returns English translations', () {
      final translations = CountryNameL10n.getTranslations('en');
      expect(translations['US'], 'United States');
      expect(translations['GB'], 'United Kingdom');
    });

    test('getTranslations returns non-English translations', () {
      final translations = CountryNameL10n.getTranslations('ar');
      expect(translations['US'], isNotNull);
    });

    test('getTranslations caches results', () {
      final first = CountryNameL10n.getTranslations('fr');
      final second = CountryNameL10n.getTranslations('fr');
      expect(identical(first, second), isTrue);
    });

    test('getTranslations falls back to English for unknown locale', () {
      final translations = CountryNameL10n.getTranslations('zz_unknown');
      expect(translations['US'], 'United States');
    });

    test('supportedLocales contains expected locales', () {
      expect(CountryNameL10n.supportedLocales, contains('en'));
      expect(CountryNameL10n.supportedLocales, contains('ar'));
      expect(CountryNameL10n.supportedLocales, contains('fr'));
    });

    test('getLocalizedName returns correct name', () {
      expect(CountryNameL10n.getLocalizedName('US', 'en'), 'United States');
      expect(CountryNameL10n.getLocalizedName('GB', 'en'), 'United Kingdom');
    });

    test('getLocalizedName returns null for unknown locale', () {
      expect(CountryNameL10n.getLocalizedName('US', 'zz_unknown'), isNull);
    });

    test('getTranslationsForLocale returns map for known locale', () {
      final translations = CountryNameL10n.getTranslationsForLocale('en');
      expect(translations, isNotNull);
      expect(translations!['US'], 'United States');
    });

    test('getTranslationsForLocale returns null for unknown locale', () {
      expect(CountryNameL10n.getTranslationsForLocale('zz_unknown'), isNull);
    });
  });
}
