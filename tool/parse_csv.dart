import 'dart:io';
import 'package:csv/csv.dart';

void main() async {
  // Read the CSV file
  final csvFile = File('assets/country_data.csv');
  final csvString = await csvFile.readAsString();

  // Parse CSV
  final csvData = const CsvToListConverter().convert(csvString);

  // Skip header row
  final countries = csvData.skip(1).toList();

  // Generate Dart code
  final buffer = StringBuffer();
  buffer.writeln("import '../models/country.dart';");
  buffer.writeln();
  buffer.writeln('/// Complete list of all countries with ISO 3166-1 codes');
  buffer.writeln('/// Generated from CSV data');
  buffer.writeln('class AllCountries {');
  buffer.writeln('  AllCountries._();');
  buffer.writeln();
  buffer.writeln('  /// Complete list of all countries');
  buffer.writeln('  static const List<Country> _allCountries = [');

  for (final row in countries) {
    if (row.length < 10) continue; // Skip incomplete rows

    // Map CSV columns to variables
    final name = row[0].toString().trim().replaceAll("'", r"\'"); // Country
    final abbreviation = row[1].toString().trim(); // Abbreviation
    final callingCode = row[2].toString().trim(); // Calling Code
    final capital =
        row[3].toString().trim().replaceAll("'", r"\'"); // Capital/Major City
    final currencyCode = row[4].toString().trim(); // Currency-Code
    final largestCity =
        row[5].toString().trim().replaceAll("'", r"\'"); // Largest city
    final language =
        row[6].toString().trim().replaceAll("'", r"\'"); // Official language
    final population =
        row[7].toString().trim().replaceAll(',', ''); // Population
    final latitude = row[8].toString().trim(); // Latitude
    final longitude = row[9].toString().trim(); // Longitude

    // Skip if essential data is missing
    if (name.isEmpty || abbreviation.isEmpty) continue;

    // Generate flag emoji (simplified - you might want to use a proper mapping)
    final flagEmoji = _getFlagEmoji(abbreviation);

    // Determine region based on latitude/longitude (simplified)
    final region = _getRegion(latitude, longitude);
    final subregion = _getSubregion(region, latitude, longitude);

    // Generate alpha-3 code (simplified - you might want to use a proper mapping)
    final alpha3Code = _getAlpha3Code(abbreviation);

    // Generate numeric code (simplified - you might want to use a proper mapping)
    final numericCode = _getNumericCode(abbreviation);

    buffer.writeln('    // $name');
    buffer.writeln('    Country(');
    buffer.writeln("      name: '$name',");
    buffer.writeln("      nameTranslations: {'en': '$name'},");
    buffer.writeln("      alpha2Code: '$abbreviation',");
    buffer.writeln("      alpha3Code: '$alpha3Code',");
    buffer.writeln("      numericCode: '$numericCode',");
    buffer.writeln("      flagEmoji: '$flagEmoji',");
    buffer.writeln(
        "      flagImagePath: 'packages/countrify/assets/images/flags/$abbreviation.png',");
    buffer.writeln("      capital: '$capital',");
    buffer.writeln("      largestCity: '$largestCity',");
    buffer.writeln("      region: '$region',");
    buffer.writeln("      subregion: '$subregion',");
    buffer.writeln(
        "      population: ${population.isNotEmpty ? population : '0'},");
    buffer.writeln('      area: 0.0, // Not available in CSV');
    buffer.writeln("      callingCodes: ['$callingCode'],");
    buffer
        .writeln("      topLevelDomains: ['.${abbreviation.toLowerCase()}'],");
    buffer.writeln(
        "      currencies: [Currency(code: '$currencyCode', name: '$currencyCode', symbol: '')],");
    buffer.writeln(
        "      languages: [Language(iso6391: 'en', iso6392: 'eng', name: '$language', nativeName: '$language')],");
    buffer.writeln("      timezones: ['UTC+00:00'], // Default timezone");
    buffer.writeln('      borders: [], // Not available in CSV');
    buffer.writeln('      isIndependent: true, // Default to true');
    buffer.writeln('      isUnMember: true, // Default to true');
    buffer.writeln('    ),');
    buffer.writeln();
  }

  buffer
    ..writeln('  ];')
    ..writeln()
    ..writeln('  /// Get all countries')
    ..writeln(
        '  static List<Country> get all => List.unmodifiable(_allCountries);')
    ..writeln()
    ..writeln('  /// Get countries by region')
    ..writeln('  static List<Country> getByRegion(String region) {')
    ..writeln(
        '    return _allCountries.where((country) => country.region == region).toList();')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Get countries by subregion')
    ..writeln('  static List<Country> getBySubregion(String subregion) {')
    ..writeln(
        '    return _allCountries.where((country) => country.subregion == subregion).toList();')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Get country by alpha-2 code')
    ..writeln('  static Country? getByAlpha2Code(String alpha2Code) {')
    ..writeln('    try {')
    ..writeln(
        '      return _allCountries.firstWhere((country) => country.alpha2Code == alpha2Code.toUpperCase());')
    ..writeln('    } catch (e) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Get country by alpha-3 code')
    ..writeln('  static Country? getByAlpha3Code(String alpha3Code) {')
    ..writeln('    try {')
    ..writeln(
        '      return _allCountries.firstWhere((country) => country.alpha3Code == alpha3Code.toUpperCase());')
    ..writeln('    } catch (e) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Get country by numeric code')
    ..writeln('  static Country? getByNumericCode(String numericCode) {')
    ..writeln('    try {')
    ..writeln(
        '      return _allCountries.firstWhere((country) => country.numericCode == numericCode);')
    ..writeln('    } catch (e) {')
    ..writeln('      return null;')
    ..writeln('    }')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Search countries by name')
    ..writeln('  static List<Country> searchByName(String query) {')
    ..writeln('    final lowercaseQuery = query.toLowerCase();')
    ..writeln('    return _allCountries.where((country) {')
    ..writeln(
        '      return country.name.toLowerCase().contains(lowercaseQuery) ||')
    ..writeln('          country.nameTranslations.values.any((translation) => ')
    ..writeln(
        '              translation.toLowerCase().contains(lowercaseQuery));')
    ..writeln('    }).toList();')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Get independent countries only')
    ..writeln('  static List<Country> get independent => ')
    ..writeln(
        '      _allCountries.where((country) => country.isIndependent).toList();')
    ..writeln()
    ..writeln('  /// Get UN member countries only')
    ..writeln('  static List<Country> get unMembers => ')
    ..writeln(
        '      _allCountries.where((country) => country.isUnMember).toList();')
    ..writeln('}');

  // Write to file
  final file = File('lib/src/data/all_countries.dart');
  file.writeAsStringSync(buffer.toString());

  print('Generated ${countries.length} countries in all_countries.dart');
}

