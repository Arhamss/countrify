import '../data/all_countries.dart';
import '../l10n/country_name_l10n.dart';
import '../models/country.dart';

/// {@template country_utils}
/// Utility functions for working with country data
/// {@endtemplate}
class CountryUtils {
  CountryUtils._();

  /// Get all countries
  static List<Country> getAllCountries() => AllCountries.all;

  /// Get countries by region
  static List<Country> getCountriesByRegion(String region) => 
      AllCountries.getByRegion(region);

  /// Get countries by subregion
  static List<Country> getCountriesBySubregion(String subregion) => 
      AllCountries.getBySubregion(subregion);

  /// Get country by alpha-2 code
  static Country? getCountryByAlpha2Code(String alpha2Code) => 
      AllCountries.getByAlpha2Code(alpha2Code);

  /// Get country by alpha-3 code
  static Country? getCountryByAlpha3Code(String alpha3Code) => 
      AllCountries.getByAlpha3Code(alpha3Code);

  /// Get country by numeric code
  static Country? getCountryByNumericCode(String numericCode) => 
      AllCountries.getByNumericCode(numericCode);

  /// Search countries by name
  static List<Country> searchCountries(String query) => 
      AllCountries.searchByName(query);

  /// Get independent countries only
  static List<Country> getIndependentCountries() => AllCountries.independent;

  /// Get UN member countries only
  static List<Country> getUnMemberCountries() => AllCountries.unMembers;

  /// Get all unique regions
  static List<String> getAllRegions() {
    final regions = <String>{};
    for (final country in AllCountries.all) {
      if (country.region.isNotEmpty) {
        regions.add(country.region);
      }
    }
    return regions.toList()..sort();
  }

  /// Get all unique subregions
  static List<String> getAllSubregions() {
    final subregions = <String>{};
    for (final country in AllCountries.all) {
      if (country.subregion.isNotEmpty) {
        subregions.add(country.subregion);
      }
    }
    return subregions.toList()..sort();
  }

  /// Get all unique subregions for a specific region
  static List<String> getSubregionsByRegion(String region) {
    final subregions = <String>{};
    for (final country in AllCountries.all) {
      if (country.region == region && country.subregion.isNotEmpty) {
        subregions.add(country.subregion);
      }
    }
    return subregions.toList()..sort();
  }

  /// Get countries by calling code
  static List<Country> getCountriesByCallingCode(String callingCode) {
    return AllCountries.all.where((country) => 
        country.callingCodes.contains(callingCode)).toList();
  }

  /// Get countries by currency code
  static List<Country> getCountriesByCurrencyCode(String currencyCode) {
    return AllCountries.all.where((country) => 
        country.currencies.any((currency) => currency.code == currencyCode)).toList();
  }

  /// Get countries by language code
  static List<Country> getCountriesByLanguageCode(String languageCode) {
    return AllCountries.all.where((country) => 
        country.languages.any((language) => 
            language.iso6391 == languageCode || language.iso6392 == languageCode)).toList();
  }

  /// Get countries by timezone
  static List<Country> getCountriesByTimezone(String timezone) {
    return AllCountries.all.where((country) => 
        country.timezones.contains(timezone)).toList();
  }

  /// Get countries that border a specific country
  static List<Country> getBorderCountries(String alpha3Code) {
    final country = getCountryByAlpha3Code(alpha3Code);
    if (country == null) return [];

    return country.borders
        .map((borderCode) => getCountryByAlpha3Code(borderCode))
        .where((borderCountry) => borderCountry != null)
        .cast<Country>()
        .toList();
  }

  /// Get countries with population greater than specified value
  static List<Country> getCountriesByMinPopulation(int minPopulation) {
    return AllCountries.all.where((country) => 
        country.population >= minPopulation).toList();
  }

  /// Get countries with area greater than specified value
  static List<Country> getCountriesByMinArea(double minArea) {
    return AllCountries.all.where((country) => 
        country.area >= minArea).toList();
  }

  /// Get countries sorted by population (descending)
  static List<Country> getCountriesSortedByPopulation() {
    final countries = List<Country>.from(AllCountries.all);
    countries.sort((a, b) => b.population.compareTo(a.population));
    return countries;
  }

  /// Get countries sorted by area (descending)
  static List<Country> getCountriesSortedByArea() {
    final countries = List<Country>.from(AllCountries.all);
    countries.sort((a, b) => b.area.compareTo(a.area));
    return countries;
  }

  /// Get countries sorted by name (ascending)
  static List<Country> getCountriesSortedByName() {
    final countries = List<Country>.from(AllCountries.all);
    countries.sort((a, b) => a.name.compareTo(b.name));
    return countries;
  }

  /// Get the most populous country
  static Country? getMostPopulousCountry() {
    if (AllCountries.all.isEmpty) return null;
    return AllCountries.all.reduce((a, b) => 
        a.population > b.population ? a : b);
  }

  /// Get the largest country by area
  static Country? getLargestCountry() {
    if (AllCountries.all.isEmpty) return null;
    return AllCountries.all.reduce((a, b) => 
        a.area > b.area ? a : b);
  }

  /// Get the smallest country by area
  static Country? getSmallestCountry() {
    if (AllCountries.all.isEmpty) return null;
    return AllCountries.all.reduce((a, b) => 
        a.area < b.area ? a : b);
  }

  /// Get total world population
  static int getTotalWorldPopulation() {
    return AllCountries.all.fold(0, (sum, country) => sum + country.population);
  }

  /// Get total world area
  static double getTotalWorldArea() {
    return AllCountries.all.fold(0, (sum, country) => sum + country.area);
  }

