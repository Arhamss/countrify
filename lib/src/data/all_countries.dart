import '../models/country.dart';

/// Complete list of all countries with ISO 3166-1 codes
/// Generated from CSV data
class AllCountries {
  AllCountries._();

  /// Complete list of all countries
  static const List<Country> _allCountries = [
    // Afghanistan
    Country(
      name: 'Afghanistan',
      nameTranslations: {'en': 'Afghanistan'},
      alpha2Code: 'AF',
      alpha3Code: 'AFG',
      numericCode: '004',
      flagEmoji: '🇦🇫',
      flagImagePath: 'packages/countrify/assets/images/flags/AF.png',
      capital: 'Kabul',
      largestCity: 'Kabul',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 38041754,
      area: 0.0, // Not available in CSV
      callingCodes: ['93'],
      topLevelDomains: ['.af'],
      currencies: [Currency(code: 'AFN', name: 'AFN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Pashto', nativeName: 'Pashto')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Albania
    Country(
      name: 'Albania',
      nameTranslations: {'en': 'Albania'},
      alpha2Code: 'AL',
      alpha3Code: 'ALB',
      numericCode: '008',
      flagEmoji: '🇦🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/AL.png',
      capital: 'Tirana',
      largestCity: 'Tirana',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 2854191,
      area: 0.0, // Not available in CSV
      callingCodes: ['355'],
      topLevelDomains: ['.al'],
      currencies: [Currency(code: 'ALL', name: 'ALL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Albanian', nativeName: 'Albanian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Algeria
    Country(
      name: 'Algeria',
      nameTranslations: {'en': 'Algeria'},
      alpha2Code: 'DZ',
      alpha3Code: 'DZA',
      numericCode: '012',
      flagEmoji: '🇩🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/DZ.png',
      capital: 'Algiers',
      largestCity: 'Algiers',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 43053054,
      area: 0.0, // Not available in CSV
      callingCodes: ['213'],
      topLevelDomains: ['.dz'],
      currencies: [Currency(code: 'DZD', name: 'DZD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Andorra
    Country(
      name: 'Andorra',
      nameTranslations: {'en': 'Andorra'},
      alpha2Code: 'AD',
      alpha3Code: 'AND',
      numericCode: '020',
      flagEmoji: '🇦🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/AD.png',
      capital: 'Andorra la Vella',
      largestCity: 'Andorra la Vella',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 77142,
      area: 0.0, // Not available in CSV
      callingCodes: ['376'],
      topLevelDomains: ['.ad'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Catalan', nativeName: 'Catalan')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Angola
    Country(
      name: 'Angola',
      nameTranslations: {'en': 'Angola'},
      alpha2Code: 'AO',
      alpha3Code: 'AGO',
      numericCode: '024',
      flagEmoji: '🇦🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/AO.png',
      capital: 'Luanda',
      largestCity: 'Luanda',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 31825295,
      area: 0.0, // Not available in CSV
      callingCodes: ['244'],
      topLevelDomains: ['.ao'],
      currencies: [Currency(code: 'AOA', name: 'AOA', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Antigua and Barbuda
    Country(
      name: 'Antigua and Barbuda',
      nameTranslations: {'en': 'Antigua and Barbuda'},
      alpha2Code: 'AG',
      alpha3Code: 'ATG',
      numericCode: '028',
      flagEmoji: '🇦🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/AG.png',
      capital: 'St. John\'s, Saint John',
      largestCity: 'St. John\'s, Saint John',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 97118,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.ag'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Argentina
    Country(
      name: 'Argentina',
      nameTranslations: {'en': 'Argentina'},
      alpha2Code: 'AR',
      alpha3Code: 'ARG',
      numericCode: '032',
      flagEmoji: '🇦🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/AR.png',
      capital: 'Buenos Aires',
      largestCity: 'Buenos Aires',
      region: 'Americas',
      subregion: 'South America',
      population: 44938712,
      area: 0.0, // Not available in CSV
      callingCodes: ['54'],
      topLevelDomains: ['.ar'],
      currencies: [Currency(code: 'ARS', name: 'ARS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Armenia
    Country(
      name: 'Armenia',
      nameTranslations: {'en': 'Armenia'},
      alpha2Code: 'AM',
      alpha3Code: 'ARM',
      numericCode: '051',
      flagEmoji: '🇦🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/AM.png',
      capital: 'Yerevan',
      largestCity: 'Yerevan',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 2957731,
      area: 0.0, // Not available in CSV
      callingCodes: ['374'],
      topLevelDomains: ['.am'],
      currencies: [Currency(code: 'AMD', name: 'AMD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Armenian', nativeName: 'Armenian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Australia
    Country(
      name: 'Australia',
      nameTranslations: {'en': 'Australia'},
      alpha2Code: 'AU',
      alpha3Code: 'AUS',
      numericCode: '036',
      flagEmoji: '🇦🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/AU.png',
      capital: 'Canberra',
      largestCity: 'Sydney',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 25766605,
      area: 0.0, // Not available in CSV
      callingCodes: ['61'],
      topLevelDomains: ['.au'],
      currencies: [Currency(code: 'AUD', name: 'AUD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Austria
    Country(
      name: 'Austria',
      nameTranslations: {'en': 'Austria'},
      alpha2Code: 'AT',
      alpha3Code: 'AUT',
      numericCode: '040',
      flagEmoji: '🇦🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/AT.png',
      capital: 'Vienna',
      largestCity: 'Vienna',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 8877067,
      area: 0.0, // Not available in CSV
      callingCodes: ['43'],
      topLevelDomains: ['.at'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'German', nativeName: 'German')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Azerbaijan
    Country(
      name: 'Azerbaijan',
      nameTranslations: {'en': 'Azerbaijan'},
      alpha2Code: 'AZ',
      alpha3Code: 'AZE',
      numericCode: '031',
      flagEmoji: '🇦🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/AZ.png',
      capital: 'Baku',
      largestCity: 'Baku',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 10023318,
      area: 0.0, // Not available in CSV
      callingCodes: ['994'],
      topLevelDomains: ['.az'],
      currencies: [Currency(code: 'AZN', name: 'AZN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Azerbaijani', nativeName: 'Azerbaijani')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // The Bahamas
    Country(
      name: 'The Bahamas',
      nameTranslations: {'en': 'The Bahamas'},
      alpha2Code: 'BS',
      alpha3Code: 'BHS',
      numericCode: '044',
      flagEmoji: '🇧🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/BS.png',
      capital: 'Nassau, Bahamas',
      largestCity: 'Nassau',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 389482,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.bs'],
      currencies: [Currency(code: 'BSD', name: 'BSD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bahrain
    Country(
      name: 'Bahrain',
      nameTranslations: {'en': 'Bahrain'},
      alpha2Code: 'BH',
      alpha3Code: 'BHR',
      numericCode: '048',
      flagEmoji: '🇧🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/BH.png',
      capital: 'Manama',
      largestCity: 'Riffa',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 1501635,
      area: 0.0, // Not available in CSV
      callingCodes: ['973'],
      topLevelDomains: ['.bh'],
      currencies: [Currency(code: 'BHD', name: 'BHD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bangladesh
    Country(
      name: 'Bangladesh',
      nameTranslations: {'en': 'Bangladesh'},
      alpha2Code: 'BD',
      alpha3Code: 'BGD',
      numericCode: '050',
      flagEmoji: '🇧🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/BD.png',
      capital: 'Dhaka',
      largestCity: 'Dhaka',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 167310838,
      area: 0.0, // Not available in CSV
      callingCodes: ['880'],
      topLevelDomains: ['.bd'],
      currencies: [Currency(code: 'BDT', name: 'BDT', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Bengali', nativeName: 'Bengali')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Barbados
    Country(
      name: 'Barbados',
      nameTranslations: {'en': 'Barbados'},
      alpha2Code: 'BB',
      alpha3Code: 'BRB',
      numericCode: '052',
      flagEmoji: '🇧🇧',
      flagImagePath: 'packages/countrify/assets/images/flags/BB.png',
      capital: 'Bridgetown',
      largestCity: 'Bridgetown',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 287025,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.bb'],
      currencies: [Currency(code: 'BBD', name: 'BBD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Belarus
    Country(
      name: 'Belarus',
      nameTranslations: {'en': 'Belarus'},
      alpha2Code: 'BY',
      alpha3Code: 'BLR',
      numericCode: '112',
      flagEmoji: '🇧🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/BY.png',
      capital: 'Minsk',
      largestCity: 'Minsk',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 9466856,
      area: 0.0, // Not available in CSV
      callingCodes: ['375'],
      topLevelDomains: ['.by'],
      currencies: [Currency(code: 'BYN', name: 'BYN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Russian', nativeName: 'Russian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Belgium
    Country(
      name: 'Belgium',
      nameTranslations: {'en': 'Belgium'},
      alpha2Code: 'BE',
      alpha3Code: 'BEL',
      numericCode: '056',
      flagEmoji: '🇧🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/BE.png',
      capital: 'City of Brussels',
      largestCity: 'Brussels',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 11484055,
      area: 0.0, // Not available in CSV
      callingCodes: ['32'],
      topLevelDomains: ['.be'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Belize
    Country(
      name: 'Belize',
      nameTranslations: {'en': 'Belize'},
      alpha2Code: 'BZ',
      alpha3Code: 'BLZ',
      numericCode: '084',
      flagEmoji: '🇧🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/BZ.png',
      capital: 'Belmopan',
      largestCity: 'Belize City',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 390353,
      area: 0.0, // Not available in CSV
      callingCodes: ['501'],
      topLevelDomains: ['.bz'],
      currencies: [Currency(code: 'BZD', name: 'BZD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Benin
    Country(
      name: 'Benin',
      nameTranslations: {'en': 'Benin'},
      alpha2Code: 'BJ',
      alpha3Code: 'BEN',
      numericCode: '204',
      flagEmoji: '🇧🇯',
      flagImagePath: 'packages/countrify/assets/images/flags/BJ.png',
      capital: 'Porto-Novo',
      largestCity: 'Cotonou',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 11801151,
      area: 0.0, // Not available in CSV
      callingCodes: ['229'],
      topLevelDomains: ['.bj'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bhutan
    Country(
      name: 'Bhutan',
      nameTranslations: {'en': 'Bhutan'},
      alpha2Code: 'BT',
      alpha3Code: 'BTN',
      numericCode: '064',
      flagEmoji: '🇧🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/BT.png',
      capital: 'Thimphu',
      largestCity: 'Thimphu',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 727145,
      area: 0.0, // Not available in CSV
      callingCodes: ['975'],
      topLevelDomains: ['.bt'],
      currencies: [Currency(code: 'BTN', name: 'BTN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Dzongkha', nativeName: 'Dzongkha')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bolivia
    Country(
      name: 'Bolivia',
      nameTranslations: {'en': 'Bolivia'},
      alpha2Code: 'BO',
      alpha3Code: 'BOL',
      numericCode: '068',
      flagEmoji: '🇧🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/BO.png',
      capital: 'Sucre',
      largestCity: 'Santa Cruz de la Sierra',
      region: 'Americas',
      subregion: 'Central America',
      population: 11513100,
      area: 0.0, // Not available in CSV
      callingCodes: ['591'],
      topLevelDomains: ['.bo'],
      currencies: [Currency(code: 'BOB', name: 'BOB', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bosnia and Herzegovina
    Country(
      name: 'Bosnia and Herzegovina',
      nameTranslations: {'en': 'Bosnia and Herzegovina'},
      alpha2Code: 'BA',
      alpha3Code: 'BIH',
      numericCode: '070',
      flagEmoji: '🇧🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/BA.png',
      capital: 'Sarajevo',
      largestCity: 'Tuzla Canton',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 3301000,
      area: 0.0, // Not available in CSV
      callingCodes: ['387'],
      topLevelDomains: ['.ba'],
      currencies: [Currency(code: 'BAM', name: 'BAM', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Bosnian', nativeName: 'Bosnian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Botswana
    Country(
      name: 'Botswana',
      nameTranslations: {'en': 'Botswana'},
      alpha2Code: 'BW',
      alpha3Code: 'BWA',
      numericCode: '072',
      flagEmoji: '🇧🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/BW.png',
      capital: 'Gaborone',
      largestCity: 'Gaborone',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 2346179,
      area: 0.0, // Not available in CSV
      callingCodes: ['267'],
      topLevelDomains: ['.bw'],
      currencies: [Currency(code: 'BWP', name: 'BWP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Brazil
    Country(
      name: 'Brazil',
      nameTranslations: {'en': 'Brazil'},
      alpha2Code: 'BR',
      alpha3Code: 'BRA',
      numericCode: '076',
      flagEmoji: '🇧🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/BR.png',
      capital: 'Bras',
      largestCity: 'Minsk',
      region: 'Americas',
      subregion: 'Central America',
      population: 212559417,
      area: 0.0, // Not available in CSV
      callingCodes: ['55'],
      topLevelDomains: ['.br'],
      currencies: [Currency(code: 'BRL', name: 'BRL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Brunei
    Country(
      name: 'Brunei',
      nameTranslations: {'en': 'Brunei'},
      alpha2Code: 'BN',
      alpha3Code: 'BRN',
      numericCode: '096',
      flagEmoji: '🇧🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/BN.png',
      capital: 'Bandar Seri Begawan',
      largestCity: 'BND',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 433285,
      area: 0.0, // Not available in CSV
      callingCodes: ['673'],
      topLevelDomains: ['.bn'],
      currencies: [Currency(code: 'BND', name: 'BND', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Malay', nativeName: 'Malay')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Bulgaria
    Country(
      name: 'Bulgaria',
      nameTranslations: {'en': 'Bulgaria'},
      alpha2Code: 'BG',
      alpha3Code: 'BGR',
      numericCode: '100',
      flagEmoji: '🇧🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/BG.png',
      capital: 'Sofia',
      largestCity: 'Sofia',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 6975761,
      area: 0.0, // Not available in CSV
      callingCodes: ['359'],
      topLevelDomains: ['.bg'],
      currencies: [Currency(code: 'BGN', name: 'BGN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Bulgarian', nativeName: 'Bulgarian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Burkina Faso
    Country(
      name: 'Burkina Faso',
      nameTranslations: {'en': 'Burkina Faso'},
      alpha2Code: 'BF',
      alpha3Code: 'BFA',
      numericCode: '854',
      flagEmoji: '🇧🇫',
      flagImagePath: 'packages/countrify/assets/images/flags/BF.png',
      capital: 'Ouagadougou',
      largestCity: 'Ouagadougou',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 20321378,
      area: 0.0, // Not available in CSV
      callingCodes: ['226'],
      topLevelDomains: ['.bf'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Burundi
    Country(
      name: 'Burundi',
      nameTranslations: {'en': 'Burundi'},
      alpha2Code: 'BI',
      alpha3Code: 'BDI',
      numericCode: '108',
      flagEmoji: '🇧🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/BI.png',
      capital: 'Bujumbura',
      largestCity: 'Bujumbura',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 11530580,
      area: 0.0, // Not available in CSV
      callingCodes: ['257'],
      topLevelDomains: ['.bi'],
      currencies: [Currency(code: 'BIF', name: 'BIF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Kirundi', nativeName: 'Kirundi')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Ivory Coast
    Country(
      name: 'Ivory Coast',
      nameTranslations: {'en': 'Ivory Coast'},
      alpha2Code: 'CI',
      alpha3Code: 'CIV',
      numericCode: '384',
      flagEmoji: '🇨🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/CI.png',
      capital: 'Yamoussoukro',
      largestCity: 'Abidjan',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 25716544,
      area: 0.0, // Not available in CSV
      callingCodes: ['225'],
      topLevelDomains: ['.ci'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Cape Verde
    Country(
      name: 'Cape Verde',
      nameTranslations: {'en': 'Cape Verde'},
      alpha2Code: 'CV',
      alpha3Code: 'CPV',
      numericCode: '132',
      flagEmoji: '🇨🇻',
      flagImagePath: 'packages/countrify/assets/images/flags/CV.png',
      capital: 'Praia',
      largestCity: 'Praia',
      region: 'Americas',
      subregion: 'Northern America',
      population: 483628,
      area: 0.0, // Not available in CSV
      callingCodes: ['238'],
      topLevelDomains: ['.cv'],
      currencies: [Currency(code: 'CVE', name: 'CVE', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Cambodia
    Country(
      name: 'Cambodia',
      nameTranslations: {'en': 'Cambodia'},
      alpha2Code: 'KH',
      alpha3Code: 'KHM',
      numericCode: '116',
      flagEmoji: '🇰🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/KH.png',
      capital: 'Phnom Penh',
      largestCity: 'Phnom Penh',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 16486542,
      area: 0.0, // Not available in CSV
      callingCodes: ['855'],
      topLevelDomains: ['.kh'],
      currencies: [Currency(code: 'KHR', name: 'KHR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Khmer language', nativeName: 'Khmer language')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Cameroon
    Country(
      name: 'Cameroon',
      nameTranslations: {'en': 'Cameroon'},
      alpha2Code: 'CM',
      alpha3Code: 'CMR',
      numericCode: '120',
      flagEmoji: '🇨🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/CM.png',
      capital: 'Yaound',
      largestCity: 'Douala',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 25876380,
      area: 0.0, // Not available in CSV
      callingCodes: ['237'],
      topLevelDomains: ['.cm'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Canada
    Country(
      name: 'Canada',
      nameTranslations: {'en': 'Canada'},
      alpha2Code: 'CA',
      alpha3Code: 'CAN',
      numericCode: '124',
      flagEmoji: '🇨🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/CA.png',
      capital: 'Ottawa',
      largestCity: 'Toronto',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 36991981,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.ca'],
      currencies: [Currency(code: 'CAD', name: 'CAD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Central African Republic
    Country(
      name: 'Central African Republic',
      nameTranslations: {'en': 'Central African Republic'},
      alpha2Code: 'CF',
      alpha3Code: 'CAF',
      numericCode: '140',
      flagEmoji: '🇨🇫',
      flagImagePath: 'packages/countrify/assets/images/flags/CF.png',
      capital: 'Bangui',
      largestCity: 'Bangui',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 4745185,
      area: 0.0, // Not available in CSV
      callingCodes: ['236'],
      topLevelDomains: ['.cf'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Chad
    Country(
      name: 'Chad',
      nameTranslations: {'en': 'Chad'},
      alpha2Code: 'TD',
      alpha3Code: 'TCD',
      numericCode: '148',
      flagEmoji: '🇹🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/TD.png',
      capital: 'N\'Djamena',
      largestCity: 'N\'Djamena',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 15946876,
      area: 0.0, // Not available in CSV
      callingCodes: ['235'],
      topLevelDomains: ['.td'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Chile
    Country(
      name: 'Chile',
      nameTranslations: {'en': 'Chile'},
      alpha2Code: 'CL',
      alpha3Code: 'CHL',
      numericCode: '152',
      flagEmoji: '🇨🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/CL.png',
      capital: 'Santiago',
      largestCity: 'Santiago',
      region: 'Americas',
      subregion: 'South America',
      population: 18952038,
      area: 0.0, // Not available in CSV
      callingCodes: ['56'],
      topLevelDomains: ['.cl'],
      currencies: [Currency(code: 'CLP', name: 'CLP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // China
    Country(
      name: 'China',
      nameTranslations: {'en': 'China'},
      alpha2Code: 'CN',
      alpha3Code: 'CHN',
      numericCode: '156',
      flagEmoji: '🇨🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/CN.png',
      capital: 'Beijing',
      largestCity: 'Shanghai',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 1397715000,
      area: 0.0, // Not available in CSV
      callingCodes: ['86'],
      topLevelDomains: ['.cn'],
      currencies: [Currency(code: 'CNY', name: 'CNY', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Chinese', nativeName: 'Chinese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Colombia
    Country(
      name: 'Colombia',
      nameTranslations: {'en': 'Colombia'},
      alpha2Code: 'CO',
      alpha3Code: 'COL',
      numericCode: '170',
      flagEmoji: '🇨🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/CO.png',
      capital: 'Bogot',
      largestCity: 'Bogot',
      region: 'Americas',
      subregion: 'Central America',
      population: 50339443,
      area: 0.0, // Not available in CSV
      callingCodes: ['57'],
      topLevelDomains: ['.co'],
      currencies: [Currency(code: 'COP', name: 'COP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Comoros
    Country(
      name: 'Comoros',
      nameTranslations: {'en': 'Comoros'},
      alpha2Code: 'KM',
      alpha3Code: 'COM',
      numericCode: '174',
      flagEmoji: '🇰🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/KM.png',
      capital: 'Moroni, Comoros',
      largestCity: 'Moroni, Comoros',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 850886,
      area: 0.0, // Not available in CSV
      callingCodes: ['269'],
      topLevelDomains: ['.km'],
      currencies: [Currency(code: 'KMF', name: 'KMF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Republic of the Congo
    Country(
      name: 'Republic of the Congo',
      nameTranslations: {'en': 'Republic of the Congo'},
      alpha2Code: 'CG',
      alpha3Code: 'COG',
      numericCode: '178',
      flagEmoji: '🇨🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/CG.png',
      capital: 'Brazzaville',
      largestCity: 'Brazzaville',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 5380508,
      area: 0.0, // Not available in CSV
      callingCodes: ['242'],
      topLevelDomains: ['.cg'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Costa Rica
    Country(
      name: 'Costa Rica',
      nameTranslations: {'en': 'Costa Rica'},
      alpha2Code: 'CR',
      alpha3Code: 'CRI',
      numericCode: '188',
      flagEmoji: '🇨🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/CR.png',
      capital: 'San Jos',
      largestCity: 'San Jos',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 5047561,
      area: 0.0, // Not available in CSV
      callingCodes: ['506'],
      topLevelDomains: ['.cr'],
      currencies: [Currency(code: 'CRC', name: 'CRC', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Croatia
    Country(
      name: 'Croatia',
      nameTranslations: {'en': 'Croatia'},
      alpha2Code: 'HR',
      alpha3Code: 'HRV',
      numericCode: '191',
      flagEmoji: '🇭🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/HR.png',
      capital: 'Zagreb',
      largestCity: 'Zagreb',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 4067500,
      area: 0.0, // Not available in CSV
      callingCodes: ['385'],
      topLevelDomains: ['.hr'],
      currencies: [Currency(code: 'HRK', name: 'HRK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Croatian', nativeName: 'Croatian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Cuba
    Country(
      name: 'Cuba',
      nameTranslations: {'en': 'Cuba'},
      alpha2Code: 'CU',
      alpha3Code: 'CUB',
      numericCode: '192',
      flagEmoji: '🇨🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/CU.png',
      capital: 'Havana',
      largestCity: 'Havana',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 11333483,
      area: 0.0, // Not available in CSV
      callingCodes: ['53'],
      topLevelDomains: ['.cu'],
      currencies: [Currency(code: 'CUP', name: 'CUP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Cyprus
    Country(
      name: 'Cyprus',
      nameTranslations: {'en': 'Cyprus'},
      alpha2Code: 'CY',
      alpha3Code: 'CYP',
      numericCode: '196',
      flagEmoji: '🇨🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/CY.png',
      capital: 'Nicosia',
      largestCity: 'Statos',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 1198575,
      area: 0.0, // Not available in CSV
      callingCodes: ['357'],
      topLevelDomains: ['.cy'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Greek', nativeName: 'Greek')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Czech Republic
    Country(
      name: 'Czech Republic',
      nameTranslations: {'en': 'Czech Republic'},
      alpha2Code: 'CZ',
      alpha3Code: 'CZE',
      numericCode: '203',
      flagEmoji: '🇨🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/CZ.png',
      capital: 'Prague',
      largestCity: 'Prague',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 10669709,
      area: 0.0, // Not available in CSV
      callingCodes: ['420'],
      topLevelDomains: ['.cz'],
      currencies: [Currency(code: 'CZK', name: 'CZK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Czech', nativeName: 'Czech')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Democratic Republic of the Congo
    Country(
      name: 'Democratic Republic of the Congo',
      nameTranslations: {'en': 'Democratic Republic of the Congo'},
      alpha2Code: 'CD',
      alpha3Code: 'COD',
      numericCode: '180',
      flagEmoji: '🇨🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/CD.png',
      capital: 'Kinshasa',
      largestCity: 'Kinshasa',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 86790567,
      area: 0.0, // Not available in CSV
      callingCodes: ['243'],
      topLevelDomains: ['.cd'],
      currencies: [Currency(code: 'CDF', name: 'CDF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Denmark
    Country(
      name: 'Denmark',
      nameTranslations: {'en': 'Denmark'},
      alpha2Code: 'DK',
      alpha3Code: 'DNK',
      numericCode: '208',
      flagEmoji: '🇩🇰',
      flagImagePath: 'packages/countrify/assets/images/flags/DK.png',
      capital: 'Copenhagen',
      largestCity: 'Copenhagen',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 5818553,
      area: 0.0, // Not available in CSV
      callingCodes: ['45'],
      topLevelDomains: ['.dk'],
      currencies: [Currency(code: 'DKK', name: 'DKK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Danish', nativeName: 'Danish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Djibouti
    Country(
      name: 'Djibouti',
      nameTranslations: {'en': 'Djibouti'},
      alpha2Code: 'DJ',
      alpha3Code: 'DJI',
      numericCode: '262',
      flagEmoji: '🇩🇯',
      flagImagePath: 'packages/countrify/assets/images/flags/DJ.png',
      capital: 'Djibouti City',
      largestCity: 'Djibouti City',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 973560,
      area: 0.0, // Not available in CSV
      callingCodes: ['253'],
      topLevelDomains: ['.dj'],
      currencies: [Currency(code: 'DJF', name: 'DJF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Dominica
    Country(
      name: 'Dominica',
      nameTranslations: {'en': 'Dominica'},
      alpha2Code: 'DM',
      alpha3Code: 'DMA',
      numericCode: '212',
      flagEmoji: '🇩🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/DM.png',
      capital: 'Roseau',
      largestCity: 'Roseau',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 71808,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.dm'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Dominican Republic
    Country(
      name: 'Dominican Republic',
      nameTranslations: {'en': 'Dominican Republic'},
      alpha2Code: 'DO',
      alpha3Code: 'DOM',
      numericCode: '214',
      flagEmoji: '🇩🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/DO.png',
      capital: 'Santo Domingo',
      largestCity: 'Santo Domingo',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 10738958,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.do'],
      currencies: [Currency(code: 'DOP', name: 'DOP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Ecuador
    Country(
      name: 'Ecuador',
      nameTranslations: {'en': 'Ecuador'},
      alpha2Code: 'EC',
      alpha3Code: 'ECU',
      numericCode: '218',
      flagEmoji: '🇪🇨',
      flagImagePath: 'packages/countrify/assets/images/flags/EC.png',
      capital: 'Quito',
      largestCity: 'Quito',
      region: 'Americas',
      subregion: 'Central America',
      population: 17373662,
      area: 0.0, // Not available in CSV
      callingCodes: ['593'],
      topLevelDomains: ['.ec'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Egypt
    Country(
      name: 'Egypt',
      nameTranslations: {'en': 'Egypt'},
      alpha2Code: 'EG',
      alpha3Code: 'EGY',
      numericCode: '818',
      flagEmoji: '🇪🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/EG.png',
      capital: 'Cairo',
      largestCity: 'Cairo',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 100388073,
      area: 0.0, // Not available in CSV
      callingCodes: ['20'],
      topLevelDomains: ['.eg'],
      currencies: [Currency(code: 'EGP', name: 'EGP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // El Salvador
    Country(
      name: 'El Salvador',
      nameTranslations: {'en': 'El Salvador'},
      alpha2Code: 'SV',
      alpha3Code: 'SLV',
      numericCode: '222',
      flagEmoji: '🇸🇻',
      flagImagePath: 'packages/countrify/assets/images/flags/SV.png',
      capital: 'San Salvador',
      largestCity: 'San Salvador',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 6453553,
      area: 0.0, // Not available in CSV
      callingCodes: ['503'],
      topLevelDomains: ['.sv'],
      currencies: [Currency(code: 'SVC', name: 'SVC', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Equatorial Guinea
    Country(
      name: 'Equatorial Guinea',
      nameTranslations: {'en': 'Equatorial Guinea'},
      alpha2Code: 'GQ',
      alpha3Code: 'GNQ',
      numericCode: '226',
      flagEmoji: '🇬🇶',
      flagImagePath: 'packages/countrify/assets/images/flags/GQ.png',
      capital: 'Malabo',
      largestCity: 'Malabo',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 1355986,
      area: 0.0, // Not available in CSV
      callingCodes: ['240'],
      topLevelDomains: ['.gq'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Eritrea
    Country(
      name: 'Eritrea',
      nameTranslations: {'en': 'Eritrea'},
      alpha2Code: 'ER',
      alpha3Code: 'ERI',
      numericCode: '232',
      flagEmoji: '🇪🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/ER.png',
      capital: 'Asmara',
      largestCity: 'Asmara',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 6333135,
      area: 0.0, // Not available in CSV
      callingCodes: ['291'],
      topLevelDomains: ['.er'],
      currencies: [Currency(code: 'ERN', name: 'ERN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Tigrinya', nativeName: 'Tigrinya')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Estonia
    Country(
      name: 'Estonia',
      nameTranslations: {'en': 'Estonia'},
      alpha2Code: 'EE',
      alpha3Code: 'EST',
      numericCode: '233',
      flagEmoji: '🇪🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/EE.png',
      capital: 'Tallinn',
      largestCity: 'Tallinn',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 1331824,
      area: 0.0, // Not available in CSV
      callingCodes: ['372'],
      topLevelDomains: ['.ee'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Estonian', nativeName: 'Estonian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Eswatini
    Country(
      name: 'Eswatini',
      nameTranslations: {'en': 'Eswatini'},
      alpha2Code: 'SZ',
      alpha3Code: 'SWZ',
      numericCode: '748',
      flagEmoji: '🇸🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/SZ.png',
      capital: 'Mbabane',
      largestCity: 'Mbabane',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 1093238,
      area: 0.0, // Not available in CSV
      callingCodes: ['268'],
      topLevelDomains: ['.sz'],
      currencies: [Currency(code: 'SZL', name: 'SZL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Ethiopia
    Country(
      name: 'Ethiopia',
      nameTranslations: {'en': 'Ethiopia'},
      alpha2Code: 'ET',
      alpha3Code: 'ETH',
      numericCode: '231',
      flagEmoji: '🇪🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/ET.png',
      capital: 'Addis Ababa',
      largestCity: 'Addis Ababa',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 112078730,
      area: 0.0, // Not available in CSV
      callingCodes: ['251'],
      topLevelDomains: ['.et'],
      currencies: [Currency(code: 'ETB', name: 'ETB', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Amharic', nativeName: 'Amharic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Fiji
    Country(
      name: 'Fiji',
      nameTranslations: {'en': 'Fiji'},
      alpha2Code: 'FJ',
      alpha3Code: 'FJI',
      numericCode: '242',
      flagEmoji: '🇫🇯',
      flagImagePath: 'packages/countrify/assets/images/flags/FJ.png',
      capital: 'Suva',
      largestCity: 'Suva',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 889953,
      area: 0.0, // Not available in CSV
      callingCodes: ['679'],
      topLevelDomains: ['.fj'],
      currencies: [Currency(code: 'FJD', name: 'FJD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Fiji Hindi', nativeName: 'Fiji Hindi')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Finland
    Country(
      name: 'Finland',
      nameTranslations: {'en': 'Finland'},
      alpha2Code: 'FI',
      alpha3Code: 'FIN',
      numericCode: '246',
      flagEmoji: '🇫🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/FI.png',
      capital: 'Helsinki',
      largestCity: 'Helsinki',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 5520314,
      area: 0.0, // Not available in CSV
      callingCodes: ['358'],
      topLevelDomains: ['.fi'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swedish', nativeName: 'Swedish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // France
    Country(
      name: 'France',
      nameTranslations: {'en': 'France'},
      alpha2Code: 'FR',
      alpha3Code: 'FRA',
      numericCode: '250',
      flagEmoji: '🇫🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/FR.png',
      capital: 'Paris',
      largestCity: 'Paris',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 67059887,
      area: 0.0, // Not available in CSV
      callingCodes: ['33'],
      topLevelDomains: ['.fr'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Gabon
    Country(
      name: 'Gabon',
      nameTranslations: {'en': 'Gabon'},
      alpha2Code: 'GA',
      alpha3Code: 'GAB',
      numericCode: '266',
      flagEmoji: '🇬🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/GA.png',
      capital: 'Libreville',
      largestCity: 'Libreville',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 2172579,
      area: 0.0, // Not available in CSV
      callingCodes: ['241'],
      topLevelDomains: ['.ga'],
      currencies: [Currency(code: 'XAF', name: 'XAF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // The Gambia
    Country(
      name: 'The Gambia',
      nameTranslations: {'en': 'The Gambia'},
      alpha2Code: 'GM',
      alpha3Code: 'GMB',
      numericCode: '270',
      flagEmoji: '🇬🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/GM.png',
      capital: 'Banjul',
      largestCity: 'Serekunda',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 2347706,
      area: 0.0, // Not available in CSV
      callingCodes: ['220'],
      topLevelDomains: ['.gm'],
      currencies: [Currency(code: 'GMD', name: 'GMD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Georgia
    Country(
      name: 'Georgia',
      nameTranslations: {'en': 'Georgia'},
      alpha2Code: 'GE',
      alpha3Code: 'GEO',
      numericCode: '268',
      flagEmoji: '🇬🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/GE.png',
      capital: 'Tbilisi',
      largestCity: 'Tbilisi',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 3720382,
      area: 0.0, // Not available in CSV
      callingCodes: ['995'],
      topLevelDomains: ['.ge'],
      currencies: [Currency(code: 'GEL', name: 'GEL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Georgian', nativeName: 'Georgian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Germany
    Country(
      name: 'Germany',
      nameTranslations: {'en': 'Germany'},
      alpha2Code: 'DE',
      alpha3Code: 'DEU',
      numericCode: '276',
      flagEmoji: '🇩🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/DE.png',
      capital: 'Berlin',
      largestCity: 'Berlin',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 83132799,
      area: 0.0, // Not available in CSV
      callingCodes: ['49'],
      topLevelDomains: ['.de'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'German', nativeName: 'German')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Ghana
    Country(
      name: 'Ghana',
      nameTranslations: {'en': 'Ghana'},
      alpha2Code: 'GH',
      alpha3Code: 'GHA',
      numericCode: '288',
      flagEmoji: '🇬🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/GH.png',
      capital: 'Accra',
      largestCity: 'Accra',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 30792608,
      area: 0.0, // Not available in CSV
      callingCodes: ['233'],
      topLevelDomains: ['.gh'],
      currencies: [Currency(code: 'GHS', name: 'GHS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Greece
    Country(
      name: 'Greece',
      nameTranslations: {'en': 'Greece'},
      alpha2Code: 'GR',
      alpha3Code: 'GRC',
      numericCode: '300',
      flagEmoji: '🇬🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/GR.png',
      capital: 'Athens',
      largestCity: 'Macedonia',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 10716322,
      area: 0.0, // Not available in CSV
      callingCodes: ['30'],
      topLevelDomains: ['.gr'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Greek', nativeName: 'Greek')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Grenada
    Country(
      name: 'Grenada',
      nameTranslations: {'en': 'Grenada'},
      alpha2Code: 'GD',
      alpha3Code: 'GRD',
      numericCode: '308',
      flagEmoji: '🇬🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/GD.png',
      capital: 'St. George\'s, Grenada',
      largestCity: 'St. George\'s, Grenada',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 112003,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.gd'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Guatemala
    Country(
      name: 'Guatemala',
      nameTranslations: {'en': 'Guatemala'},
      alpha2Code: 'GT',
      alpha3Code: 'GTM',
      numericCode: '320',
      flagEmoji: '🇬🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/GT.png',
      capital: 'Guatemala City',
      largestCity: 'Guatemala City',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 16604026,
      area: 0.0, // Not available in CSV
      callingCodes: ['502'],
      topLevelDomains: ['.gt'],
      currencies: [Currency(code: 'GTQ', name: 'GTQ', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Guinea
    Country(
      name: 'Guinea',
      nameTranslations: {'en': 'Guinea'},
      alpha2Code: 'GN',
      alpha3Code: 'GIN',
      numericCode: '324',
      flagEmoji: '🇬🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/GN.png',
      capital: 'Conakry',
      largestCity: 'Kankan',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 12771246,
      area: 0.0, // Not available in CSV
      callingCodes: ['224'],
      topLevelDomains: ['.gn'],
      currencies: [Currency(code: 'GNF', name: 'GNF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Guinea-Bissau
    Country(
      name: 'Guinea-Bissau',
      nameTranslations: {'en': 'Guinea-Bissau'},
      alpha2Code: 'GW',
      alpha3Code: 'GNB',
      numericCode: '624',
      flagEmoji: '🇬🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/GW.png',
      capital: 'Bissau',
      largestCity: 'Bissau',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 1920922,
      area: 0.0, // Not available in CSV
      callingCodes: ['245'],
      topLevelDomains: ['.gw'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Guyana
    Country(
      name: 'Guyana',
      nameTranslations: {'en': 'Guyana'},
      alpha2Code: 'GY',
      alpha3Code: 'GUY',
      numericCode: '328',
      flagEmoji: '🇬🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/GY.png',
      capital: 'Georgetown, Guyana',
      largestCity: 'Georgetown, Guyana',
      region: 'Americas',
      subregion: 'Central America',
      population: 782766,
      area: 0.0, // Not available in CSV
      callingCodes: ['592'],
      topLevelDomains: ['.gy'],
      currencies: [Currency(code: 'GYD', name: 'GYD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Haiti
    Country(
      name: 'Haiti',
      nameTranslations: {'en': 'Haiti'},
      alpha2Code: 'HT',
      alpha3Code: 'HTI',
      numericCode: '332',
      flagEmoji: '🇭🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/HT.png',
      capital: 'Port-au-Prince',
      largestCity: 'Port-au-Prince',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 11263077,
      area: 0.0, // Not available in CSV
      callingCodes: ['509'],
      topLevelDomains: ['.ht'],
      currencies: [Currency(code: 'HTG', name: 'HTG', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Vatican City
    Country(
      name: 'Vatican City',
      nameTranslations: {'en': 'Vatican City'},
      alpha2Code: 'VA',
      alpha3Code: 'VAT',
      numericCode: '336',
      flagEmoji: '🇻🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/VA.png',
      capital: 'Vatican City',
      largestCity: 'Vatican City',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 836,
      area: 0.0, // Not available in CSV
      callingCodes: ['379'],
      topLevelDomains: ['.va'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Italian', nativeName: 'Italian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Honduras
    Country(
      name: 'Honduras',
      nameTranslations: {'en': 'Honduras'},
      alpha2Code: 'HN',
      alpha3Code: 'HND',
      numericCode: '340',
      flagEmoji: '🇭🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/HN.png',
      capital: 'Tegucigalpa',
      largestCity: 'Tegucigalpa',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 9746117,
      area: 0.0, // Not available in CSV
      callingCodes: ['504'],
      topLevelDomains: ['.hn'],
      currencies: [Currency(code: 'HNL', name: 'HNL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Hungary
    Country(
      name: 'Hungary',
      nameTranslations: {'en': 'Hungary'},
      alpha2Code: 'HU',
      alpha3Code: 'HUN',
      numericCode: '348',
      flagEmoji: '🇭🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/HU.png',
      capital: 'Budapest',
      largestCity: 'Budapest',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 9769949,
      area: 0.0, // Not available in CSV
      callingCodes: ['36'],
      topLevelDomains: ['.hu'],
      currencies: [Currency(code: 'HUF', name: 'HUF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Hungarian', nativeName: 'Hungarian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Iceland
    Country(
      name: 'Iceland',
      nameTranslations: {'en': 'Iceland'},
      alpha2Code: 'IS',
      alpha3Code: 'ISL',
      numericCode: '352',
      flagEmoji: '🇮🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/IS.png',
      capital: 'Reykjav',
      largestCity: 'Reykjav',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 361313,
      area: 0.0, // Not available in CSV
      callingCodes: ['354'],
      topLevelDomains: ['.is'],
      currencies: [Currency(code: 'ISK', name: 'ISK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Icelandic', nativeName: 'Icelandic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // India
    Country(
      name: 'India',
      nameTranslations: {'en': 'India'},
      alpha2Code: 'IN',
      alpha3Code: 'IND',
      numericCode: '356',
      flagEmoji: '🇮🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/IN.png',
      capital: 'New Delhi',
      largestCity: 'Kurebhar',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 1366417754,
      area: 0.0, // Not available in CSV
      callingCodes: ['91'],
      topLevelDomains: ['.in'],
      currencies: [Currency(code: 'INR', name: 'INR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Hindi', nativeName: 'Hindi')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Indonesia
    Country(
      name: 'Indonesia',
      nameTranslations: {'en': 'Indonesia'},
      alpha2Code: 'ID',
      alpha3Code: 'IDN',
      numericCode: '360',
      flagEmoji: '🇮🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/ID.png',
      capital: 'Jakarta',
      largestCity: 'Kalimantan',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 270203917,
      area: 0.0, // Not available in CSV
      callingCodes: ['62'],
      topLevelDomains: ['.id'],
      currencies: [Currency(code: 'IDR', name: 'IDR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Indonesian', nativeName: 'Indonesian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Iran
    Country(
      name: 'Iran',
      nameTranslations: {'en': 'Iran'},
      alpha2Code: 'IR',
      alpha3Code: 'IRN',
      numericCode: '364',
      flagEmoji: '🇮🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/IR.png',
      capital: 'Tehran',
      largestCity: 'Tehran',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 82913906,
      area: 0.0, // Not available in CSV
      callingCodes: ['98'],
      topLevelDomains: ['.ir'],
      currencies: [Currency(code: 'IRR', name: 'IRR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Persian', nativeName: 'Persian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Iraq
    Country(
      name: 'Iraq',
      nameTranslations: {'en': 'Iraq'},
      alpha2Code: 'IQ',
      alpha3Code: 'IRQ',
      numericCode: '368',
      flagEmoji: '🇮🇶',
      flagImagePath: 'packages/countrify/assets/images/flags/IQ.png',
      capital: 'Baghdad',
      largestCity: 'Baghdad',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 39309783,
      area: 0.0, // Not available in CSV
      callingCodes: ['964'],
      topLevelDomains: ['.iq'],
      currencies: [Currency(code: 'IQD', name: 'IQD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Republic of Ireland
    Country(
      name: 'Republic of Ireland',
      nameTranslations: {'en': 'Republic of Ireland'},
      alpha2Code: 'ROI',
      alpha3Code: 'UNK',
      numericCode: '000',
      flagEmoji: '🏳️',
      flagImagePath: 'packages/countrify/assets/images/flags/ROI.png',
      capital: 'Dublin',
      largestCity: 'Connacht',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 5007069,
      area: 0.0, // Not available in CSV
      callingCodes: ['353'],
      topLevelDomains: ['.roi'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Irish', nativeName: 'Irish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Israel
    Country(
      name: 'Israel',
      nameTranslations: {'en': 'Israel'},
      alpha2Code: 'IL',
      alpha3Code: 'ISR',
      numericCode: '376',
      flagEmoji: '🇮🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/IL.png',
      capital: 'Jerusalem',
      largestCity: 'Jerusalem',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 9053300,
      area: 0.0, // Not available in CSV
      callingCodes: ['972'],
      topLevelDomains: ['.il'],
      currencies: [Currency(code: 'ILS', name: 'ILS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Hebrew', nativeName: 'Hebrew')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Italy
    Country(
      name: 'Italy',
      nameTranslations: {'en': 'Italy'},
      alpha2Code: 'IT',
      alpha3Code: 'ITA',
      numericCode: '380',
      flagEmoji: '🇮🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/IT.png',
      capital: 'Rome',
      largestCity: 'Rome',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 60297396,
      area: 0.0, // Not available in CSV
      callingCodes: ['39'],
      topLevelDomains: ['.it'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Italian', nativeName: 'Italian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Jamaica
    Country(
      name: 'Jamaica',
      nameTranslations: {'en': 'Jamaica'},
      alpha2Code: 'JM',
      alpha3Code: 'JAM',
      numericCode: '388',
      flagEmoji: '🇯🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/JM.png',
      capital: 'Kingston, Jamaica',
      largestCity: 'Kingston, Jamaica',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 2948279,
      area: 0.0, // Not available in CSV
      callingCodes: ['1876'],
      topLevelDomains: ['.jm'],
      currencies: [Currency(code: 'JMD', name: 'JMD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Japan
    Country(
      name: 'Japan',
      nameTranslations: {'en': 'Japan'},
      alpha2Code: 'JP',
      alpha3Code: 'JPN',
      numericCode: '392',
      flagEmoji: '🇯🇵',
      flagImagePath: 'packages/countrify/assets/images/flags/JP.png',
      capital: 'Tokyo',
      largestCity: 'Tokyo',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 126226568,
      area: 0.0, // Not available in CSV
      callingCodes: ['81'],
      topLevelDomains: ['.jp'],
      currencies: [Currency(code: 'JPY', name: 'JPY', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Japanese', nativeName: 'Japanese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Jordan
    Country(
      name: 'Jordan',
      nameTranslations: {'en': 'Jordan'},
      alpha2Code: 'JO',
      alpha3Code: 'JOR',
      numericCode: '400',
      flagEmoji: '🇯🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/JO.png',
      capital: 'Amman',
      largestCity: 'Amman',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 10101694,
      area: 0.0, // Not available in CSV
      callingCodes: ['962'],
      topLevelDomains: ['.jo'],
      currencies: [Currency(code: 'JOD', name: 'JOD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Kazakhstan
    Country(
      name: 'Kazakhstan',
      nameTranslations: {'en': 'Kazakhstan'},
      alpha2Code: 'KZ',
      alpha3Code: 'KAZ',
      numericCode: '398',
      flagEmoji: '🇰🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/KZ.png',
      capital: 'Astana',
      largestCity: 'Almaty',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 18513930,
      area: 0.0, // Not available in CSV
      callingCodes: ['7'],
      topLevelDomains: ['.kz'],
      currencies: [Currency(code: 'KZT', name: 'KZT', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Russian', nativeName: 'Russian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Kenya
    Country(
      name: 'Kenya',
      nameTranslations: {'en': 'Kenya'},
      alpha2Code: 'KE',
      alpha3Code: 'KEN',
      numericCode: '404',
      flagEmoji: '🇰🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/KE.png',
      capital: 'Nairobi',
      largestCity: 'Nairobi',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 52573973,
      area: 0.0, // Not available in CSV
      callingCodes: ['254'],
      topLevelDomains: ['.ke'],
      currencies: [Currency(code: 'KES', name: 'KES', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swahili', nativeName: 'Swahili')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Kiribati
    Country(
      name: 'Kiribati',
      nameTranslations: {'en': 'Kiribati'},
      alpha2Code: 'KI',
      alpha3Code: 'KIR',
      numericCode: '296',
      flagEmoji: '🇰🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/KI.png',
      capital: 'South Tarawa',
      largestCity: 'South Tarawa',
      region: 'Americas',
      subregion: 'Central America',
      population: 117606,
      area: 0.0, // Not available in CSV
      callingCodes: ['686'],
      topLevelDomains: ['.ki'],
      currencies: [Currency(code: 'AUD', name: 'AUD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Kuwait
    Country(
      name: 'Kuwait',
      nameTranslations: {'en': 'Kuwait'},
      alpha2Code: 'KW',
      alpha3Code: 'KWT',
      numericCode: '414',
      flagEmoji: '🇰🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/KW.png',
      capital: 'Kuwait City',
      largestCity: 'Kuwait City',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 4207083,
      area: 0.0, // Not available in CSV
      callingCodes: ['965'],
      topLevelDomains: ['.kw'],
      currencies: [Currency(code: 'KWD', name: 'KWD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Kyrgyzstan
    Country(
      name: 'Kyrgyzstan',
      nameTranslations: {'en': 'Kyrgyzstan'},
      alpha2Code: 'KG',
      alpha3Code: 'KGZ',
      numericCode: '417',
      flagEmoji: '🇰🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/KG.png',
      capital: 'Bishkek',
      largestCity: 'Bishkek',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 6456900,
      area: 0.0, // Not available in CSV
      callingCodes: ['996'],
      topLevelDomains: ['.kg'],
      currencies: [Currency(code: 'KGS', name: 'KGS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Russian', nativeName: 'Russian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Laos
    Country(
      name: 'Laos',
      nameTranslations: {'en': 'Laos'},
      alpha2Code: 'LA',
      alpha3Code: 'LAO',
      numericCode: '418',
      flagEmoji: '🇱🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/LA.png',
      capital: 'Vientiane',
      largestCity: 'Vientiane',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 7169455,
      area: 0.0, // Not available in CSV
      callingCodes: ['856'],
      topLevelDomains: ['.la'],
      currencies: [Currency(code: 'LAK', name: 'LAK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Lao', nativeName: 'Lao')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Latvia
    Country(
      name: 'Latvia',
      nameTranslations: {'en': 'Latvia'},
      alpha2Code: 'LV',
      alpha3Code: 'LVA',
      numericCode: '428',
      flagEmoji: '🇱🇻',
      flagImagePath: 'packages/countrify/assets/images/flags/LV.png',
      capital: 'Riga',
      largestCity: 'Riga',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 1912789,
      area: 0.0, // Not available in CSV
      callingCodes: ['371'],
      topLevelDomains: ['.lv'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Latvian', nativeName: 'Latvian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Lebanon
    Country(
      name: 'Lebanon',
      nameTranslations: {'en': 'Lebanon'},
      alpha2Code: 'LB',
      alpha3Code: 'LBN',
      numericCode: '422',
      flagEmoji: '🇱🇧',
      flagImagePath: 'packages/countrify/assets/images/flags/LB.png',
      capital: 'Beirut',
      largestCity: 'Tripoli, Lebanon',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 6855713,
      area: 0.0, // Not available in CSV
      callingCodes: ['961'],
      topLevelDomains: ['.lb'],
      currencies: [Currency(code: 'LBP', name: 'LBP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Lesotho
    Country(
      name: 'Lesotho',
      nameTranslations: {'en': 'Lesotho'},
      alpha2Code: 'LS',
      alpha3Code: 'LSO',
      numericCode: '426',
      flagEmoji: '🇱🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/LS.png',
      capital: 'Maseru',
      largestCity: 'Maseru',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 2125268,
      area: 0.0, // Not available in CSV
      callingCodes: ['266'],
      topLevelDomains: ['.ls'],
      currencies: [Currency(code: 'LSL', name: 'LSL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Liberia
    Country(
      name: 'Liberia',
      nameTranslations: {'en': 'Liberia'},
      alpha2Code: 'LR',
      alpha3Code: 'LBR',
      numericCode: '430',
      flagEmoji: '🇱🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/LR.png',
      capital: 'Monrovia',
      largestCity: 'Monrovia',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 4937374,
      area: 0.0, // Not available in CSV
      callingCodes: ['231'],
      topLevelDomains: ['.lr'],
      currencies: [Currency(code: 'LRD', name: 'LRD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Libya
    Country(
      name: 'Libya',
      nameTranslations: {'en': 'Libya'},
      alpha2Code: 'LY',
      alpha3Code: 'LBY',
      numericCode: '434',
      flagEmoji: '🇱🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/LY.png',
      capital: 'Tripoli',
      largestCity: 'Tripoli',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 6777452,
      area: 0.0, // Not available in CSV
      callingCodes: ['218'],
      topLevelDomains: ['.ly'],
      currencies: [Currency(code: 'LYD', name: 'LYD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Liechtenstein
    Country(
      name: 'Liechtenstein',
      nameTranslations: {'en': 'Liechtenstein'},
      alpha2Code: 'LI',
      alpha3Code: 'LIE',
      numericCode: '438',
      flagEmoji: '🇱🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/LI.png',
      capital: 'Vaduz',
      largestCity: 'Schaan',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 38019,
      area: 0.0, // Not available in CSV
      callingCodes: ['423'],
      topLevelDomains: ['.li'],
      currencies: [Currency(code: 'CHF', name: 'CHF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'German', nativeName: 'German')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Lithuania
    Country(
      name: 'Lithuania',
      nameTranslations: {'en': 'Lithuania'},
      alpha2Code: 'LT',
      alpha3Code: 'LTU',
      numericCode: '440',
      flagEmoji: '🇱🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/LT.png',
      capital: 'Vilnius',
      largestCity: 'Vilnius',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 2786844,
      area: 0.0, // Not available in CSV
      callingCodes: ['370'],
      topLevelDomains: ['.lt'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Lithuanian', nativeName: 'Lithuanian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Luxembourg
    Country(
      name: 'Luxembourg',
      nameTranslations: {'en': 'Luxembourg'},
      alpha2Code: 'LU',
      alpha3Code: 'LUX',
      numericCode: '442',
      flagEmoji: '🇱🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/LU.png',
      capital: 'Luxembourg City',
      largestCity: 'Luxembourg City',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 645397,
      area: 0.0, // Not available in CSV
      callingCodes: ['352'],
      topLevelDomains: ['.lu'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Luxembourgish', nativeName: 'Luxembourgish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Madagascar
    Country(
      name: 'Madagascar',
      nameTranslations: {'en': 'Madagascar'},
      alpha2Code: 'MG',
      alpha3Code: 'MDG',
      numericCode: '450',
      flagEmoji: '🇲🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/MG.png',
      capital: 'Antananarivo',
      largestCity: 'Antananarivo',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 26969307,
      area: 0.0, // Not available in CSV
      callingCodes: ['261'],
      topLevelDomains: ['.mg'],
      currencies: [Currency(code: 'MGA', name: 'MGA', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Malawi
    Country(
      name: 'Malawi',
      nameTranslations: {'en': 'Malawi'},
      alpha2Code: 'MW',
      alpha3Code: 'MWI',
      numericCode: '454',
      flagEmoji: '🇲🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/MW.png',
      capital: 'Lilongwe',
      largestCity: 'Lilongwe',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 18628747,
      area: 0.0, // Not available in CSV
      callingCodes: ['265'],
      topLevelDomains: ['.mw'],
      currencies: [Currency(code: 'MWK', name: 'MWK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Malaysia
    Country(
      name: 'Malaysia',
      nameTranslations: {'en': 'Malaysia'},
      alpha2Code: 'MY',
      alpha3Code: 'MYS',
      numericCode: '458',
      flagEmoji: '🇲🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/MY.png',
      capital: 'Kuala Lumpur',
      largestCity: 'Johor Bahru',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 32447385,
      area: 0.0, // Not available in CSV
      callingCodes: ['60'],
      topLevelDomains: ['.my'],
      currencies: [Currency(code: 'MYR', name: 'MYR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Malay', nativeName: 'Malay')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Maldives
    Country(
      name: 'Maldives',
      nameTranslations: {'en': 'Maldives'},
      alpha2Code: 'MV',
      alpha3Code: 'MDV',
      numericCode: '462',
      flagEmoji: '🇲🇻',
      flagImagePath: 'packages/countrify/assets/images/flags/MV.png',
      capital: 'Mal',
      largestCity: 'Mal',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 530953,
      area: 0.0, // Not available in CSV
      callingCodes: ['960'],
      topLevelDomains: ['.mv'],
      currencies: [Currency(code: 'MVR', name: 'MVR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Divehi', nativeName: 'Divehi')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mali
    Country(
      name: 'Mali',
      nameTranslations: {'en': 'Mali'},
      alpha2Code: 'ML',
      alpha3Code: 'MLI',
      numericCode: '466',
      flagEmoji: '🇲🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/ML.png',
      capital: 'Bamako',
      largestCity: 'Bamako',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 19658031,
      area: 0.0, // Not available in CSV
      callingCodes: ['223'],
      topLevelDomains: ['.ml'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Malta
    Country(
      name: 'Malta',
      nameTranslations: {'en': 'Malta'},
      alpha2Code: 'MT',
      alpha3Code: 'MLT',
      numericCode: '470',
      flagEmoji: '🇲🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/MT.png',
      capital: 'Valletta',
      largestCity: 'Birkirkara',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 502653,
      area: 0.0, // Not available in CSV
      callingCodes: ['356'],
      topLevelDomains: ['.mt'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Maltese', nativeName: 'Maltese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Marshall Islands
    Country(
      name: 'Marshall Islands',
      nameTranslations: {'en': 'Marshall Islands'},
      alpha2Code: 'MH',
      alpha3Code: 'MHL',
      numericCode: '584',
      flagEmoji: '🇲🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/MH.png',
      capital: 'Majuro',
      largestCity: 'Majuro',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 58791,
      area: 0.0, // Not available in CSV
      callingCodes: ['692'],
      topLevelDomains: ['.mh'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Marshallese', nativeName: 'Marshallese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mauritania
    Country(
      name: 'Mauritania',
      nameTranslations: {'en': 'Mauritania'},
      alpha2Code: 'MR',
      alpha3Code: 'MRT',
      numericCode: '478',
      flagEmoji: '🇲🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/MR.png',
      capital: 'Nouakchott',
      largestCity: 'Nouakchott',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 4525696,
      area: 0.0, // Not available in CSV
      callingCodes: ['222'],
      topLevelDomains: ['.mr'],
      currencies: [Currency(code: 'MRU', name: 'MRU', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mauritius
    Country(
      name: 'Mauritius',
      nameTranslations: {'en': 'Mauritius'},
      alpha2Code: 'MU',
      alpha3Code: 'MUS',
      numericCode: '480',
      flagEmoji: '🇲🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/MU.png',
      capital: 'Port Louis',
      largestCity: 'Port Louis',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 1265711,
      area: 0.0, // Not available in CSV
      callingCodes: ['230'],
      topLevelDomains: ['.mu'],
      currencies: [Currency(code: 'MUR', name: 'MUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mexico
    Country(
      name: 'Mexico',
      nameTranslations: {'en': 'Mexico'},
      alpha2Code: 'MX',
      alpha3Code: 'MEX',
      numericCode: '484',
      flagEmoji: '🇲🇽',
      flagImagePath: 'packages/countrify/assets/images/flags/MX.png',
      capital: 'Mexico City',
      largestCity: 'Mexico City',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 126014024,
      area: 0.0, // Not available in CSV
      callingCodes: ['52'],
      topLevelDomains: ['.mx'],
      currencies: [Currency(code: 'MXN', name: 'MXN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Federated States of Micronesia
    Country(
      name: 'Federated States of Micronesia',
      nameTranslations: {'en': 'Federated States of Micronesia'},
      alpha2Code: 'FM',
      alpha3Code: 'FSM',
      numericCode: '583',
      flagEmoji: '🇫🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/FM.png',
      capital: 'Palikir',
      largestCity: 'Palikir',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 113815,
      area: 0.0, // Not available in CSV
      callingCodes: ['691'],
      topLevelDomains: ['.fm'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Moldova
    Country(
      name: 'Moldova',
      nameTranslations: {'en': 'Moldova'},
      alpha2Code: 'MD',
      alpha3Code: 'MDA',
      numericCode: '498',
      flagEmoji: '🇲🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/MD.png',
      capital: 'Chi',
      largestCity: 'Chi',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 2657637,
      area: 0.0, // Not available in CSV
      callingCodes: ['373'],
      topLevelDomains: ['.md'],
      currencies: [Currency(code: 'MDL', name: 'MDL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Romanian', nativeName: 'Romanian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Monaco
    Country(
      name: 'Monaco',
      nameTranslations: {'en': 'Monaco'},
      alpha2Code: 'MC',
      alpha3Code: 'MCO',
      numericCode: '492',
      flagEmoji: '🇲🇨',
      flagImagePath: 'packages/countrify/assets/images/flags/MC.png',
      capital: 'Monaco City',
      largestCity: 'Monaco City',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 38964,
      area: 0.0, // Not available in CSV
      callingCodes: ['377'],
      topLevelDomains: ['.mc'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mongolia
    Country(
      name: 'Mongolia',
      nameTranslations: {'en': 'Mongolia'},
      alpha2Code: 'MN',
      alpha3Code: 'MNG',
      numericCode: '496',
      flagEmoji: '🇲🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/MN.png',
      capital: 'Ulaanbaatar',
      largestCity: 'Ulaanbaatar',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 3225167,
      area: 0.0, // Not available in CSV
      callingCodes: ['976'],
      topLevelDomains: ['.mn'],
      currencies: [Currency(code: 'MNT', name: 'MNT', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Mongolian', nativeName: 'Mongolian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Montenegro
    Country(
      name: 'Montenegro',
      nameTranslations: {'en': 'Montenegro'},
      alpha2Code: 'ME',
      alpha3Code: 'MNE',
      numericCode: '499',
      flagEmoji: '🇲🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/ME.png',
      capital: 'Podgorica',
      largestCity: 'Podgorica',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 622137,
      area: 0.0, // Not available in CSV
      callingCodes: ['382'],
      topLevelDomains: ['.me'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Montenegrin language', nativeName: 'Montenegrin language')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Morocco
    Country(
      name: 'Morocco',
      nameTranslations: {'en': 'Morocco'},
      alpha2Code: 'MA',
      alpha3Code: 'MAR',
      numericCode: '504',
      flagEmoji: '🇲🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/MA.png',
      capital: 'Rabat',
      largestCity: 'Casablanca',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 36910560,
      area: 0.0, // Not available in CSV
      callingCodes: ['212'],
      topLevelDomains: ['.ma'],
      currencies: [Currency(code: 'MAD', name: 'MAD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Mozambique
    Country(
      name: 'Mozambique',
      nameTranslations: {'en': 'Mozambique'},
      alpha2Code: 'MZ',
      alpha3Code: 'MOZ',
      numericCode: '508',
      flagEmoji: '🇲🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/MZ.png',
      capital: 'Maputo',
      largestCity: 'Maputo',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 30366036,
      area: 0.0, // Not available in CSV
      callingCodes: ['258'],
      topLevelDomains: ['.mz'],
      currencies: [Currency(code: 'MZN', name: 'MZN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Myanmar
    Country(
      name: 'Myanmar',
      nameTranslations: {'en': 'Myanmar'},
      alpha2Code: 'MM',
      alpha3Code: 'MMR',
      numericCode: '104',
      flagEmoji: '🇲🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/MM.png',
      capital: 'Naypyidaw',
      largestCity: 'Yangon',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 54045420,
      area: 0.0, // Not available in CSV
      callingCodes: ['95'],
      topLevelDomains: ['.mm'],
      currencies: [Currency(code: 'MMK', name: 'MMK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Burmese', nativeName: 'Burmese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Namibia
    Country(
      name: 'Namibia',
      nameTranslations: {'en': 'Namibia'},
      alpha2Code: 'NA',
      alpha3Code: 'NAM',
      numericCode: '516',
      flagEmoji: '🇳🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/NA.png',
      capital: 'Windhoek',
      largestCity: 'Windhoek',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 2494530,
      area: 0.0, // Not available in CSV
      callingCodes: ['264'],
      topLevelDomains: ['.na'],
      currencies: [Currency(code: 'NAD', name: 'NAD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Nauru
    Country(
      name: 'Nauru',
      nameTranslations: {'en': 'Nauru'},
      alpha2Code: 'NR',
      alpha3Code: 'NRU',
      numericCode: '520',
      flagEmoji: '🇳🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/NR.png',
      capital: 'Yaren District',
      largestCity: 'Denigomodu',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 10084,
      area: 0.0, // Not available in CSV
      callingCodes: ['674'],
      topLevelDomains: ['.nr'],
      currencies: [Currency(code: 'AUD', name: 'AUD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Nepal
    Country(
      name: 'Nepal',
      nameTranslations: {'en': 'Nepal'},
      alpha2Code: 'NP',
      alpha3Code: 'NPL',
      numericCode: '524',
      flagEmoji: '🇳🇵',
      flagImagePath: 'packages/countrify/assets/images/flags/NP.png',
      capital: 'Kathmandu',
      largestCity: 'Kathmandu',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 28608710,
      area: 0.0, // Not available in CSV
      callingCodes: ['977'],
      topLevelDomains: ['.np'],
      currencies: [Currency(code: 'NPR', name: 'NPR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Nepali', nativeName: 'Nepali')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Netherlands
    Country(
      name: 'Netherlands',
      nameTranslations: {'en': 'Netherlands'},
      alpha2Code: 'NL',
      alpha3Code: 'NLD',
      numericCode: '528',
      flagEmoji: '🇳🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/NL.png',
      capital: 'Amsterdam',
      largestCity: 'Amsterdam',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 17332850,
      area: 0.0, // Not available in CSV
      callingCodes: ['31'],
      topLevelDomains: ['.nl'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Dutch', nativeName: 'Dutch')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // New Zealand
    Country(
      name: 'New Zealand',
      nameTranslations: {'en': 'New Zealand'},
      alpha2Code: 'NZ',
      alpha3Code: 'NZL',
      numericCode: '554',
      flagEmoji: '🇳🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/NZ.png',
      capital: 'Wellington',
      largestCity: 'Auckland',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 4841000,
      area: 0.0, // Not available in CSV
      callingCodes: ['64'],
      topLevelDomains: ['.nz'],
      currencies: [Currency(code: 'NZD', name: 'NZD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Nicaragua
    Country(
      name: 'Nicaragua',
      nameTranslations: {'en': 'Nicaragua'},
      alpha2Code: 'NI',
      alpha3Code: 'NIC',
      numericCode: '558',
      flagEmoji: '🇳🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/NI.png',
      capital: 'Managua',
      largestCity: 'Managua',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 6545502,
      area: 0.0, // Not available in CSV
      callingCodes: ['505'],
      topLevelDomains: ['.ni'],
      currencies: [Currency(code: 'NIO', name: 'NIO', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Niger
    Country(
      name: 'Niger',
      nameTranslations: {'en': 'Niger'},
      alpha2Code: 'NE',
      alpha3Code: 'NER',
      numericCode: '562',
      flagEmoji: '🇳🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/NE.png',
      capital: 'Niamey',
      largestCity: 'Niamey',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 23310715,
      area: 0.0, // Not available in CSV
      callingCodes: ['227'],
      topLevelDomains: ['.ne'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Nigeria
    Country(
      name: 'Nigeria',
      nameTranslations: {'en': 'Nigeria'},
      alpha2Code: 'NG',
      alpha3Code: 'NGA',
      numericCode: '566',
      flagEmoji: '🇳🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/NG.png',
      capital: 'Abuja',
      largestCity: 'Lagos',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 200963599,
      area: 0.0, // Not available in CSV
      callingCodes: ['234'],
      topLevelDomains: ['.ng'],
      currencies: [Currency(code: 'NGN', name: 'NGN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // North Korea
    Country(
      name: 'North Korea',
      nameTranslations: {'en': 'North Korea'},
      alpha2Code: 'KP',
      alpha3Code: 'PRK',
      numericCode: '408',
      flagEmoji: '🇰🇵',
      flagImagePath: 'packages/countrify/assets/images/flags/KP.png',
      capital: 'Pyongyang',
      largestCity: 'Pyongyang',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 25666161,
      area: 0.0, // Not available in CSV
      callingCodes: ['850'],
      topLevelDomains: ['.kp'],
      currencies: [Currency(code: 'KPW', name: 'KPW', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Korean', nativeName: 'Korean')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // North Macedonia
    Country(
      name: 'North Macedonia',
      nameTranslations: {'en': 'North Macedonia'},
      alpha2Code: 'MKD',
      alpha3Code: 'UNK',
      numericCode: '000',
      flagEmoji: '🏳️',
      flagImagePath: 'packages/countrify/assets/images/flags/MKD.png',
      capital: 'Skopje',
      largestCity: 'Skopje',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 1836713,
      area: 0.0, // Not available in CSV
      callingCodes: ['389'],
      topLevelDomains: ['.mkd'],
      currencies: [Currency(code: 'MKD', name: 'MKD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Macedonian', nativeName: 'Macedonian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Norway
    Country(
      name: 'Norway',
      nameTranslations: {'en': 'Norway'},
      alpha2Code: 'NO',
      alpha3Code: 'NOR',
      numericCode: '578',
      flagEmoji: '🇳🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/NO.png',
      capital: 'Oslo',
      largestCity: 'Oslo',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 5347896,
      area: 0.0, // Not available in CSV
      callingCodes: ['47'],
      topLevelDomains: ['.no'],
      currencies: [Currency(code: 'NOK', name: 'NOK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Norwegian', nativeName: 'Norwegian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Oman
    Country(
      name: 'Oman',
      nameTranslations: {'en': 'Oman'},
      alpha2Code: 'OM',
      alpha3Code: 'OMN',
      numericCode: '512',
      flagEmoji: '🇴🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/OM.png',
      capital: 'Muscat',
      largestCity: 'Seeb',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 5266535,
      area: 0.0, // Not available in CSV
      callingCodes: ['968'],
      topLevelDomains: ['.om'],
      currencies: [Currency(code: 'OMR', name: 'OMR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Pakistan
    Country(
      name: 'Pakistan',
      nameTranslations: {'en': 'Pakistan'},
      alpha2Code: 'PK',
      alpha3Code: 'PAK',
      numericCode: '586',
      flagEmoji: '🇵🇰',
      flagImagePath: 'packages/countrify/assets/images/flags/PK.png',
      capital: 'Islamabad',
      largestCity: 'Karachi',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 216565318,
      area: 0.0, // Not available in CSV
      callingCodes: ['92'],
      topLevelDomains: ['.pk'],
      currencies: [Currency(code: 'PKR', name: 'PKR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Urdu', nativeName: 'Urdu')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Palau
    Country(
      name: 'Palau',
      nameTranslations: {'en': 'Palau'},
      alpha2Code: 'PW',
      alpha3Code: 'PLW',
      numericCode: '585',
      flagEmoji: '🇵🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/PW.png',
      capital: 'Ngerulmud',
      largestCity: 'Koror',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 18233,
      area: 0.0, // Not available in CSV
      callingCodes: ['680'],
      topLevelDomains: ['.pw'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Palestinian National Authority
    Country(
      name: 'Palestinian National Authority',
      nameTranslations: {'en': 'Palestinian National Authority'},
      alpha2Code: 'PNA',
      alpha3Code: 'UNK',
      numericCode: '000',
      flagEmoji: '🏳️',
      flagImagePath: 'packages/countrify/assets/images/flags/PNA.png',
      capital: 'Ramallah',
      largestCity: 'Gaza City',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 5300000,
      area: 0.0, // Not available in CSV
      callingCodes: ['970'],
      topLevelDomains: ['.pna'],
      currencies: [Currency(code: 'JOD', name: 'JOD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Panama
    Country(
      name: 'Panama',
      nameTranslations: {'en': 'Panama'},
      alpha2Code: 'PA',
      alpha3Code: 'PAN',
      numericCode: '591',
      flagEmoji: '🇵🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/PA.png',
      capital: 'Panama City',
      largestCity: 'Panama City',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 4246439,
      area: 0.0, // Not available in CSV
      callingCodes: ['507'],
      topLevelDomains: ['.pa'],
      currencies: [Currency(code: 'PAB', name: 'PAB', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Papua New Guinea
    Country(
      name: 'Papua New Guinea',
      nameTranslations: {'en': 'Papua New Guinea'},
      alpha2Code: 'PG',
      alpha3Code: 'PNG',
      numericCode: '598',
      flagEmoji: '🇵🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/PG.png',
      capital: 'Port Moresby',
      largestCity: 'Port Moresby',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 8776109,
      area: 0.0, // Not available in CSV
      callingCodes: ['675'],
      topLevelDomains: ['.pg'],
      currencies: [Currency(code: 'PGK', name: 'PGK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Tok Pisin', nativeName: 'Tok Pisin')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Paraguay
    Country(
      name: 'Paraguay',
      nameTranslations: {'en': 'Paraguay'},
      alpha2Code: 'PY',
      alpha3Code: 'PRY',
      numericCode: '600',
      flagEmoji: '🇵🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/PY.png',
      capital: 'Asunci',
      largestCity: 'Ciudad del Este',
      region: 'Americas',
      subregion: 'South America',
      population: 7044636,
      area: 0.0, // Not available in CSV
      callingCodes: ['595'],
      topLevelDomains: ['.py'],
      currencies: [Currency(code: 'PYG', name: 'PYG', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Peru
    Country(
      name: 'Peru',
      nameTranslations: {'en': 'Peru'},
      alpha2Code: 'PE',
      alpha3Code: 'PER',
      numericCode: '604',
      flagEmoji: '🇵🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/PE.png',
      capital: 'Lima',
      largestCity: 'Lima',
      region: 'Americas',
      subregion: 'Central America',
      population: 32510453,
      area: 0.0, // Not available in CSV
      callingCodes: ['51'],
      topLevelDomains: ['.pe'],
      currencies: [Currency(code: 'PEN', name: 'PEN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Philippines
    Country(
      name: 'Philippines',
      nameTranslations: {'en': 'Philippines'},
      alpha2Code: 'PH',
      alpha3Code: 'PHL',
      numericCode: '608',
      flagEmoji: '🇵🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/PH.png',
      capital: 'Manila',
      largestCity: 'Manila',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 108116615,
      area: 0.0, // Not available in CSV
      callingCodes: ['63'],
      topLevelDomains: ['.ph'],
      currencies: [Currency(code: 'PHP', name: 'PHP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Poland
    Country(
      name: 'Poland',
      nameTranslations: {'en': 'Poland'},
      alpha2Code: 'PL',
      alpha3Code: 'POL',
      numericCode: '616',
      flagEmoji: '🇵🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/PL.png',
      capital: 'Warsaw',
      largestCity: 'Warsaw',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 37970874,
      area: 0.0, // Not available in CSV
      callingCodes: ['48'],
      topLevelDomains: ['.pl'],
      currencies: [Currency(code: 'PLN', name: 'PLN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Polish', nativeName: 'Polish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Portugal
    Country(
      name: 'Portugal',
      nameTranslations: {'en': 'Portugal'},
      alpha2Code: 'PT',
      alpha3Code: 'PRT',
      numericCode: '620',
      flagEmoji: '🇵🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/PT.png',
      capital: 'Lisbon',
      largestCity: 'Lisbon',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 10269417,
      area: 0.0, // Not available in CSV
      callingCodes: ['351'],
      topLevelDomains: ['.pt'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Qatar
    Country(
      name: 'Qatar',
      nameTranslations: {'en': 'Qatar'},
      alpha2Code: 'QA',
      alpha3Code: 'QAT',
      numericCode: '634',
      flagEmoji: '🇶🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/QA.png',
      capital: 'Doha',
      largestCity: 'Doha',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 2832067,
      area: 0.0, // Not available in CSV
      callingCodes: ['974'],
      topLevelDomains: ['.qa'],
      currencies: [Currency(code: 'QAR', name: 'QAR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Romania
    Country(
      name: 'Romania',
      nameTranslations: {'en': 'Romania'},
      alpha2Code: 'RO',
      alpha3Code: 'ROU',
      numericCode: '642',
      flagEmoji: '🇷🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/RO.png',
      capital: 'Bucharest',
      largestCity: 'Bucharest',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 19356544,
      area: 0.0, // Not available in CSV
      callingCodes: ['40'],
      topLevelDomains: ['.ro'],
      currencies: [Currency(code: 'RON', name: 'RON', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Romanian', nativeName: 'Romanian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Russia
    Country(
      name: 'Russia',
      nameTranslations: {'en': 'Russia'},
      alpha2Code: 'RU',
      alpha3Code: 'RUS',
      numericCode: '643',
      flagEmoji: '🇷🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/RU.png',
      capital: 'Moscow',
      largestCity: 'Moscow',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 144373535,
      area: 0.0, // Not available in CSV
      callingCodes: ['7'],
      topLevelDomains: ['.ru'],
      currencies: [Currency(code: 'RUB', name: 'RUB', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Russian', nativeName: 'Russian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Rwanda
    Country(
      name: 'Rwanda',
      nameTranslations: {'en': 'Rwanda'},
      alpha2Code: 'RW',
      alpha3Code: 'RWA',
      numericCode: '646',
      flagEmoji: '🇷🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/RW.png',
      capital: 'Kigali',
      largestCity: 'Kigali',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 12626950,
      area: 0.0, // Not available in CSV
      callingCodes: ['250'],
      topLevelDomains: ['.rw'],
      currencies: [Currency(code: 'RWF', name: 'RWF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swahili', nativeName: 'Swahili')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Saint Kitts and Nevis
    Country(
      name: 'Saint Kitts and Nevis',
      nameTranslations: {'en': 'Saint Kitts and Nevis'},
      alpha2Code: 'KN',
      alpha3Code: 'KNA',
      numericCode: '659',
      flagEmoji: '🇰🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/KN.png',
      capital: 'Basseterre',
      largestCity: 'Basseterre',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 52823,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.kn'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Saint Lucia
    Country(
      name: 'Saint Lucia',
      nameTranslations: {'en': 'Saint Lucia'},
      alpha2Code: 'LC',
      alpha3Code: 'LCA',
      numericCode: '662',
      flagEmoji: '🇱🇨',
      flagImagePath: 'packages/countrify/assets/images/flags/LC.png',
      capital: 'Castries',
      largestCity: 'Castries',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 182790,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.lc'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Saint Vincent and the Grenadines
    Country(
      name: 'Saint Vincent and the Grenadines',
      nameTranslations: {'en': 'Saint Vincent and the Grenadines'},
      alpha2Code: 'VC',
      alpha3Code: 'VCT',
      numericCode: '670',
      flagEmoji: '🇻🇨',
      flagImagePath: 'packages/countrify/assets/images/flags/VC.png',
      capital: 'Kingstown',
      largestCity: 'Calliaqua',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 100455,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.vc'],
      currencies: [Currency(code: 'XCD', name: 'XCD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Samoa
    Country(
      name: 'Samoa',
      nameTranslations: {'en': 'Samoa'},
      alpha2Code: 'WS',
      alpha3Code: 'WSM',
      numericCode: '882',
      flagEmoji: '🇼🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/WS.png',
      capital: 'Apia',
      largestCity: 'Apia',
      region: 'Americas',
      subregion: 'Central America',
      population: 202506,
      area: 0.0, // Not available in CSV
      callingCodes: ['685'],
      topLevelDomains: ['.ws'],
      currencies: [Currency(code: 'WST', name: 'WST', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Samoan', nativeName: 'Samoan')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // San Marino
    Country(
      name: 'San Marino',
      nameTranslations: {'en': 'San Marino'},
      alpha2Code: 'SM',
      alpha3Code: 'SMR',
      numericCode: '674',
      flagEmoji: '🇸🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/SM.png',
      capital: 'City of San Marino',
      largestCity: 'City of San Marino',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 33860,
      area: 0.0, // Not available in CSV
      callingCodes: ['378'],
      topLevelDomains: ['.sm'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Italian', nativeName: 'Italian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // S
    Country(
      name: 'S',
      nameTranslations: {'en': 'S'},
      alpha2Code: 'ST',
      alpha3Code: 'STP',
      numericCode: '678',
      flagEmoji: '🇸🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/ST.png',
      capital: 'S',
      largestCity: 'S',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 215056,
      area: 0.0, // Not available in CSV
      callingCodes: ['239'],
      topLevelDomains: ['.st'],
      currencies: [Currency(code: 'STN', name: 'STN', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: '', nativeName: '')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Saudi Arabia
    Country(
      name: 'Saudi Arabia',
      nameTranslations: {'en': 'Saudi Arabia'},
      alpha2Code: 'SA',
      alpha3Code: 'SAU',
      numericCode: '682',
      flagEmoji: '🇸🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/SA.png',
      capital: 'Riyadh',
      largestCity: 'Riyadh',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 34268528,
      area: 0.0, // Not available in CSV
      callingCodes: ['966'],
      topLevelDomains: ['.sa'],
      currencies: [Currency(code: 'SAR', name: 'SAR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Senegal
    Country(
      name: 'Senegal',
      nameTranslations: {'en': 'Senegal'},
      alpha2Code: 'SN',
      alpha3Code: 'SEN',
      numericCode: '686',
      flagEmoji: '🇸🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/SN.png',
      capital: 'Dakar',
      largestCity: 'Pikine',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 16296364,
      area: 0.0, // Not available in CSV
      callingCodes: ['221'],
      topLevelDomains: ['.sn'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Serbia
    Country(
      name: 'Serbia',
      nameTranslations: {'en': 'Serbia'},
      alpha2Code: 'RS',
      alpha3Code: 'SRB',
      numericCode: '688',
      flagEmoji: '🇷🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/RS.png',
      capital: 'Belgrade',
      largestCity: 'Belgrade',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 6944975,
      area: 0.0, // Not available in CSV
      callingCodes: ['381'],
      topLevelDomains: ['.rs'],
      currencies: [Currency(code: 'RSD', name: 'RSD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Serbian', nativeName: 'Serbian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Seychelles
    Country(
      name: 'Seychelles',
      nameTranslations: {'en': 'Seychelles'},
      alpha2Code: 'SC',
      alpha3Code: 'SYC',
      numericCode: '690',
      flagEmoji: '🇸🇨',
      flagImagePath: 'packages/countrify/assets/images/flags/SC.png',
      capital: 'Victoria, Seychelles',
      largestCity: 'Victoria, Seychelles',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 97625,
      area: 0.0, // Not available in CSV
      callingCodes: ['248'],
      topLevelDomains: ['.sc'],
      currencies: [Currency(code: 'SCR', name: 'SCR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Sierra Leone
    Country(
      name: 'Sierra Leone',
      nameTranslations: {'en': 'Sierra Leone'},
      alpha2Code: 'SL',
      alpha3Code: 'SLE',
      numericCode: '694',
      flagEmoji: '🇸🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/SL.png',
      capital: 'Freetown',
      largestCity: 'Freetown',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 7813215,
      area: 0.0, // Not available in CSV
      callingCodes: ['232'],
      topLevelDomains: ['.sl'],
      currencies: [Currency(code: 'SLL', name: 'SLL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Singapore
    Country(
      name: 'Singapore',
      nameTranslations: {'en': 'Singapore'},
      alpha2Code: 'SG',
      alpha3Code: 'SGP',
      numericCode: '702',
      flagEmoji: '🇸🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/SG.png',
      capital: 'Singapore',
      largestCity: 'Singapore',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 5703569,
      area: 0.0, // Not available in CSV
      callingCodes: ['65'],
      topLevelDomains: ['.sg'],
      currencies: [Currency(code: 'SGD', name: 'SGD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Malay', nativeName: 'Malay')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Slovakia
    Country(
      name: 'Slovakia',
      nameTranslations: {'en': 'Slovakia'},
      alpha2Code: 'SK',
      alpha3Code: 'SVK',
      numericCode: '703',
      flagEmoji: '🇸🇰',
      flagImagePath: 'packages/countrify/assets/images/flags/SK.png',
      capital: 'Bratislava',
      largestCity: 'Bratislava',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 5454073,
      area: 0.0, // Not available in CSV
      callingCodes: ['421'],
      topLevelDomains: ['.sk'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Slovak', nativeName: 'Slovak')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Slovenia
    Country(
      name: 'Slovenia',
      nameTranslations: {'en': 'Slovenia'},
      alpha2Code: 'SI',
      alpha3Code: 'SVN',
      numericCode: '705',
      flagEmoji: '🇸🇮',
      flagImagePath: 'packages/countrify/assets/images/flags/SI.png',
      capital: 'Ljubljana',
      largestCity: 'Ljubljana',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 2087946,
      area: 0.0, // Not available in CSV
      callingCodes: ['386'],
      topLevelDomains: ['.si'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Slovene language', nativeName: 'Slovene language')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Solomon Islands
    Country(
      name: 'Solomon Islands',
      nameTranslations: {'en': 'Solomon Islands'},
      alpha2Code: 'SB',
      alpha3Code: 'SLB',
      numericCode: '090',
      flagEmoji: '🇸🇧',
      flagImagePath: 'packages/countrify/assets/images/flags/SB.png',
      capital: 'Honiara',
      largestCity: 'Honiara',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 669823,
      area: 0.0, // Not available in CSV
      callingCodes: ['677'],
      topLevelDomains: ['.sb'],
      currencies: [Currency(code: 'SBD', name: 'SBD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Somalia
    Country(
      name: 'Somalia',
      nameTranslations: {'en': 'Somalia'},
      alpha2Code: 'SO',
      alpha3Code: 'SOM',
      numericCode: '706',
      flagEmoji: '🇸🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/SO.png',
      capital: 'Mogadishu',
      largestCity: 'Bosaso',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 15442905,
      area: 0.0, // Not available in CSV
      callingCodes: ['252'],
      topLevelDomains: ['.so'],
      currencies: [Currency(code: 'SOS', name: 'SOS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // South Africa
    Country(
      name: 'South Africa',
      nameTranslations: {'en': 'South Africa'},
      alpha2Code: 'ZA',
      alpha3Code: 'ZAF',
      numericCode: '710',
      flagEmoji: '🇿🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/ZA.png',
      capital: 'Pretoria',
      largestCity: 'Johannesburg',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 58558270,
      area: 0.0, // Not available in CSV
      callingCodes: ['27'],
      topLevelDomains: ['.za'],
      currencies: [Currency(code: 'ZAR', name: 'ZAR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Afrikaans', nativeName: 'Afrikaans')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // South Korea
    Country(
      name: 'South Korea',
      nameTranslations: {'en': 'South Korea'},
      alpha2Code: 'KR',
      alpha3Code: 'KOR',
      numericCode: '410',
      flagEmoji: '🇰🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/KR.png',
      capital: 'Seoul',
      largestCity: 'Seoul',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 51709098,
      area: 0.0, // Not available in CSV
      callingCodes: ['82'],
      topLevelDomains: ['.kr'],
      currencies: [Currency(code: 'KRW', name: 'KRW', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Korean', nativeName: 'Korean')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // South Sudan
    Country(
      name: 'South Sudan',
      nameTranslations: {'en': 'South Sudan'},
      alpha2Code: 'SS',
      alpha3Code: 'SSD',
      numericCode: '728',
      flagEmoji: '🇸🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/SS.png',
      capital: 'Juba',
      largestCity: 'Juba',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 11062113,
      area: 0.0, // Not available in CSV
      callingCodes: ['211'],
      topLevelDomains: ['.ss'],
      currencies: [Currency(code: 'SSP', name: 'SSP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Spain
    Country(
      name: 'Spain',
      nameTranslations: {'en': 'Spain'},
      alpha2Code: 'ES',
      alpha3Code: 'ESP',
      numericCode: '724',
      flagEmoji: '🇪🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/ES.png',
      capital: 'Madrid',
      largestCity: 'Madrid',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 47076781,
      area: 0.0, // Not available in CSV
      callingCodes: ['34'],
      topLevelDomains: ['.es'],
      currencies: [Currency(code: 'EUR', name: 'EUR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Sri Lanka
    Country(
      name: 'Sri Lanka',
      nameTranslations: {'en': 'Sri Lanka'},
      alpha2Code: 'LK',
      alpha3Code: 'LKA',
      numericCode: '144',
      flagEmoji: '🇱🇰',
      flagImagePath: 'packages/countrify/assets/images/flags/LK.png',
      capital: 'Colombo',
      largestCity: 'Colombo',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 21803000,
      area: 0.0, // Not available in CSV
      callingCodes: ['94'],
      topLevelDomains: ['.lk'],
      currencies: [Currency(code: 'LKR', name: 'LKR', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Tamil', nativeName: 'Tamil')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Sudan
    Country(
      name: 'Sudan',
      nameTranslations: {'en': 'Sudan'},
      alpha2Code: 'SD',
      alpha3Code: 'SDN',
      numericCode: '729',
      flagEmoji: '🇸🇩',
      flagImagePath: 'packages/countrify/assets/images/flags/SD.png',
      capital: 'Khartoum',
      largestCity: 'Omdurman',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 42813238,
      area: 0.0, // Not available in CSV
      callingCodes: ['249'],
      topLevelDomains: ['.sd'],
      currencies: [Currency(code: 'SDG', name: 'SDG', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Suriname
    Country(
      name: 'Suriname',
      nameTranslations: {'en': 'Suriname'},
      alpha2Code: 'SR',
      alpha3Code: 'SUR',
      numericCode: '740',
      flagEmoji: '🇸🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/SR.png',
      capital: 'Paramaribo',
      largestCity: 'Paramaribo',
      region: 'Americas',
      subregion: 'Central America',
      population: 581372,
      area: 0.0, // Not available in CSV
      callingCodes: ['597'],
      topLevelDomains: ['.sr'],
      currencies: [Currency(code: 'SRD', name: 'SRD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Dutch', nativeName: 'Dutch')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Sweden
    Country(
      name: 'Sweden',
      nameTranslations: {'en': 'Sweden'},
      alpha2Code: 'SE',
      alpha3Code: 'SWE',
      numericCode: '752',
      flagEmoji: '🇸🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/SE.png',
      capital: 'Stockholm',
      largestCity: 'Stockholm',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 10285453,
      area: 0.0, // Not available in CSV
      callingCodes: ['46'],
      topLevelDomains: ['.se'],
      currencies: [Currency(code: 'SEK', name: 'SEK', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swedish', nativeName: 'Swedish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Switzerland
    Country(
      name: 'Switzerland',
      nameTranslations: {'en': 'Switzerland'},
      alpha2Code: 'CH',
      alpha3Code: 'CHE',
      numericCode: '756',
      flagEmoji: '🇨🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/CH.png',
      capital: 'Bern',
      largestCity: 'Zurich',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 8574832,
      area: 0.0, // Not available in CSV
      callingCodes: ['41'],
      topLevelDomains: ['.ch'],
      currencies: [Currency(code: 'CHF', name: 'CHF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'German', nativeName: 'German')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Syria
    Country(
      name: 'Syria',
      nameTranslations: {'en': 'Syria'},
      alpha2Code: 'SY',
      alpha3Code: 'SYR',
      numericCode: '760',
      flagEmoji: '🇸🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/SY.png',
      capital: 'Damascus',
      largestCity: 'Damascus',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 17070135,
      area: 0.0, // Not available in CSV
      callingCodes: ['963'],
      topLevelDomains: ['.sy'],
      currencies: [Currency(code: 'SYP', name: 'SYP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Tajikistan
    Country(
      name: 'Tajikistan',
      nameTranslations: {'en': 'Tajikistan'},
      alpha2Code: 'TJ',
      alpha3Code: 'TJK',
      numericCode: '762',
      flagEmoji: '🇹🇯',
      flagImagePath: 'packages/countrify/assets/images/flags/TJ.png',
      capital: 'Dushanbe',
      largestCity: 'Dushanbe',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 9321018,
      area: 0.0, // Not available in CSV
      callingCodes: ['992'],
      topLevelDomains: ['.tj'],
      currencies: [Currency(code: 'TJS', name: 'TJS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Persian', nativeName: 'Persian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Tanzania
    Country(
      name: 'Tanzania',
      nameTranslations: {'en': 'Tanzania'},
      alpha2Code: 'TZ',
      alpha3Code: 'TZA',
      numericCode: '834',
      flagEmoji: '🇹🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/TZ.png',
      capital: 'Dodoma',
      largestCity: 'Dar es Salaam',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 58005463,
      area: 0.0, // Not available in CSV
      callingCodes: ['255'],
      topLevelDomains: ['.tz'],
      currencies: [Currency(code: 'TZS', name: 'TZS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swahili', nativeName: 'Swahili')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Thailand
    Country(
      name: 'Thailand',
      nameTranslations: {'en': 'Thailand'},
      alpha2Code: 'TH',
      alpha3Code: 'THA',
      numericCode: '764',
      flagEmoji: '🇹🇭',
      flagImagePath: 'packages/countrify/assets/images/flags/TH.png',
      capital: 'Bangkok',
      largestCity: 'Bangkok',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 69625582,
      area: 0.0, // Not available in CSV
      callingCodes: ['66'],
      topLevelDomains: ['.th'],
      currencies: [Currency(code: 'THB', name: 'THB', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Thai', nativeName: 'Thai')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // East Timor
    Country(
      name: 'East Timor',
      nameTranslations: {'en': 'East Timor'},
      alpha2Code: 'TL',
      alpha3Code: 'TLS',
      numericCode: '626',
      flagEmoji: '🇹🇱',
      flagImagePath: 'packages/countrify/assets/images/flags/TL.png',
      capital: 'Dili',
      largestCity: 'Dili',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 3500000,
      area: 0.0, // Not available in CSV
      callingCodes: ['670'],
      topLevelDomains: ['.tl'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Portuguese', nativeName: 'Portuguese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Togo
    Country(
      name: 'Togo',
      nameTranslations: {'en': 'Togo'},
      alpha2Code: 'TG',
      alpha3Code: 'TGO',
      numericCode: '768',
      flagEmoji: '🇹🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/TG.png',
      capital: 'Lom',
      largestCity: 'Lom',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 8082366,
      area: 0.0, // Not available in CSV
      callingCodes: ['228'],
      topLevelDomains: ['.tg'],
      currencies: [Currency(code: 'XOF', name: 'XOF', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Tonga
    Country(
      name: 'Tonga',
      nameTranslations: {'en': 'Tonga'},
      alpha2Code: 'TO',
      alpha3Code: 'TON',
      numericCode: '776',
      flagEmoji: '🇹🇴',
      flagImagePath: 'packages/countrify/assets/images/flags/TO.png',
      capital: 'Nuku',
      largestCity: 'Nuku',
      region: 'Americas',
      subregion: 'South America',
      population: 100209,
      area: 0.0, // Not available in CSV
      callingCodes: ['676'],
      topLevelDomains: ['.to'],
      currencies: [Currency(code: 'TOP', name: 'TOP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Tongan', nativeName: 'Tongan')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Trinidad and Tobago
    Country(
      name: 'Trinidad and Tobago',
      nameTranslations: {'en': 'Trinidad and Tobago'},
      alpha2Code: 'TT',
      alpha3Code: 'TTO',
      numericCode: '780',
      flagEmoji: '🇹🇹',
      flagImagePath: 'packages/countrify/assets/images/flags/TT.png',
      capital: 'Port of Spain',
      largestCity: 'Chaguanas',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 1394973,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.tt'],
      currencies: [Currency(code: 'TTD', name: 'TTD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Tunisia
    Country(
      name: 'Tunisia',
      nameTranslations: {'en': 'Tunisia'},
      alpha2Code: 'TN',
      alpha3Code: 'TUN',
      numericCode: '788',
      flagEmoji: '🇹🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/TN.png',
      capital: 'Tunis',
      largestCity: 'Tunis',
      region: 'Africa',
      subregion: 'Northern Africa',
      population: 11694719,
      area: 0.0, // Not available in CSV
      callingCodes: ['216'],
      topLevelDomains: ['.tn'],
      currencies: [Currency(code: 'TND', name: 'TND', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Turkey
    Country(
      name: 'Turkey',
      nameTranslations: {'en': 'Turkey'},
      alpha2Code: 'TR',
      alpha3Code: 'TUR',
      numericCode: '792',
      flagEmoji: '🇹🇷',
      flagImagePath: 'packages/countrify/assets/images/flags/TR.png',
      capital: 'Ankara',
      largestCity: 'Istanbul',
      region: 'Europe',
      subregion: 'Southern Europe',
      population: 83429615,
      area: 0.0, // Not available in CSV
      callingCodes: ['90'],
      topLevelDomains: ['.tr'],
      currencies: [Currency(code: 'TRY', name: 'TRY', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Turkish', nativeName: 'Turkish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Turkmenistan
    Country(
      name: 'Turkmenistan',
      nameTranslations: {'en': 'Turkmenistan'},
      alpha2Code: 'TM',
      alpha3Code: 'TKM',
      numericCode: '795',
      flagEmoji: '🇹🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/TM.png',
      capital: 'Ashgabat',
      largestCity: 'Ashgabat',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 5942089,
      area: 0.0, // Not available in CSV
      callingCodes: ['993'],
      topLevelDomains: ['.tm'],
      currencies: [Currency(code: 'TMT', name: 'TMT', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Turkmen', nativeName: 'Turkmen')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Tuvalu
    Country(
      name: 'Tuvalu',
      nameTranslations: {'en': 'Tuvalu'},
      alpha2Code: 'TV',
      alpha3Code: 'TUV',
      numericCode: '798',
      flagEmoji: '🇹🇻',
      flagImagePath: 'packages/countrify/assets/images/flags/TV.png',
      capital: 'Funafuti',
      largestCity: 'Singapore',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 11646,
      area: 0.0, // Not available in CSV
      callingCodes: ['688'],
      topLevelDomains: ['.tv'],
      currencies: [Currency(code: 'AUD', name: 'AUD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Tuvaluan', nativeName: 'Tuvaluan')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Uganda
    Country(
      name: 'Uganda',
      nameTranslations: {'en': 'Uganda'},
      alpha2Code: 'UG',
      alpha3Code: 'UGA',
      numericCode: '800',
      flagEmoji: '🇺🇬',
      flagImagePath: 'packages/countrify/assets/images/flags/UG.png',
      capital: 'Kampala',
      largestCity: 'Buganda',
      region: 'Africa',
      subregion: 'Western Africa',
      population: 44269594,
      area: 0.0, // Not available in CSV
      callingCodes: ['256'],
      topLevelDomains: ['.ug'],
      currencies: [Currency(code: 'UGX', name: 'UGX', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Swahili', nativeName: 'Swahili')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Ukraine
    Country(
      name: 'Ukraine',
      nameTranslations: {'en': 'Ukraine'},
      alpha2Code: 'UA',
      alpha3Code: 'UKR',
      numericCode: '804',
      flagEmoji: '🇺🇦',
      flagImagePath: 'packages/countrify/assets/images/flags/UA.png',
      capital: 'Kyiv',
      largestCity: 'Kyiv',
      region: 'Europe',
      subregion: 'Western Europe',
      population: 44385155,
      area: 0.0, // Not available in CSV
      callingCodes: ['380'],
      topLevelDomains: ['.ua'],
      currencies: [Currency(code: 'UAH', name: 'UAH', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Ukrainian', nativeName: 'Ukrainian')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // United Arab Emirates
    Country(
      name: 'United Arab Emirates',
      nameTranslations: {'en': 'United Arab Emirates'},
      alpha2Code: 'AE',
      alpha3Code: 'ARE',
      numericCode: '784',
      flagEmoji: '🇦🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/AE.png',
      capital: 'Abu Dhabi',
      largestCity: 'Dubai',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 9770529,
      area: 0.0, // Not available in CSV
      callingCodes: ['971'],
      topLevelDomains: ['.ae'],
      currencies: [Currency(code: 'AED', name: 'AED', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // United Kingdom
    Country(
      name: 'United Kingdom',
      nameTranslations: {'en': 'United Kingdom'},
      alpha2Code: 'GB',
      alpha3Code: 'GBR',
      numericCode: '826',
      flagEmoji: '🇬🇧',
      flagImagePath: 'packages/countrify/assets/images/flags/GB.png',
      capital: 'London',
      largestCity: 'London',
      region: 'Europe',
      subregion: 'Northern Europe',
      population: 66834405,
      area: 0.0, // Not available in CSV
      callingCodes: ['44'],
      topLevelDomains: ['.gb'],
      currencies: [Currency(code: 'GBP', name: 'GBP', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // United States
    Country(
      name: 'United States',
      nameTranslations: {'en': 'United States'},
      alpha2Code: 'US',
      alpha3Code: 'USA',
      numericCode: '840',
      flagEmoji: '🇺🇸',
      flagImagePath: 'packages/countrify/assets/images/flags/US.png',
      capital: 'Washington, D.C.',
      largestCity: 'New York City',
      region: 'Asia',
      subregion: 'Southern Asia',
      population: 328239523,
      area: 0.0, // Not available in CSV
      callingCodes: ['1'],
      topLevelDomains: ['.us'],
      currencies: [Currency(code: 'USD', name: 'USD', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Uruguay
    Country(
      name: 'Uruguay',
      nameTranslations: {'en': 'Uruguay'},
      alpha2Code: 'UY',
      alpha3Code: 'URY',
      numericCode: '858',
      flagEmoji: '🇺🇾',
      flagImagePath: 'packages/countrify/assets/images/flags/UY.png',
      capital: 'Montevideo',
      largestCity: 'Montevideo',
      region: 'Americas',
      subregion: 'South America',
      population: 3461734,
      area: 0.0, // Not available in CSV
      callingCodes: ['598'],
      topLevelDomains: ['.uy'],
      currencies: [Currency(code: 'UYU', name: 'UYU', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Uzbekistan
    Country(
      name: 'Uzbekistan',
      nameTranslations: {'en': 'Uzbekistan'},
      alpha2Code: 'UZ',
      alpha3Code: 'UZB',
      numericCode: '860',
      flagEmoji: '🇺🇿',
      flagImagePath: 'packages/countrify/assets/images/flags/UZ.png',
      capital: 'Tashkent',
      largestCity: 'Tashkent',
      region: 'Asia',
      subregion: 'Eastern Asia',
      population: 33580650,
      area: 0.0, // Not available in CSV
      callingCodes: ['998'],
      topLevelDomains: ['.uz'],
      currencies: [Currency(code: 'UZS', name: 'UZS', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Uzbek', nativeName: 'Uzbek')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Vanuatu
    Country(
      name: 'Vanuatu',
      nameTranslations: {'en': 'Vanuatu'},
      alpha2Code: 'VU',
      alpha3Code: 'VUT',
      numericCode: '548',
      flagEmoji: '🇻🇺',
      flagImagePath: 'packages/countrify/assets/images/flags/VU.png',
      capital: 'Port Vila',
      largestCity: 'Port Vila',
      region: 'Oceania',
      subregion: 'Polynesia',
      population: 299882,
      area: 0.0, // Not available in CSV
      callingCodes: ['678'],
      topLevelDomains: ['.vu'],
      currencies: [Currency(code: 'VUV', name: 'VUV', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'French', nativeName: 'French')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Venezuela
    Country(
      name: 'Venezuela',
      nameTranslations: {'en': 'Venezuela'},
      alpha2Code: 'VE',
      alpha3Code: 'VEN',
      numericCode: '862',
      flagEmoji: '🇻🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/VE.png',
      capital: 'Caracas',
      largestCity: 'Caracas',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 28515829,
      area: 0.0, // Not available in CSV
      callingCodes: ['58'],
      topLevelDomains: ['.ve'],
      currencies: [Currency(code: 'VED', name: 'VED', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Spanish', nativeName: 'Spanish')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Vietnam
    Country(
      name: 'Vietnam',
      nameTranslations: {'en': 'Vietnam'},
      alpha2Code: 'VN',
      alpha3Code: 'VNM',
      numericCode: '704',
      flagEmoji: '🇻🇳',
      flagImagePath: 'packages/countrify/assets/images/flags/VN.png',
      capital: 'Hanoi',
      largestCity: 'Ho Chi Minh City',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 96462106,
      area: 0.0, // Not available in CSV
      callingCodes: ['84'],
      topLevelDomains: ['.vn'],
      currencies: [Currency(code: 'VND', name: 'VND', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Vietnamese', nativeName: 'Vietnamese')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Yemen
    Country(
      name: 'Yemen',
      nameTranslations: {'en': 'Yemen'},
      alpha2Code: 'YE',
      alpha3Code: 'YEM',
      numericCode: '887',
      flagEmoji: '🇾🇪',
      flagImagePath: 'packages/countrify/assets/images/flags/YE.png',
      capital: 'Sanaa',
      largestCity: 'Sanaa',
      region: 'Asia',
      subregion: 'South-Eastern Asia',
      population: 29161922,
      area: 0.0, // Not available in CSV
      callingCodes: ['967'],
      topLevelDomains: ['.ye'],
      currencies: [Currency(code: 'YER', name: 'YER', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Arabic', nativeName: 'Arabic')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Zambia
    Country(
      name: 'Zambia',
      nameTranslations: {'en': 'Zambia'},
      alpha2Code: 'ZM',
      alpha3Code: 'ZMB',
      numericCode: '894',
      flagEmoji: '🇿🇲',
      flagImagePath: 'packages/countrify/assets/images/flags/ZM.png',
      capital: 'Lusaka',
      largestCity: 'Lusaka',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 17861030,
      area: 0.0, // Not available in CSV
      callingCodes: ['260'],
      topLevelDomains: ['.zm'],
      currencies: [Currency(code: 'ZMW', name: 'ZMW', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'English', nativeName: 'English')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

    // Zimbabwe
    Country(
      name: 'Zimbabwe',
      nameTranslations: {'en': 'Zimbabwe'},
      alpha2Code: 'ZW',
      alpha3Code: 'ZWE',
      numericCode: '716',
      flagEmoji: '🇿🇼',
      flagImagePath: 'packages/countrify/assets/images/flags/ZW.png',
      capital: 'Harare',
      largestCity: 'Harare',
      region: 'Africa',
      subregion: 'Southern Africa',
      population: 14645468,
      area: 0.0, // Not available in CSV
      callingCodes: ['263'],
      topLevelDomains: ['.zw'],
      currencies: [Currency(code: 'ZWL', name: 'ZWL', symbol: '')],
      languages: [Language(iso6391: 'en', iso6392: 'eng', name: 'Shona', nativeName: 'Shona')],
      timezones: ['UTC+00:00'], // Default timezone
      borders: [], // Not available in CSV
      isIndependent: true, // Default to true
      isUnMember: true, // Default to true
    ),

  ];

  /// Get all countries
  static List<Country> get all => List.unmodifiable(_allCountries);

  /// Get countries by region
  static List<Country> getByRegion(String region) {
    return _allCountries.where((country) => country.region == region).toList();
  }

  /// Get countries by subregion
  static List<Country> getBySubregion(String subregion) {
    return _allCountries.where((country) => country.subregion == subregion).toList();
  }

  /// Get country by alpha-2 code
  static Country? getByAlpha2Code(String alpha2Code) {
    try {
      return _allCountries.firstWhere((country) => country.alpha2Code == alpha2Code.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  /// Get country by alpha-3 code
  static Country? getByAlpha3Code(String alpha3Code) {
    try {
      return _allCountries.firstWhere((country) => country.alpha3Code == alpha3Code.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  /// Get country by numeric code
  static Country? getByNumericCode(String numericCode) {
    try {
      return _allCountries.firstWhere((country) => country.numericCode == numericCode);
    } catch (e) {
      return null;
    }
  }

  /// Search countries by name
  static List<Country> searchByName(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _allCountries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery) ||
          country.nameTranslations.values.any((translation) => 
              translation.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  /// Get independent countries only
  static List<Country> get independent => 
      _allCountries.where((country) => country.isIndependent).toList();

  /// Get UN member countries only
  static List<Country> get unMembers => 
      _allCountries.where((country) => country.isUnMember).toList();
}