// Helper functions (simplified implementations)
String _getFlagEmoji(String alpha2Code) {
  // This is a simplified mapping - you might want to use a proper flag emoji library
  final flagMap = {
    'AF': '🇦🇫',
    'AL': '🇦🇱',
    'DZ': '🇩🇿',
    'AS': '🇦🇸',
    'AD': '🇦🇩',
    'AO': '🇦🇴',
    'AI': '🇦🇮',
    'AQ': '🇦🇶',
    'AG': '🇦🇬',
    'AR': '🇦🇷',
    'AM': '🇦🇲',
    'AW': '🇦🇼',
    'AU': '🇦🇺',
    'AT': '🇦🇹',
    'AZ': '🇦🇿',
    'BS': '🇧🇸',
    'BH': '🇧🇭',
    'BD': '🇧🇩',
    'BB': '🇧🇧',
    'BY': '🇧🇾',
    'BE': '🇧🇪',
    'BZ': '🇧🇿',
    'BJ': '🇧🇯',
    'BM': '🇧🇲',
    'BT': '🇧🇹',
    'BO': '🇧🇴',
    'BA': '🇧🇦',
    'BW': '🇧🇼',
    'BR': '🇧🇷',
    'VG': '🇻🇬',
    'BN': '🇧🇳',
    'BG': '🇧🇬',
    'BF': '🇧🇫',
    'BI': '🇧🇮',
    'KH': '🇰🇭',
    'CM': '🇨🇲',
    'CA': '🇨🇦',
    'CV': '🇨🇻',
    'KY': '🇰🇾',
    'CF': '🇨🇫',
    'TD': '🇹🇩',
    'CL': '🇨🇱',
    'CN': '🇨🇳',
    'CX': '🇨🇽',
    'CC': '🇨🇨',
    'CO': '🇨🇴',
    'KM': '🇰🇲',
    'CG': '🇨🇬',
    'CD': '🇨🇩',
    'CK': '🇨🇰',
    'CR': '🇨🇷',
    'CI': '🇨🇮',
    'HR': '🇭🇷',
    'CU': '🇨🇺',
    'CY': '🇨🇾',
    'CZ': '🇨🇿',
    'DK': '🇩🇰',
    'DJ': '🇩🇯',
    'DM': '🇩🇲',
    'DO': '🇩🇴',
    'EC': '🇪🇨',
    'EG': '🇪🇬',
    'SV': '🇸🇻',
    'GQ': '🇬🇶',
    'ER': '🇪🇷',
    'EE': '🇪🇪',
    'ET': '🇪🇹',
    'FK': '🇫🇰',
    'FO': '🇫🇴',
    'FJ': '🇫🇯',
    'FI': '🇫🇮',
    'FR': '🇫🇷',
    'GF': '🇬🇫',
    'PF': '🇵🇫',
    'TF': '🇹🇫',
    'GA': '🇬🇦',
    'GM': '🇬🇲',
    'GE': '🇬🇪',
    'DE': '🇩🇪',
    'GH': '🇬🇭',
    'GI': '🇬🇮',
    'GR': '🇬🇷',
    'GL': '🇬🇱',
    'GD': '🇬🇩',
    'GP': '🇬🇵',
    'GU': '🇬🇺',
    'GT': '🇬🇹',
    'GG': '🇬🇬',
    'GN': '🇬🇳',
    'GW': '🇬🇼',
    'GY': '🇬🇾',
    'HT': '🇭🇹',
    'HM': '🇭🇲',
    'VA': '🇻🇦',
    'HN': '🇭🇳',
    'HK': '🇭🇰',
    'HU': '🇭🇺',
    'IS': '🇮🇸',
    'IN': '🇮🇳',
    'ID': '🇮🇩',
    'IR': '🇮🇷',
    'IQ': '🇮🇶',
    'IE': '🇮🇪',
    'IM': '🇮🇲',
    'IL': '🇮🇱',
    'IT': '🇮🇹',
    'JM': '🇯🇲',
    'JP': '🇯🇵',
    'JE': '🇯🇪',
    'JO': '🇯🇴',
    'KZ': '🇰🇿',
    'KE': '🇰🇪',
    'KI': '🇰🇮',
    'KP': '🇰🇵',
    'KR': '🇰🇷',
    'KW': '🇰🇼',
    'KG': '🇰🇬',
    'LA': '🇱🇦',
    'LV': '🇱🇻',
    'LB': '🇱🇧',
    'LS': '🇱🇸',
    'LR': '🇱🇷',
    'LY': '🇱🇾',
    'LI': '🇱🇮',
    'LT': '🇱🇹',
    'LU': '🇱🇺',
    'MO': '🇲🇴',
    'MK': '🇲🇰',
    'MG': '🇲🇬',
    'MW': '🇲🇼',
    'MY': '🇲🇾',
    'MV': '🇲🇻',
    'ML': '🇲🇱',
    'MT': '🇲🇹',
    'MH': '🇲🇭',
    'MQ': '🇲🇶',
    'MR': '🇲🇷',
    'MU': '🇲🇺',
    'YT': '🇾🇹',
    'MX': '🇲🇽',
    'FM': '🇫🇲',
    'MD': '🇲🇩',
    'MC': '🇲🇨',
    'MN': '🇲🇳',
    'ME': '🇲🇪',
    'MS': '🇲🇸',
    'MA': '🇲🇦',
    'MZ': '🇲🇿',
    'MM': '🇲🇲',
    'NA': '🇳🇦',
    'NR': '🇳🇷',
    'NP': '🇳🇵',
    'NL': '🇳🇱',
    'NC': '🇳🇨',
    'NZ': '🇳🇿',
    'NI': '🇳🇮',
    'NE': '🇳🇪',
    'NG': '🇳🇬',
    'NU': '🇳🇺',
    'NF': '🇳🇫',
    'MP': '🇲🇵',
    'NO': '🇳🇴',
    'OM': '🇴🇲',
    'PK': '🇵🇰',
    'PW': '🇵🇼',
    'PS': '🇵🇸',
    'PA': '🇵🇦',
    'PG': '🇵🇬',
    'PY': '🇵🇾',
    'PE': '🇵🇪',
    'PH': '🇵🇭',
    'PN': '🇵🇳',
    'PL': '🇵🇱',
    'PT': '🇵🇹',
    'PR': '🇵🇷',
    'QA': '🇶🇦',
    'RE': '🇷🇪',
    'RO': '🇷🇴',
    'RU': '🇷🇺',
    'RW': '🇷🇼',
    'BL': '🇧🇱',
    'SH': '🇸🇭',
    'KN': '🇰🇳',
    'LC': '🇱🇨',
    'MF': '🇲🇫',
    'PM': '🇵🇲',
    'VC': '🇻🇨',
    'WS': '🇼🇸',
    'SM': '🇸🇲',
    'ST': '🇸🇹',
    'SA': '🇸🇦',
    'SN': '🇸🇳',
    'RS': '🇷🇸',
    'SC': '🇸🇨',
    'SL': '🇸🇱',
    'SG': '🇸🇬',
    'SX': '🇸🇽',
    'SK': '🇸🇰',
    'SI': '🇸🇮',
    'SB': '🇸🇧',
    'SO': '🇸🇴',
    'ZA': '🇿🇦',
    'GS': '🇬🇸',
    'SS': '🇸🇸',
    'ES': '🇪🇸',
    'LK': '🇱🇰',
    'SD': '🇸🇩',
    'SR': '🇸🇷',
    'SJ': '🇸🇯',
    'SZ': '🇸🇿',
    'SE': '🇸🇪',
    'CH': '🇨🇭',
    'SY': '🇸🇾',
    'TW': '🇹🇼',
    'TJ': '🇹🇯',
    'TZ': '🇹🇿',
    'TH': '🇹🇭',
    'TL': '🇹🇱',
    'TG': '🇹🇬',
    'TK': '🇹🇰',
    'TO': '🇹🇴',
    'TT': '🇹🇹',
    'TN': '🇹🇳',
    'TR': '🇹🇷',
    'TM': '🇹🇲',
    'TC': '🇹🇨',
    'TV': '🇹🇻',
    'UG': '🇺🇬',
    'UA': '🇺🇦',
    'AE': '🇦🇪',
    'GB': '🇬🇧',
    'US': '🇺🇸',
    'UM': '🇺🇲',
    'UY': '🇺🇾',
    'UZ': '🇺🇿',
    'VU': '🇻🇺',
    'VE': '🇻🇪',
    'VN': '🇻🇳',
    'VI': '🇻🇮',
    'WF': '🇼🇫',
    'EH': '🇪🇭',
    'YE': '🇾🇪',
    'ZM': '🇿🇲',
    'ZW': '🇿🇼'
  };

  return flagMap[alpha2Code] ?? '🏳️';
}