  /// Get average population per country
  static double getAveragePopulation() {
    if (AllCountries.all.isEmpty) return 0;
    return getTotalWorldPopulation() / AllCountries.all.length;
  }

  /// Get average area per country
  static double getAverageArea() {
    if (AllCountries.all.isEmpty) return 0;
    return getTotalWorldArea() / AllCountries.all.length;
  }

  /// Get countries count by region
  static Map<String, int> getCountriesCountByRegion() {
    final counts = <String, int>{};
    for (final country in AllCountries.all) {
      counts[country.region] = (counts[country.region] ?? 0) + 1;
    }
    return counts;
  }

  /// Get countries count by subregion
  static Map<String, int> getCountriesCountBySubregion() {
    final counts = <String, int>{};
    for (final country in AllCountries.all) {
      counts[country.subregion] = (counts[country.subregion] ?? 0) + 1;
    }
    return counts;
  }

  /// Get all unique currencies
  static List<Currency> getAllCurrencies() {
    final currencies = <Currency>[];
    final currencyCodes = <String>{};
    
    for (final country in AllCountries.all) {
      for (final currency in country.currencies) {
        if (!currencyCodes.contains(currency.code)) {
          currencyCodes.add(currency.code);
          currencies.add(currency);
        }
      }
    }
    
    return currencies..sort((a, b) => a.code.compareTo(b.code));
  }

  /// Get all unique languages
  static List<Language> getAllLanguages() {
    final languages = <Language>[];
    final languageCodes = <String>{};
    
    for (final country in AllCountries.all) {
      for (final language in country.languages) {
        if (!languageCodes.contains(language.iso6391)) {
          languageCodes.add(language.iso6391);
          languages.add(language);
        }
      }
    }
    
    return languages..sort((a, b) => a.name.compareTo(b.name));
  }

  /// Get all unique timezones
  static List<String> getAllTimezones() {
    final timezones = <String>{};
    for (final country in AllCountries.all) {
      timezones.addAll(country.timezones);
    }
    return timezones.toList()..sort();
  }

  /// Get all unique calling codes
  static List<String> getAllCallingCodes() {
    final callingCodes = <String>{};
    for (final country in AllCountries.all) {
      callingCodes.addAll(country.callingCodes);
    }
    return callingCodes.toList()..sort();
  }

  /// Get all unique top-level domains
  static List<String> getAllTopLevelDomains() {
    final domains = <String>{};
    for (final country in AllCountries.all) {
      domains.addAll(country.topLevelDomains);
    }
    return domains.toList()..sort();
  }

  /// Check if a country code is valid
  static bool isValidAlpha2Code(String code) => 
      getCountryByAlpha2Code(code) != null;

  /// Check if a country code is valid
  static bool isValidAlpha3Code(String code) => 
      getCountryByAlpha3Code(code) != null;

  /// Check if a numeric code is valid
  static bool isValidNumericCode(String code) => 
      getCountryByNumericCode(code) != null;

  /// Get country name in a specific language.
  ///
  /// Checks the country's [nameTranslations] first, then falls back to the
  /// built-in l10n data (132 languages via CLDR).
  static String getCountryNameInLanguage(
    Country country,
    String languageCode,
  ) {
    return country.nameTranslations[languageCode] ??
        CountryNameL10n.getLocalizedName(country.alpha2Code, languageCode) ??
        country.name;
  }

  /// Get country names in all available languages.
  ///
  /// Merges the country's [nameTranslations] with the built-in l10n data.
  static Map<String, String> getCountryNamesInAllLanguages(Country country) {
    final merged = <String, String>{...country.nameTranslations};
    for (final locale in CountryNameL10n.supportedLocales) {
      if (!merged.containsKey(locale)) {
        final name = CountryNameL10n.getLocalizedName(
          country.alpha2Code,
          locale,
        );
        if (name != null) merged[locale] = name;
      }
    }
    return merged;
  }

  /// Get the list of supported locale codes for country name translations.
  static List<String> getSupportedLocales() =>
      CountryNameL10n.supportedLocales;

  /// Format population number with commas
  static String formatPopulation(int population) {
    return population.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }

  /// Format area number with commas
  static String formatArea(double area) {
    return area.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }

  /// Get country flag emoji
  static String getCountryFlagEmoji(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.flagEmoji ?? '🏳️';
  }

  /// Get country flag image path
  static String getCountryFlagImagePath(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.flagImagePath ?? '';
  }

  /// Get country calling code
  static String? getCountryCallingCode(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.callingCodes.isNotEmpty == true 
        ? country!.callingCodes.first 
        : null;
  }

  /// Get country currency
  static Currency? getCountryCurrency(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.currencies.isNotEmpty == true 
        ? country!.currencies.first 
        : null;
  }

  /// Get country primary language
  static Language? getCountryPrimaryLanguage(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.languages.isNotEmpty == true 
        ? country!.languages.first 
        : null;
  }

  /// Get country timezone
  static String? getCountryTimezone(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.timezones.isNotEmpty == true 
        ? country!.timezones.first 
        : null;
  }

  /// Get country capital
  static String? getCountryCapital(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.capital;
  }

  /// Get country region
  static String? getCountryRegion(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.region;
  }

  /// Get country subregion
  static String? getCountrySubregion(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.subregion;
  }

  /// Get country population
  static int? getCountryPopulation(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.population;
  }

  /// Get country area
  static double? getCountryArea(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.area;
  }

  /// Check if country is independent
  static bool isCountryIndependent(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.isIndependent ?? false;
  }

  /// Check if country is UN member
  static bool isCountryUnMember(String alpha2Code) {
    final country = getCountryByAlpha2Code(alpha2Code);
    return country?.isUnMember ?? false;
  }
}
