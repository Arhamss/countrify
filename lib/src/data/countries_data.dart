import '../models/country.dart';

/// {@template countries_data}
/// Comprehensive list of all countries with ISO 3166-1 codes
/// {@endtemplate}
class CountriesData {
  /// Private constructor to prevent instantiation
  CountriesData._();

  /// List of all countries
  static const List<Country> _countries = [
    // Afghanistan
    Country(
      name: 'Afghanistan',
      nameTranslations: {
        'en': 'Afghanistan',
        'fa': 'افغانستان',
        'ps': 'افغانستان',
      },
      alpha2Code: 'AF',
      alpha3Code: 'AFG',
      numericCode: '004',
      flagEmoji: '🇦🇫',
      flagImagePath: 'packages/countrify/src/flag_images/AF.png',
      capital: 'Kabul',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 38928346,
      area: 652230.0,
      callingCodes: ['93'],
      topLevelDomains: ['.af'],
      currencies: [
        Currency(code: 'AFN', name: 'Afghan afghani', symbol: '؋'),
      ],
      languages: [
        Language(iso6391: 'ps', iso6392: 'pus', name: 'Pashto', nativeName: 'پښتو'),
        Language(iso6391: 'fa', iso6392: 'fas', name: 'Persian', nativeName: 'فارسی'),
      ],
      timezones: ['UTC+04:30'],
      borders: ['IRN', 'PAK', 'TKM', 'UZB', 'TJK', 'CHN'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Albania
    Country(
      name: 'Albania',
      nameTranslations: {
        'en': 'Albania',
        'sq': 'Shqipëria',
      },
      alpha2Code: 'AL',
      alpha3Code: 'ALB',
      numericCode: '008',
      flagEmoji: '🇦🇱',
      flagImagePath: 'packages/countrify/src/flag_images/AL.png',
      capital: 'Tirana',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 2877797,
      area: 28748.0,
      callingCodes: ['355'],
      topLevelDomains: ['.al'],
      currencies: [
        Currency(code: 'ALL', name: 'Albanian lek', symbol: 'L'),
      ],
      languages: [
        Language(iso6391: 'sq', iso6392: 'sqi', name: 'Albanian', nativeName: 'Shqip'),
      ],
      timezones: ['UTC+01:00'],
      borders: ['MNE', 'GRC', 'MKD', 'KOS'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Algeria
    Country(
      name: 'Algeria',
      nameTranslations: {
        'en': 'Algeria',
        'ar': 'الجزائر',
      },
      alpha2Code: 'DZ',
      alpha3Code: 'DZA',
      numericCode: '012',
      flagEmoji: '🇩🇿',
      flagImagePath: 'packages/countrify/src/flag_images/DZ.png',
      capital: 'Algiers',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 43851044,
      area: 2381741.0,
      callingCodes: ['213'],
      topLevelDomains: ['.dz'],
      currencies: [
        Currency(code: 'DZD', name: 'Algerian dinar', symbol: 'د.ج'),
      ],
      languages: [
        Language(iso6391: 'ar', iso6392: 'ara', name: 'Arabic', nativeName: 'العربية'),
      ],
      timezones: ['UTC+01:00'],
      borders: ['TUN', 'LBY', 'NER', 'ESH', 'MRT', 'MLI', 'MAR'],
      isIndependent: true,
      isUnMember: true,
    ),

    // American Samoa
    Country(
      name: 'American Samoa',
      nameTranslations: {
        'en': 'American Samoa',
        'sm': 'Sāmoa Amelika',
      },
      alpha2Code: 'AS',
      alpha3Code: 'ASM',
      numericCode: '016',
      flagEmoji: '🇦🇸',
      flagImagePath: 'packages/countrify/src/flag_images/AS.png',
      capital: 'Pago Pago',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 55191,
      area: 199.0,
      callingCodes: ['1684'],
      topLevelDomains: ['.as'],
      currencies: [
        Currency(code: 'USD', name: 'United States dollar', symbol: '\$'),
      ],
      languages: [
        Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English'),
        Language(iso6391: 'sm', iso6392: 'smo', name: 'Samoan', nativeName: 'gagana fa\'a Samoa'),
      ],
      timezones: ['UTC-11:00'],
      borders: [],
      isIndependent: false,
      isUnMember: false,
    ),

    // Andorra
    Country(
      name: 'Andorra',
      nameTranslations: {
        'en': 'Andorra',
        'ca': 'Andorra',
      },
      alpha2Code: 'AD',
      alpha3Code: 'AND',
      numericCode: '020',
      flagEmoji: '🇦🇩',
      flagImagePath: 'packages/countrify/src/flag_images/AD.png',
      capital: 'Andorra la Vella',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 77265,
      area: 468.0,
      callingCodes: ['376'],
      topLevelDomains: ['.ad'],
      currencies: [
        Currency(code: 'EUR', name: 'Euro', symbol: '€'),
      ],
      languages: [
        Language(iso6391: 'ca', iso6392: 'cat', name: 'Catalan', nativeName: 'català'),
      ],
      timezones: ['UTC+01:00'],
      borders: ['FRA', 'ESP'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Angola
    Country(
      name: 'Angola',
      nameTranslations: {
        'en': 'Angola',
        'pt': 'Angola',
      },
      alpha2Code: 'AO',
      alpha3Code: 'AGO',
      numericCode: '024',
      flagEmoji: '🇦🇴',
      flagImagePath: 'packages/countrify/src/flag_images/AO.png',
      capital: 'Luanda',
      region: 'Africa',
      subregion: 'Middle Africa',
      population: 32866272,
      area: 1246700.0,
      callingCodes: ['244'],
      topLevelDomains: ['.ao'],
      currencies: [
        Currency(code: 'AOA', name: 'Angolan kwanza', symbol: 'Kz'),
      ],
      languages: [
        Language(iso6391: 'pt', iso6392: 'por', name: 'Portuguese', nativeName: 'Português'),
      ],
      timezones: ['UTC+01:00'],
      borders: ['COG', 'COD', 'ZMB', 'NAM'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Anguilla
    Country(
      name: 'Anguilla',
      nameTranslations: {
        'en': 'Anguilla',
      },
      alpha2Code: 'AI',
      alpha3Code: 'AIA',
      numericCode: '660',
      flagEmoji: '🇦🇮',
      flagImagePath: 'packages/countrify/src/flag_images/AI.png',
      capital: 'The Valley',
      region: 'Americas',
      subregion: 'Caribbean',
      population: 15003,
      area: 91.0,
      callingCodes: ['1264'],
      topLevelDomains: ['.ai'],
      currencies: [
        Currency(code: 'XCD', name: 'East Caribbean dollar', symbol: '\$'),
      ],
      languages: [
        Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English'),
      ],
      timezones: ['UTC-04:00'],
      borders: [],
      isIndependent: false,
      isUnMember: false,
    ),

    // Antarctica
    Country(
      name: 'Antarctica',
      nameTranslations: {
        'en': 'Antarctica',
      },
      alpha2Code: 'AQ',
      alpha3Code: 'ATA',
      numericCode: '010',
      flagEmoji: '🇦🇶',
      flagImagePath: 'packages/countrify/src/flag_images/AQ.png',
      capital: '',
      region: 'Antarctic',
      subregion: '',
      population: 0,
      area: 14000000.0,
      callingCodes: [],
      topLevelDomains: ['.aq'],
      currencies: [],
      languages: [],
      timezones: [],
      borders: [],
      isIndependent: false,
      isUnMember: false,
    ),

    // Antigua and Barbuda
    Country(
      name: 'Antigua and Barbuda',
      nameTranslations: {
        'en': 'Antigua and Barbuda',
      },
      alpha2Code: 'AG',
      alpha3Code: 'ATG',
      numericCode: '028',
      flagEmoji: '🇦🇬',
      flagImagePath: 'packages/countrify/src/flag_images/AG.png',
      capital: 'Saint John\'s',
      region: 'Americas',
      subregion: 'Caribbean',
      population: 97929,
      area: 442.0,
      callingCodes: ['1268'],
      topLevelDomains: ['.ag'],
      currencies: [
        Currency(code: 'XCD', name: 'East Caribbean dollar', symbol: '\$'),
      ],
      languages: [
        Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English'),
      ],
      timezones: ['UTC-04:00'],
      borders: [],
      isIndependent: true,
      isUnMember: true,
    ),

    // Argentina
    Country(
      name: 'Argentina',
      nameTranslations: {
        'en': 'Argentina',
        'es': 'Argentina',
      },
      alpha2Code: 'AR',
      alpha3Code: 'ARG',
      numericCode: '032',
      flagEmoji: '🇦🇷',
      flagImagePath: 'packages/countrify/src/flag_images/AR.png',
      capital: 'Buenos Aires',
      region: 'Americas',
      subregion: 'South America',
      population: 45195774,
      area: 2780400.0,
      callingCodes: ['54'],
      topLevelDomains: ['.ar'],
      currencies: [
        Currency(code: 'ARS', name: 'Argentine peso', symbol: '\$'),
      ],
      languages: [
        Language(iso6391: 'es', iso6392: 'spa', name: 'Spanish', nativeName: 'Español'),
      ],
      timezones: ['UTC-03:00'],
      borders: ['BOL', 'BRA', 'CHL', 'PRY', 'URY'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Armenia
    Country(
      name: 'Armenia',
      nameTranslations: {
        'en': 'Armenia',
        'hy': 'Հայաստան',
      },
      alpha2Code: 'AM',
      alpha3Code: 'ARM',
      numericCode: '051',
      flagEmoji: '🇦🇲',
      flagImagePath: 'packages/countrify/src/flag_images/AM.png',
      capital: 'Yerevan',
      region: 'Asia',
      subregion: 'Western Asia',
      population: 2963243,
      area: 29743.0,
      callingCodes: ['374'],
      topLevelDomains: ['.am'],
      currencies: [
        Currency(code: 'AMD', name: 'Armenian dram', symbol: '֏'),
      ],
      languages: [
        Language(iso6391: 'hy', iso6392: 'hye', name: 'Armenian', nativeName: 'Հայերեն'),
      ],
      timezones: ['UTC+04:00'],
      borders: ['AZE', 'GEO', 'IRN', 'TUR'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Aruba
    Country(
      name: 'Aruba',
      nameTranslations: {
        'en': 'Aruba',
        'nl': 'Aruba',
        'pap': 'Aruba',
      },
      alpha2Code: 'AW',
      alpha3Code: 'ABW',
      numericCode: '533',
      flagEmoji: '🇦🇼',
      flagImagePath: 'packages/countrify/src/flag_images/AW.png',
      capital: 'Oranjestad',
      region: 'Americas',
      subregion: 'Caribbean',
      population: 106766,
      area: 180.0,
      callingCodes: ['297'],
      topLevelDomains: ['.aw'],
      currencies: [
        Currency(code: 'AWG', name: 'Aruban florin', symbol: 'ƒ'),
      ],
      languages: [
        Language(iso6391: 'nl', iso6392: 'nld', name: 'Dutch', nativeName: 'Nederlands'),
        Language(iso6391: 'pap', iso6392: 'pap', name: 'Papiamento', nativeName: 'Papiamentu'),
      ],
      timezones: ['UTC-04:00'],
      borders: [],
      isIndependent: false,
      isUnMember: false,
    ),

    // Australia
    Country(
      name: 'Australia',
      nameTranslations: {
        'en': 'Australia',
      },
      alpha2Code: 'AU',
      alpha3Code: 'AUS',
      numericCode: '036',
      flagEmoji: '🇦🇺',
      flagImagePath: 'packages/countrify/src/flag_images/AU.png',
      capital: 'Canberra',
      region: 'Oceania',
      subregion: 'Australia and New Zealand',
      population: 25499884,
      area: 7692024.0,
      callingCodes: ['61'],
      topLevelDomains: ['.au'],
      currencies: [
        Currency(code: 'AUD', name: 'Australian dollar', symbol: '\$'),
      ],
      languages: [
        Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English'),
      ],
      timezones: ['UTC+05:00', 'UTC+06:30', 'UTC+07:00', 'UTC+08:00', 'UTC+09:30', 'UTC+10:00', 'UTC+10:30', 'UTC+11:30'],
      borders: [],
      isIndependent: true,
      isUnMember: true,
    ),

    // Austria
    Country(
      name: 'Austria',
      nameTranslations: {
        'en': 'Austria',
        'de': 'Österreich',
      },
      alpha2Code: 'AT',
      alpha3Code: 'AUT',
      numericCode: '040',
      flagEmoji: '🇦🇹',
      flagImagePath: 'packages/countrify/src/flag_images/AT.png',
      capital: 'Vienna',
      region: 'Europe',
      subregion: 'Central Europe',
      population: 9006398,
      area: 83871.0,
      callingCodes: ['43'],
      topLevelDomains: ['.at'],
      currencies: [
        Currency(code: 'EUR', name: 'Euro', symbol: '€'),
      ],
      languages: [
        Language(iso6391: 'de', iso6392: 'deu', name: 'German', nativeName: 'Deutsch'),
      ],
      timezones: ['UTC+01:00'],
      borders: ['CZE', 'DEU', 'HUN', 'ITA', 'LIE', 'SVK', 'SVN', 'CHE'],
      isIndependent: true,
      isUnMember: true,
    ),

    // Azerbaijan
    Country(
      name: 'Azerbaijan',
      nameTranslations: {
        'en': 'Azerbaijan',
        'az': 'Azərbaycan',
      },
      alpha2Code: 'AZ',
      alpha3Code: 'AZE',
      numericCode: '031',
      flagEmoji: '🇦🇿',
      flagImagePath: 'packages/countrify/src/flag_images/AZ.png',
      capital: 'Baku',
      region: 'Asia',
      subregion: 'Western Asia',
      population: 10139177,
      area: 86600.0,
      callingCodes: ['994'],
      topLevelDomains: ['.az'],
      currencies: [
        Currency(code: 'AZN', name: 'Azerbaijani manat', symbol: '₼'),
      ],
      languages: [
        Language(iso6391: 'az', iso6392: 'aze', name: 'Azerbaijani', nativeName: 'azərbaycan dili'),
      ],
      timezones: ['UTC+04:00'],
      borders: ['ARM', 'GEO', 'IRN', 'RUS', 'TUR'],
      isIndependent: true,
      isUnMember: true,
    ),
  ];

  /// Get all countries
  static List<Country> get all => List.unmodifiable(_countries);

  /// Get countries by region
  static List<Country> getByRegion(String region) {
    return _countries.where((country) => country.region == region).toList();
  }

  /// Get countries by subregion
  static List<Country> getBySubregion(String subregion) {
    return _countries.where((country) => country.subregion == subregion).toList();
  }

  /// Get country by alpha-2 code
  static Country? getByAlpha2Code(String alpha2Code) {
    try {
      return _countries.firstWhere((country) => country.alpha2Code == alpha2Code.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  /// Get country by alpha-3 code
  static Country? getByAlpha3Code(String alpha3Code) {
    try {
      return _countries.firstWhere((country) => country.alpha3Code == alpha3Code.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  /// Get country by numeric code
  static Country? getByNumericCode(String numericCode) {
    try {
      return _countries.firstWhere((country) => country.numericCode == numericCode);
    } catch (e) {
      return null;
    }
  }

  /// Search countries by name
  static List<Country> searchByName(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _countries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery) ||
          country.nameTranslations.values.any((translation) => 
              translation.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  /// Get independent countries only
  static List<Country> get independent => 
      _countries.where((country) => country.isIndependent).toList();

  /// Get UN member countries only
  static List<Country> get unMembers => 
      _countries.where((country) => country.isUnMember).toList();
}