String _getRegion(String latitude, String longitude) {
  final lat = double.tryParse(latitude) ?? 0.0;
  final lon = double.tryParse(longitude) ?? 0.0;

  // More accurate region detection based on coordinates
  // Europe
  if (lat >= 35 && lat <= 70 && lon >= -25 && lon <= 40) return 'Europe';

  // Asia
  if (lat >= 5 && lat <= 70 && lon >= 40 && lon <= 180) return 'Asia';
  if (lat >= 5 && lat <= 70 && lon >= -180 && lon <= -25) return 'Asia';

  // Africa
  if (lat >= -35 && lat <= 35 && lon >= -20 && lon <= 55) return 'Africa';

  // Americas
  if (lat >= -60 && lat <= 70 && lon >= -180 && lon <= -20) return 'Americas';

  // Oceania (Pacific region)
  if (lat >= -50 && lat <= 0 && lon >= 100 && lon <= 180) return 'Oceania';
  if (lat >= -50 && lat <= 0 && lon >= -180 && lon <= -100) return 'Oceania';
  if (lat >= -30 && lat <= 0 && lon >= 110 && lon <= 180) return 'Oceania';

  // Antarctic
  if (lat < -60) return 'Antarctic';

  // Default fallback
  if (lat >= 35) return 'Asia';
  if (lat >= -35) return 'Africa';
  return 'Oceania';
}

