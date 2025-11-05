# Countrify 🌍

A beautiful and highly customizable country picker package for Flutter with comprehensive country data, ISO 3166-1 codes, and flag images.

[![pub package](https://img.shields.io/pub/v/countrify.svg)](https://pub.dev/packages/countrify)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features ✨

- 🌍 **Comprehensive Country Data**: All countries with ISO 3166-1 alpha-2, alpha-3, and numeric codes
- 🎨 **Beautiful UI**: Modern, customizable country picker widgets
- 🏳️ **Flag Images**: High-quality flag images for all countries
- 🔍 **Advanced Search**: Search by name, code, capital, region, and more
- 🎛️ **Highly Customizable**: Complete control over appearance and behavior
- 📱 **Multiple Display Modes**: Bottom sheet, dialog, and full-screen options
- 🛠️ **Utility Functions**: Easy access to country data and statistics
- 🌐 **Internationalization**: Support for multiple languages
- ⚡ **Performance**: Optimized for smooth scrolling and fast search
- 🎯 **Type Safe**: Full type safety with comprehensive models

## Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  countrify: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start 🚀

### Basic Usage

```dart
import 'package:countrify/countrify.dart';

// Show country picker as bottom sheet
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  title: 'Select Country',
);

if (country != null) {
  print('Selected: ${country.name} (${country.alpha2Code})');
}
```

### Show as Dialog

```dart
final country = await ModalCountryPicker.showDialog(
  context: context,
  title: 'Choose Country',
);
```

### Show as Full Screen

```dart
final country = await ModalCountryPicker.showFullScreen(
  context: context,
  title: 'Select Your Country',
);
```

## Advanced Usage 🎛️

### Customized Appearance

```dart
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  title: 'Customized Picker',
  theme: const CountryPickerTheme(
    backgroundColor: Colors.grey,
    searchBarColor: Colors.white,
    searchBarBorderColor: Colors.blue,
    countryItemBackgroundColor: Colors.white,
    countryItemSelectedColor: Colors.blue,
    flagSize: Size(40, 30),
  ),
  config: const CountryPickerConfig(
    showDialCode: true,
    showCapital: true,
    showRegion: true,
    showPopulation: true,
    itemHeight: 80.0,
  ),
);
```

### Filtered Countries

```dart
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  title: 'European Countries',
  config: const CountryPickerConfig(
    includeRegions: ['Europe'],
    showDialCode: true,
    showCapital: true,
  ),
);
```

### Custom Country List

```dart
final customCountries = [
  CountryUtils.getCountryByAlpha2Code('US'),
  CountryUtils.getCountryByAlpha2Code('CA'),
  CountryUtils.getCountryByAlpha2Code('GB'),
].where((country) => country != null).cast<Country>().toList();

final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  config: CountryPickerConfig(
    customCountries: customCountries,
  ),
);
```

## Country Data Access 🗺️

### Get All Countries

```dart
final allCountries = CountryUtils.getAllCountries();
print('Total countries: ${allCountries.length}');
```

### Search Countries

```dart
final results = CountryUtils.searchCountries('united');
// Returns countries with 'united' in their name
```

### Get Countries by Region

```dart
final europeanCountries = CountryUtils.getCountriesByRegion('Europe');
final asianCountries = CountryUtils.getCountriesByRegion('Asia');
```

### Get Country by Code

```dart
final usa = CountryUtils.getCountryByAlpha2Code('US');
final canada = CountryUtils.getCountryByAlpha3Code('CAN');
final germany = CountryUtils.getCountryByNumericCode('276');
```

### Get Country Information

```dart
final country = CountryUtils.getCountryByAlpha2Code('US');
if (country != null) {
  print('Name: ${country.name}');
  print('Capital: ${country.capital}');
  print('Population: ${CountryUtils.formatPopulation(country.population)}');
  print('Area: ${CountryUtils.formatArea(country.area)} km²');
  print('Currency: ${country.currencies.first.symbol}');
  print('Languages: ${country.languages.map((l) => l.name).join(', ')}');
}
```

### Statistics

```dart
print('Total world population: ${CountryUtils.formatPopulation(CountryUtils.getTotalWorldPopulation())}');
print('Total world area: ${CountryUtils.formatArea(CountryUtils.getTotalWorldArea())} km²');
print('Most populous country: ${CountryUtils.getMostPopulousCountry()?.name}');
print('Largest country: ${CountryUtils.getLargestCountry()?.name}');
print('Smallest country: ${CountryUtils.getSmallestCountry()?.name}');
```

## Configuration Options ⚙️

### CountryPickerConfig

```dart
const config = CountryPickerConfig(
  // Display options
  showSearchBar: true,
  showCountryCode: true,
  showFlag: true,
  showDialCode: false,
  showCapital: false,
  showRegion: false,
  showSubregion: false,
  showPopulation: false,
  showArea: false,
  showCurrencies: false,
  showLanguages: false,
  showTimezones: false,
  showBorders: false,
  showIndependenceStatus: false,
  showUnMemberStatus: false,
  
  // Search and filtering
  searchHint: 'Search countries...',
  emptyStateMessage: 'No countries found',
  groupByRegion: false,
  groupBySubregion: false,
  
  // Sorting
  sortByName: true,
  sortByPopulation: false,
  sortByArea: false,
  
  // Filters
  filterIndependentOnly: false,
  filterUnMembersOnly: false,
  excludeRegions: [],
  excludeSubregions: [],
  includeRegions: [],
  includeSubregions: [],
  
  // Customization
  customCountries: [],
  maxHeight: null,
  itemHeight: 60.0,
  searchDebounceMs: 300,
  enableScrollbar: true,
  enableDivider: true,
  enableRipple: true,
  enableHapticFeedback: true,
);
```

### CountryPickerTheme

```dart
const theme = CountryPickerTheme(
  // Colors
  backgroundColor: Colors.white,
  searchBarColor: Colors.grey[100],
  searchBarBorderColor: Colors.grey[300],
  countryItemBackgroundColor: Colors.transparent,
  countryItemSelectedColor: Colors.blue[50],
  dividerColor: Colors.grey[200],
  emptyStateIconColor: Colors.grey[400],
  loadingIndicatorColor: Colors.blue,
  scrollbarColor: Colors.grey[400],
  
  // Sizes
  flagSize: Size(32, 24),
  itemHeight: 60.0,
  dividerHeight: 1.0,
  scrollbarThickness: 6.0,
  
  // Border radius
  searchBarBorderRadius: BorderRadius.circular(12),
  countryItemBorderRadius: BorderRadius.circular(8),
  flagBorderRadius: BorderRadius.circular(4),
  scrollbarRadius: BorderRadius.circular(3),
  
  // Padding
  searchBarPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  countryItemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  
  // Text styles
  searchBarTextStyle: TextStyle(fontSize: 16),
  searchBarHintStyle: TextStyle(color: Colors.grey[600]),
  countryNameStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  countryCodeStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
  emptyStateTextStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
  
  // Icons
  searchBarIconColor: Colors.grey[600],
);
```

## Country Model 📋

The `Country` model includes comprehensive information:

```dart
class Country {
  final String name;                    // Country name
  final Map<String, String> nameTranslations; // Translations
  final String alpha2Code;              // ISO 3166-1 alpha-2 (e.g., "US")
  final String alpha3Code;              // ISO 3166-1 alpha-3 (e.g., "USA")
  final String numericCode;             // ISO 3166-1 numeric (e.g., "840")
  final String flagEmoji;               // Unicode flag emoji
  final String flagImagePath;           // Path to flag image asset
  final String capital;                 // Capital city
  final String region;                  // Geographic region
  final String subregion;               // Geographic subregion
  final int population;                 // Population count
  final double area;                    // Area in square kilometers
  final List<String> callingCodes;      // International calling codes
  final List<String> topLevelDomains;   // Top-level domains
  final List<Currency> currencies;      // Currencies used
  final List<Language> languages;       // Languages spoken
  final List<String> timezones;         // Time zones
  final List<String> borders;           // Border countries (alpha-3 codes)
  final bool isIndependent;             // Independence status
  final bool isUnMember;                // UN membership status
}
```

## Examples 📱

Check out the [example](example/) directory for a complete working example that demonstrates:

- Basic country picker usage
- Customized appearance
- Filtered country lists
- Country data access
- Statistics and utilities

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support 💬

If you find this package helpful, please consider giving it a ⭐ on [pub.dev](https://pub.dev/packages/countrify)!

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/yourusername/countrify/issues).

---

Made with ❤️ for the Flutter community# countrify
