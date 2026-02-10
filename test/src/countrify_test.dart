import 'package:flutter_test/flutter_test.dart';
import 'package:countrify/countrify.dart';

void main() {
  group('Country Model Tests', () {
    test('should create a country with all properties', () {
      final country = Country(
        name: 'United States',
        nameTranslations: {'en': 'United States'},
        alpha2Code: 'US',
        alpha3Code: 'USA',
        numericCode: '840',
        flagEmoji: '🇺🇸',
        flagImagePath: 'packages/countrify/src/flag_images/US.png',
        capital: 'Washington, D.C.',
        region: 'Americas',
        subregion: 'Northern America',
        population: 331002651,
        area: 9833517.0,
        callingCodes: ['1'],
        topLevelDomains: ['.us'],
        currencies: [Currency(code: 'USD', name: 'United States dollar', symbol: '\$')],
        languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
        timezones: ['UTC-05:00'],
        borders: ['CAN', 'MEX'],
        isIndependent: true,
        isUnMember: true,
      );

      expect(country.name, 'United States');
      expect(country.alpha2Code, 'US');
      expect(country.alpha3Code, 'USA');
      expect(country.numericCode, '840');
      expect(country.flagEmoji, '🇺🇸');
      expect(country.capital, 'Washington, D.C.');
      expect(country.region, 'Americas');
      expect(country.subregion, 'Northern America');
      expect(country.population, 331002651);
      expect(country.area, 9833517.0);
      expect(country.callingCodes, ['1']);
      expect(country.topLevelDomains, ['.us']);
      expect(country.currencies.length, 1);
      expect(country.languages.length, 1);
      expect(country.timezones.length, 1);
      expect(country.borders, ['CAN', 'MEX']);
      expect(country.isIndependent, true);
      expect(country.isUnMember, true);
    });

    test('should support equality comparison', () {
      final country1 = Country(
        name: 'United States',
        nameTranslations: {'en': 'United States'},
        alpha2Code: 'US',
        alpha3Code: 'USA',
        numericCode: '840',
        flagEmoji: '🇺🇸',
        flagImagePath: 'packages/countrify/src/flag_images/US.png',
        capital: 'Washington, D.C.',
        region: 'Americas',
        subregion: 'Northern America',
        population: 331002651,
        area: 9833517.0,
        callingCodes: ['1'],
        topLevelDomains: ['.us'],
        currencies: [],
        languages: [],
        timezones: [],
        borders: [],
        isIndependent: true,
        isUnMember: true,
      );

      final country2 = Country(
        name: 'United States',
        nameTranslations: {'en': 'United States'},
        alpha2Code: 'US',
        alpha3Code: 'USA',
        numericCode: '840',
        flagEmoji: '🇺🇸',
        flagImagePath: 'packages/countrify/src/flag_images/US.png',
        capital: 'Washington, D.C.',
        region: 'Americas',
        subregion: 'Northern America',
        population: 331002651,
        area: 9833517.0,
        callingCodes: ['1'],
        topLevelDomains: ['.us'],
        currencies: [],
        languages: [],
        timezones: [],
        borders: [],
        isIndependent: true,
        isUnMember: true,
      );

      expect(country1, equals(country2));
      expect(country1.hashCode, equals(country2.hashCode));
    });
  });

  group('CountryUtils Tests', () {
    test('should get all countries', () {
      final countries = CountryUtils.getAllCountries();
      expect(countries, isNotEmpty);
      expect(countries.length, greaterThan(30));
    });

    test('should get country by alpha-2 code', () {
      final usa = CountryUtils.getCountryByAlpha2Code('US');
      expect(usa, isNotNull);
      expect(usa!.name, 'United States');
      expect(usa.alpha2Code, 'US');
    });

    test('should get country by alpha-3 code', () {
      final usa = CountryUtils.getCountryByAlpha3Code('USA');
      expect(usa, isNotNull);
      expect(usa!.name, 'United States');
      expect(usa.alpha3Code, 'USA');
    });

    test('should get country by numeric code', () {
      final usa = CountryUtils.getCountryByNumericCode('840');
      expect(usa, isNotNull);
      expect(usa!.name, 'United States');
      expect(usa.numericCode, '840');
    });

    test('should return null for invalid codes', () {
      expect(CountryUtils.getCountryByAlpha2Code('XX'), isNull);
      expect(CountryUtils.getCountryByAlpha3Code('XXX'), isNull);
      expect(CountryUtils.getCountryByNumericCode('999'), isNull);
    });

    test('should search countries by name', () {
      final results = CountryUtils.searchCountries('united');
      expect(results, isNotEmpty);
      expect(results.any((country) => country.name.toLowerCase().contains('united')), isTrue);
    });

    test('should get countries by region', () {
      final europeanCountries = CountryUtils.getCountriesByRegion('Europe');
      expect(europeanCountries, isNotEmpty);
      expect(europeanCountries.every((country) => country.region == 'Europe'), isTrue);
    });

    test('should get independent countries', () {
      final independentCountries = CountryUtils.getIndependentCountries();
      expect(independentCountries, isNotEmpty);
      expect(independentCountries.every((country) => country.isIndependent), isTrue);
    });

    test('should get UN member countries', () {
      final unMembers = CountryUtils.getUnMemberCountries();
      expect(unMembers, isNotEmpty);
      expect(unMembers.every((country) => country.isUnMember), isTrue);
    });

    test('should get all regions', () {
      final regions = CountryUtils.getAllRegions();
      expect(regions, isNotEmpty);
      expect(regions.contains('Europe'), isTrue);
      expect(regions.contains('Asia'), isTrue);
      expect(regions.contains('Americas'), isTrue);
      expect(regions.contains('Africa'), isTrue);
      expect(regions.contains('Oceania'), isTrue);
    });

    test('should format population', () {
      expect(CountryUtils.formatPopulation(1000), '1,000');
      expect(CountryUtils.formatPopulation(1000000), '1,000,000');
      expect(CountryUtils.formatPopulation(1234567), '1,234,567');
    });

    test('should format area', () {
      expect(CountryUtils.formatArea(1000.0), '1,000');
      expect(CountryUtils.formatArea(1000000.0), '1,000,000');
      expect(CountryUtils.formatArea(1234567.0), '1,234,567');
    });

    test('should get country flag emoji', () {
      expect(CountryUtils.getCountryFlagEmoji('US'), '🇺🇸');
      expect(CountryUtils.getCountryFlagEmoji('XX'), '🏳️');
    });

    test('should validate country codes', () {
      expect(CountryUtils.isValidAlpha2Code('US'), isTrue);
      expect(CountryUtils.isValidAlpha2Code('XX'), isFalse);
      expect(CountryUtils.isValidAlpha3Code('USA'), isTrue);
      expect(CountryUtils.isValidAlpha3Code('XXX'), isFalse);
      expect(CountryUtils.isValidNumericCode('840'), isTrue);
      expect(CountryUtils.isValidNumericCode('999'), isFalse);
    });
  });

  group('CountryNameL10n Tests', () {
    test('should have 132 supported locales', () {
      final locales = CountryNameL10n.supportedLocales;
      expect(locales, isNotEmpty);
      expect(locales.length, 132);
    });

    test('should contain common language codes', () {
      final locales = CountryNameL10n.supportedLocales;
      expect(locales, contains('en'));
      expect(locales, contains('ar'));
      expect(locales, contains('de'));
      expect(locales, contains('es'));
      expect(locales, contains('fr'));
      expect(locales, contains('hi'));
      expect(locales, contains('ja'));
      expect(locales, contains('ko'));
      expect(locales, contains('pt'));
      expect(locales, contains('ru'));
      expect(locales, contains('zh'));
    });

    test('should return localized name for valid country and language', () {
      // German name for United States
      final name = CountryNameL10n.getLocalizedName('US', 'de');
      expect(name, isNotNull);
      expect(name, contains('Vereinigte Staaten'));
    });

    test('should return Arabic name for a country', () {
      final name = CountryNameL10n.getLocalizedName('US', 'ar');
      expect(name, isNotNull);
      expect(name!.isNotEmpty, isTrue);
    });

    test('should return Japanese name for a country', () {
      final name = CountryNameL10n.getLocalizedName('JP', 'ja');
      expect(name, isNotNull);
      expect(name, contains('日本'));
    });

    test('should return null for invalid country code', () {
      final name = CountryNameL10n.getLocalizedName('XX', 'en');
      expect(name, isNull);
    });

    test('should return null for invalid language code', () {
      final name = CountryNameL10n.getLocalizedName('US', 'zzz');
      expect(name, isNull);
    });

    test('should return full translation map for a locale', () {
      final map = CountryNameL10n.getTranslationsForLocale('fr');
      expect(map, isNotNull);
      expect(map, isNotEmpty);
      expect(map!['FR'], isNotNull); // France in French
      expect(map['US'], isNotNull); // United States in French
    });

    test('should return null translation map for invalid locale', () {
      final map = CountryNameL10n.getTranslationsForLocale('zzz');
      expect(map, isNull);
    });
  });

  group('CountryUtils L10n Tests', () {
    test('should get country name in a specific language', () {
      final usa = CountryUtils.getCountryByAlpha2Code('US');
      expect(usa, isNotNull);

      final nameInGerman =
          CountryUtils.getCountryNameInLanguage(usa!, 'de');
      expect(nameInGerman, contains('Vereinigte Staaten'));

      final nameInFrench =
          CountryUtils.getCountryNameInLanguage(usa, 'fr');
      expect(nameInFrench, contains('États-Unis'));

      final nameInSpanish =
          CountryUtils.getCountryNameInLanguage(usa, 'es');
      expect(nameInSpanish, contains('Estados Unidos'));
    });

    test('should fall back to English name for unsupported language', () {
      final usa = CountryUtils.getCountryByAlpha2Code('US');
      expect(usa, isNotNull);

      final name =
          CountryUtils.getCountryNameInLanguage(usa!, 'zzz');
      expect(name, 'United States');
    });

    test('should prefer nameTranslations over built-in l10n', () {
      final country = Country(
        name: 'Test Country',
        nameTranslations: {'de': 'Custom German Name'},
        alpha2Code: 'US',
        alpha3Code: 'USA',
        numericCode: '840',
        flagEmoji: '',
        flagImagePath: '',
        capital: '',
        region: '',
        subregion: '',
        population: 0,
        area: 0,
        callingCodes: [],
        topLevelDomains: [],
        currencies: [],
        languages: [],
        timezones: [],
        borders: [],
        isIndependent: false,
        isUnMember: false,
      );

      final name =
          CountryUtils.getCountryNameInLanguage(country, 'de');
      expect(name, 'Custom German Name');
    });

    test('should get country names in all languages', () {
      final usa = CountryUtils.getCountryByAlpha2Code('US');
      expect(usa, isNotNull);

      final allNames =
          CountryUtils.getCountryNamesInAllLanguages(usa!);
      expect(allNames, isNotEmpty);
      expect(allNames.length, greaterThanOrEqualTo(130));
      expect(allNames['de'], isNotNull);
      expect(allNames['fr'], isNotNull);
      expect(allNames['ja'], isNotNull);
    });

    test('should return supported locales', () {
      final locales = CountryUtils.getSupportedLocales();
      expect(locales, isNotEmpty);
      expect(locales.length, 132);
      expect(locales, contains('en'));
      expect(locales, contains('zh'));
    });
  });

  group('Currency Model Tests', () {
    test('should create a currency with all properties', () {
      final currency = Currency(
        code: 'USD',
        name: 'United States dollar',
        symbol: '\$',
      );

      expect(currency.code, 'USD');
      expect(currency.name, 'United States dollar');
      expect(currency.symbol, '\$');
    });

    test('should support equality comparison', () {
      final currency1 = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
      final currency2 = Currency(code: 'USD', name: 'US Dollar', symbol: '\$');
      final currency3 = Currency(code: 'EUR', name: 'Euro', symbol: '€');

      expect(currency1, equals(currency2));
      expect(currency1, isNot(equals(currency3)));
    });
  });

  group('Language Model Tests', () {
    test('should create a language with all properties', () {
      final language = Language(
        iso6391: 'en',
        iso6392: 'eng',
        name: 'English',
        nativeName: 'English',
      );

      expect(language.iso6391, 'en');
      expect(language.iso6392, 'eng');
      expect(language.name, 'English');
      expect(language.nativeName, 'English');
    });

    test('should support equality comparison', () {
      final language1 = Language(
        iso6391: 'en',
        iso6392: 'eng',
        name: 'English',
        nativeName: 'English',
      );
      final language2 = Language(
        iso6391: 'en',
        iso6392: 'eng',
        name: 'English',
        nativeName: 'English',
      );
      final language3 = Language(
        iso6391: 'es',
        iso6392: 'spa',
        name: 'Spanish',
        nativeName: 'Español',
      );

      expect(language1, equals(language2));
      expect(language1, isNot(equals(language3)));
    });
  });
}