String _getSubregion(String region, String latitude, String longitude) {
  final lat = double.tryParse(latitude) ?? 0.0;
  final lon = double.tryParse(longitude) ?? 0.0;

  switch (region) {
    case 'Europe':
      if (lat >= 50) return 'Northern Europe';
      if (lat >= 40) return 'Western Europe';
      return 'Southern Europe';
    case 'Asia':
      if (lat >= 40) return 'Eastern Asia';
      if (lat >= 20) return 'Southern Asia';
      return 'South-Eastern Asia';
    case 'Africa':
      if (lat >= 20) return 'Northern Africa';
      if (lat >= -10) return 'Western Africa';
      return 'Southern Africa';
    case 'Americas':
      if (lat >= 10) return 'Northern America';
      if (lat >= -20) return 'Central America';
      return 'South America';
    default:
      return 'Polynesia';
  }
}

String _getAlpha3Code(String alpha2Code) {
  // Simplified mapping - you might want to use a proper ISO 3166-1 mapping
  final alpha3Map = {
    'AF': 'AFG',
    'AL': 'ALB',
    'DZ': 'DZA',
    'AS': 'ASM',
    'AD': 'AND',
    'AO': 'AGO',
    'AI': 'AIA',
    'AQ': 'ATA',
    'AG': 'ATG',
    'AR': 'ARG',
    'AM': 'ARM',
    'AW': 'ABW',
    'AU': 'AUS',
    'AT': 'AUT',
    'AZ': 'AZE',
    'BS': 'BHS',
    'BH': 'BHR',
    'BD': 'BGD',
    'BB': 'BRB',
    'BY': 'BLR',
    'BE': 'BEL',
    'BZ': 'BLZ',
    'BJ': 'BEN',
    'BM': 'BMU',
    'BT': 'BTN',
    'BO': 'BOL',
    'BA': 'BIH',
    'BW': 'BWA',
    'BR': 'BRA',
    'VG': 'VGB',
    'BN': 'BRN',
    'BG': 'BGR',
    'BF': 'BFA',
    'BI': 'BDI',
    'KH': 'KHM',
    'CM': 'CMR',
    'CA': 'CAN',
    'CV': 'CPV',
    'KY': 'CYM',
    'CF': 'CAF',
    'TD': 'TCD',
    'CL': 'CHL',
    'CN': 'CHN',
    'CX': 'CXR',
    'CC': 'CCK',
    'CO': 'COL',
    'KM': 'COM',
    'CG': 'COG',
    'CD': 'COD',
    'CK': 'COK',
    'CR': 'CRI',
    'CI': 'CIV',
    'HR': 'HRV',
    'CU': 'CUB',
    'CY': 'CYP',
    'CZ': 'CZE',
    'DK': 'DNK',
    'DJ': 'DJI',
    'DM': 'DMA',
    'DO': 'DOM',
    'EC': 'ECU',
    'EG': 'EGY',
    'SV': 'SLV',
    'GQ': 'GNQ',
    'ER': 'ERI',
    'EE': 'EST',
    'ET': 'ETH',
    'FK': 'FLK',
    'FO': 'FRO',
    'FJ': 'FJI',
    'FI': 'FIN',
    'FR': 'FRA',
    'GF': 'GUF',
    'PF': 'PYF',
    'TF': 'ATF',
    'GA': 'GAB',
    'GM': 'GMB',
    'GE': 'GEO',
    'DE': 'DEU',
    'GH': 'GHA',
    'GI': 'GIB',
    'GR': 'GRC',
    'GL': 'GRL',
    'GD': 'GRD',
    'GP': 'GLP',
    'GU': 'GUM',
    'GT': 'GTM',
    'GG': 'GGY',
    'GN': 'GIN',
    'GW': 'GNB',
    'GY': 'GUY',
    'HT': 'HTI',
    'HM': 'HMD',
    'VA': 'VAT',
    'HN': 'HND',
    'HK': 'HKG',
    'HU': 'HUN',
    'IS': 'ISL',
    'IN': 'IND',
    'ID': 'IDN',
    'IR': 'IRN',
    'IQ': 'IRQ',
    'IE': 'IRL',
    'IM': 'IMN',
    'IL': 'ISR',
    'IT': 'ITA',
    'JM': 'JAM',
    'JP': 'JPN',
    'JE': 'JEY',
    'JO': 'JOR',
    'KZ': 'KAZ',
    'KE': 'KEN',
    'KI': 'KIR',
    'KP': 'PRK',
    'KR': 'KOR',
    'KW': 'KWT',
    'KG': 'KGZ',
    'LA': 'LAO',
    'LV': 'LVA',
    'LB': 'LBN',
    'LS': 'LSO',
    'LR': 'LBR',
    'LY': 'LBY',
    'LI': 'LIE',
    'LT': 'LTU',
    'LU': 'LUX',
    'MO': 'MAC',
    'MK': 'MKD',
    'MG': 'MDG',
    'MW': 'MWI',
    'MY': 'MYS',
    'MV': 'MDV',
    'ML': 'MLI',
    'MT': 'MLT',
    'MH': 'MHL',
    'MQ': 'MTQ',
    'MR': 'MRT',
    'MU': 'MUS',
    'YT': 'MYT',
    'MX': 'MEX',
    'FM': 'FSM',
    'MD': 'MDA',
    'MC': 'MCO',
    'MN': 'MNG',
    'ME': 'MNE',
    'MS': 'MSR',
    'MA': 'MAR',
    'MZ': 'MOZ',
    'MM': 'MMR',
    'NA': 'NAM',
    'NR': 'NRU',
    'NP': 'NPL',
    'NL': 'NLD',
    'NC': 'NCL',
    'NZ': 'NZL',
    'NI': 'NIC',
    'NE': 'NER',
    'NG': 'NGA',
    'NU': 'NIU',
    'NF': 'NFK',
    'MP': 'MNP',
    'NO': 'NOR',
    'OM': 'OMN',
    'PK': 'PAK',
    'PW': 'PLW',
    'PS': 'PSE',
    'PA': 'PAN',
    'PG': 'PNG',
    'PY': 'PRY',
    'PE': 'PER',
    'PH': 'PHL',
    'PN': 'PCN',
    'PL': 'POL',
    'PT': 'PRT',
    'PR': 'PRI',
    'QA': 'QAT',
    'RE': 'REU',
    'RO': 'ROU',
    'RU': 'RUS',
    'RW': 'RWA',
    'BL': 'BLM',
    'SH': 'SHN',
    'KN': 'KNA',
    'LC': 'LCA',
    'MF': 'MAF',
    'PM': 'SPM',
    'VC': 'VCT',
    'WS': 'WSM',
    'SM': 'SMR',
    'ST': 'STP',
    'SA': 'SAU',
    'SN': 'SEN',
    'RS': 'SRB',
    'SC': 'SYC',
    'SL': 'SLE',
    'SG': 'SGP',
    'SX': 'SXM',
    'SK': 'SVK',
    'SI': 'SVN',
    'SB': 'SLB',
    'SO': 'SOM',
    'ZA': 'ZAF',
    'GS': 'SGS',
    'SS': 'SSD',
    'ES': 'ESP',
    'LK': 'LKA',
    'SD': 'SDN',
    'SR': 'SUR',
    'SJ': 'SJM',
    'SZ': 'SWZ',
    'SE': 'SWE',
    'CH': 'CHE',
    'SY': 'SYR',
    'TW': 'TWN',
    'TJ': 'TJK',
    'TZ': 'TZA',
    'TH': 'THA',
    'TL': 'TLS',
    'TG': 'TGO',
    'TK': 'TKL',
    'TO': 'TON',
    'TT': 'TTO',
    'TN': 'TUN',
    'TR': 'TUR',
    'TM': 'TKM',
    'TC': 'TCA',
    'TV': 'TUV',
    'UG': 'UGA',
    'UA': 'UKR',
    'AE': 'ARE',
    'GB': 'GBR',
    'US': 'USA',
    'UM': 'UMI',
    'UY': 'URY',
    'UZ': 'UZB',
    'VU': 'VUT',
    'VE': 'VEN',
    'VN': 'VNM',
    'VI': 'VIR',
    'WF': 'WLF',
    'EH': 'ESH',
    'YE': 'YEM',
    'ZM': 'ZMB',
    'ZW': 'ZWE'
  };

  return alpha3Map[alpha2Code] ?? 'UNK';
}

String _getNumericCode(String alpha2Code) {
  // Simplified mapping - you might want to use a proper ISO 3166-1 mapping
  final numericMap = {
    'AF': '004',
    'AL': '008',
    'DZ': '012',
    'AS': '016',
    'AD': '020',
    'AO': '024',
    'AI': '660',
    'AQ': '010',
    'AG': '028',
    'AR': '032',
    'AM': '051',
    'AW': '533',
    'AU': '036',
    'AT': '040',
    'AZ': '031',
    'BS': '044',
    'BH': '048',
    'BD': '050',
    'BB': '052',
    'BY': '112',
    'BE': '056',
    'BZ': '084',
    'BJ': '204',
    'BM': '060',
    'BT': '064',
    'BO': '068',
    'BA': '070',
    'BW': '072',
    'BR': '076',
    'VG': '092',
    'BN': '096',
    'BG': '100',
    'BF': '854',
    'BI': '108',
    'KH': '116',
    'CM': '120',
    'CA': '124',
    'CV': '132',
    'KY': '136',
    'CF': '140',
    'TD': '148',
    'CL': '152',
    'CN': '156',
    'CX': '162',
    'CC': '166',
    'CO': '170',
    'KM': '174',
    'CG': '178',
    'CD': '180',
    'CK': '184',
    'CR': '188',
    'CI': '384',
    'HR': '191',
    'CU': '192',
    'CY': '196',
    'CZ': '203',
    'DK': '208',
    'DJ': '262',
    'DM': '212',
    'DO': '214',
    'EC': '218',
    'EG': '818',
    'SV': '222',
    'GQ': '226',
    'ER': '232',
    'EE': '233',
    'ET': '231',
    'FK': '238',
    'FO': '234',
    'FJ': '242',
    'FI': '246',
    'FR': '250',
    'GF': '254',
    'PF': '258',
    'TF': '260',
    'GA': '266',
    'GM': '270',
    'GE': '268',
    'DE': '276',
    'GH': '288',
    'GI': '292',
    'GR': '300',
    'GL': '304',
    'GD': '308',
    'GP': '312',
    'GU': '316',
    'GT': '320',
    'GG': '831',
    'GN': '324',
    'GW': '624',
    'GY': '328',
    'HT': '332',
    'HM': '334',
    'VA': '336',
    'HN': '340',
    'HK': '344',
    'HU': '348',
    'IS': '352',
    'IN': '356',
    'ID': '360',
    'IR': '364',
    'IQ': '368',
    'IE': '372',
    'IM': '833',
    'IL': '376',
    'IT': '380',
    'JM': '388',
    'JP': '392',
    'JE': '832',
    'JO': '400',
    'KZ': '398',
    'KE': '404',
    'KI': '296',
    'KP': '408',
    'KR': '410',
    'KW': '414',
    'KG': '417',
    'LA': '418',
    'LV': '428',
    'LB': '422',
    'LS': '426',
    'LR': '430',
    'LY': '434',
    'LI': '438',
    'LT': '440',
    'LU': '442',
    'MO': '446',
    'MK': '807',
    'MG': '450',
    'MW': '454',
    'MY': '458',
    'MV': '462',
    'ML': '466',
    'MT': '470',
    'MH': '584',
    'MQ': '474',
    'MR': '478',
    'MU': '480',
    'YT': '175',
    'MX': '484',
    'FM': '583',
    'MD': '498',
    'MC': '492',
    'MN': '496',
    'ME': '499',
    'MS': '500',
    'MA': '504',
    'MZ': '508',
    'MM': '104',
    'NA': '516',
    'NR': '520',
    'NP': '524',
    'NL': '528',
    'NC': '540',
    'NZ': '554',
    'NI': '558',
    'NE': '562',
    'NG': '566',
    'NU': '570',
    'NF': '574',
    'MP': '580',
    'NO': '578',
    'OM': '512',
    'PK': '586',
    'PW': '585',
    'PS': '275',
    'PA': '591',
    'PG': '598',
    'PY': '600',
    'PE': '604',
    'PH': '608',
    'PN': '612',
    'PL': '616',
    'PT': '620',
    'PR': '630',
    'QA': '634',
    'RE': '638',
    'RO': '642',
    'RU': '643',
    'RW': '646',
    'BL': '652',
    'SH': '654',
    'KN': '659',
    'LC': '662',
    'MF': '663',
    'PM': '666',
    'VC': '670',
    'WS': '882',
    'SM': '674',
    'ST': '678',
    'SA': '682',
    'SN': '686',
    'RS': '688',
    'SC': '690',
    'SL': '694',
    'SG': '702',
    'SX': '534',
    'SK': '703',
    'SI': '705',
    'SB': '090',
    'SO': '706',
    'ZA': '710',
    'GS': '239',
    'SS': '728',
    'ES': '724',
    'LK': '144',
    'SD': '729',
    'SR': '740',
    'SJ': '744',
    'SZ': '748',
    'SE': '752',
    'CH': '756',
    'SY': '760',
    'TW': '158',
    'TJ': '762',
    'TZ': '834',
    'TH': '764',
    'TL': '626',
    'TG': '768',
    'TK': '772',
    'TO': '776',
    'TT': '780',
    'TN': '788',
    'TR': '792',
    'TM': '795',
    'TC': '796',
    'TV': '798',
    'UG': '800',
    'UA': '804',
    'AE': '784',
    'GB': '826',
    'US': '840',
    'UM': '581',
    'UY': '858',
    'UZ': '860',
    'VU': '548',
    'VE': '862',
    'VN': '704',
    'VI': '850',
    'WF': '876',
    'EH': '732',
    'YE': '887',
    'ZM': '894',
    'ZW': '716'
  };

  return numericMap[alpha2Code] ?? '000';
}
