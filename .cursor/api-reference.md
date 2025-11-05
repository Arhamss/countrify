# Countrify API Reference

## Complete API Documentation for Countrify Package

---

## Table of Contents

1. [Modal Pickers](#modal-pickers)
2. [Base Widgets](#base-widgets)
3. [Models](#models)
4. [Configuration](#configuration)
5. [Theme](#theme)
6. [Utilities](#utilities)
7. [Enums](#enums)

---

## Modal Pickers

### ModalCountryPicker

Entry point for basic country selection with three display modes.

#### Static Methods

##### `showBottomSheet()`

Shows country picker as a bottom sheet sliding from bottom.

```dart
static Future<Country?> showBottomSheet({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  String? title,
  EdgeInsets? padding,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? barrierColor,
})
```

**Parameters:**
- `context` (required): Build context
- `initialCountry`: Pre-selected country (optional)
- `theme`: Visual theme configuration (optional, defaults to defaultTheme)
- `config`: Behavior configuration (optional)
- `title`: Header title text (optional)
- `padding`: Bottom sheet padding (optional)
- `isDismissible`: Allow tap outside to close (default: true)
- `enableDrag`: Allow drag to close (default: true)
- `barrierColor`: Backdrop color (optional)

**Returns:** `Future<Country?>` - Selected country or null if cancelled

**Example:**
```dart
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  initialCountry: CountryUtils.getCountryByAlpha2Code('US'),
  theme: CountryPickerTheme.darkTheme(),
);
```

##### `showDialogPicker()`

Shows country picker as a centered dialog.

```dart
static Future<Country?> showDialogPicker({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  String? title,
  bool barrierDismissible = true,
  Color? barrierColor,
})
```

**Parameters:**
- `context` (required): Build context
- `initialCountry`: Pre-selected country (optional)
- `theme`: Visual theme configuration (optional)
- `config`: Behavior configuration (optional)
- `title`: Dialog title text (optional)
- `barrierDismissible`: Allow tap outside to close (default: true)
- `barrierColor`: Backdrop color (optional)

**Returns:** `Future<Country?>` - Selected country or null if cancelled

##### `showFullScreen()`

Shows country picker in full screen mode with app bar.

```dart
static Future<Country?> showFullScreen({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  String? title,
  bool showAppBar = true,
  AppBar? customAppBar,
})
```

**Parameters:**
- `context` (required): Build context
- `initialCountry`: Pre-selected country (optional)
- `theme`: Visual theme configuration (optional)
- `config`: Behavior configuration (optional)
- `title`: App bar title text (optional)
- `showAppBar`: Show app bar (default: true)
- `customAppBar`: Custom app bar widget (optional)

**Returns:** `Future<Country?>` - Selected country or null if cancelled

---

### ModalComprehensivePicker

Entry point for advanced country selection with phone codes and extended information.

#### Static Methods

##### `showBottomSheet()`

```dart
static Future<Country?> showBottomSheet({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  bool showPhoneCode = true,
  bool searchEnabled = true,
  String? searchHint,
  EdgeInsets? padding,
  bool isDismissible = true,
  bool enableDrag = true,
})
```

**Additional Parameters:**
- `showPhoneCode`: Display phone/calling codes (default: true)
- `searchEnabled`: Enable search functionality (default: true)
- `searchHint`: Search bar hint text (optional)

##### `showDialog()`

```dart
static Future<Country?> showDialog({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  bool showPhoneCode = true,
  bool searchEnabled = true,
  String? searchHint,
  bool barrierDismissible = true,
})
```

##### `showFullScreen()`

```dart
static Future<Country?> showFullScreen({
  required BuildContext context,
  Country? initialCountry,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
  bool showPhoneCode = true,
  bool searchEnabled = true,
  String? searchHint,
  String? title,
})
```

---

## Base Widgets

### CountryPicker

Basic country picker widget that can be embedded anywhere.

```dart
class CountryPicker extends StatefulWidget {
  const CountryPicker({
    Key? key,
    this.onCountrySelected,
    this.initialCountry,
    this.theme,
    this.config,
    this.searchController,
    this.scrollController,
  });

  final ValueChanged<Country>? onCountrySelected;
  final Country? initialCountry;
  final CountryPickerTheme? theme;
  final CountryPickerConfig? config;
  final TextEditingController? searchController;
  final ScrollController? scrollController;
}
```

**Usage:**
```dart
CountryPicker(
  onCountrySelected: (country) {
    print('Selected: ${country.name}');
  },
  initialCountry: CountryUtils.getCountryByAlpha2Code('US'),
  theme: CountryPickerTheme.defaultTheme(),
  config: const CountryPickerConfig(
    showDialCode: true,
    showCapital: true,
  ),
)
```

### ComprehensiveCountryPicker

Advanced country picker with extended features.

```dart
class ComprehensiveCountryPicker extends StatefulWidget {
  const ComprehensiveCountryPicker({
    Key? key,
    this.onCountrySelected,
    this.initialCountry,
    this.theme,
    this.config,
    this.showPhoneCode = true,
    this.searchEnabled = true,
    this.searchHint,
    this.onSearchChanged,
    this.onFilterChanged,
  });

  final ValueChanged<Country>? onCountrySelected;
  final Country? initialCountry;
  final CountryPickerTheme? theme;
  final CountryPickerConfig? config;
  final bool showPhoneCode;
  final bool searchEnabled;
  final String? searchHint;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<CountryFilter>? onFilterChanged;
}
```

### PhoneCodePicker

Specialized picker for phone/calling code selection.

```dart
class PhoneCodePicker extends StatefulWidget {
  const PhoneCodePicker({
    Key? key,
    this.onCountrySelected,
    this.initialCountry,
    this.theme,
    this.config,
    this.showCountryName = true,
    this.showFlag = true,
  });

  final ValueChanged<Country>? onCountrySelected;
  final Country? initialCountry;
  final CountryPickerTheme? theme;
  final CountryPickerConfig? config;
  final bool showCountryName;
  final bool showFlag;
}
```

---

## Models

### Country

Represents a country with comprehensive information.

```dart
class Country {
  const Country({
    required this.name,
    required this.nameTranslations,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.numericCode,
    required this.flagEmoji,
    required this.flagImagePath,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.area,
    required this.callingCodes,
    required this.topLevelDomains,
    required this.currencies,
    required this.languages,
    required this.timezones,
    required this.borders,
    required this.isIndependent,
    required this.isUnMember,
    this.largestCity,
  });

  final String name;
  final Map<String, String> nameTranslations;
  final String alpha2Code;
  final String alpha3Code;
  final String numericCode;
  final String flagEmoji;
  final String flagImagePath;
  final String capital;
  final String? largestCity;
  final String region;
  final String subregion;
  final int population;
  final double area;
  final List<String> callingCodes;
  final List<String> topLevelDomains;
  final List<Currency> currencies;
  final List<Language> languages;
  final List<String> timezones;
  final List<String> borders;
  final bool isIndependent;
  final bool isUnMember;

  Country copyWith({...});
  @override bool operator ==(Object other);
  @override int get hashCode;
  @override String toString();
}
```

**Example:**
```dart
final usa = CountryUtils.getCountryByAlpha2Code('US');
print(usa.name);           // "United States"
print(usa.capital);        // "Washington, D.C."
print(usa.population);     // 331002651
print(usa.callingCodes);   // ["+1"]
print(usa.currencies[0].code); // "USD"
```

### Currency

Represents a currency.

```dart
class Currency {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });

  final String code;    // ISO 4217 code (e.g., "USD")
  final String name;    // Full name (e.g., "United States dollar")
  final String symbol;  // Symbol (e.g., "$")

  @override bool operator ==(Object other);
  @override int get hashCode;
  @override String toString();
}
```

### Language

Represents a language.

```dart
class Language {
  const Language({
    required this.iso6391,
    required this.iso6392,
    required this.name,
    required this.nativeName,
  });

  final String iso6391;      // ISO 639-1 (2 letters, e.g., "en")
  final String iso6392;      // ISO 639-2 (3 letters, e.g., "eng")
  final String name;         // English name (e.g., "English")
  final String nativeName;   // Native name (e.g., "English")

  @override bool operator ==(Object other);
  @override int get hashCode;
  @override String toString();
}
```

---

## Configuration

### CountryPickerConfig

Controls the behavior and appearance options of the country picker.

```dart
class CountryPickerConfig {
  const CountryPickerConfig({
    // Display Options
    this.showDialCode = true,
    this.showCapital = false,
    this.showRegion = false,
    this.showPopulation = false,
    this.showFlag = true,
    this.showCountryName = true,
    
    // Dimensions
    this.itemHeight = 60.0,
    this.flagSize = const Size(32, 24),
    this.maxHeight,
    this.minHeight = 200.0,
    
    // Flag Styling
    this.flagShape = FlagShape.rectangular,
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.flagBorderColor,
    this.flagBorderWidth = 1.0,
    this.flagShadowColor,
    this.flagShadowBlur = 2.0,
    this.flagShadowOffset = const Offset(0, 1),
    
    // Features
    this.enableScrollbar = true,
    this.enableHapticFeedback = true,
    this.enableSearch = true,
    this.enableFilter = false,
    this.searchDebounceMs = 300,
    
    // Animation
    this.animationDuration = const Duration(milliseconds: 300),
    
    // Filtering
    this.includeRegions = const [],
    this.excludeRegions = const [],
    this.includeCountries = const [],
    this.excludeCountries = const [],
    this.includeIndependent = true,
    this.includeUnMembers = true,
    
    // Sorting
    this.sortBy = CountrySortBy.name,
    
    // Advanced Features
    this.allowMultipleSelection = false,
    this.showSelectedCount = false,
    this.enableCountryGrouping = false,
    this.groupBy = CountryGroupBy.region,
    this.showGroupHeaders = true,
    this.stickyHeaders = true,
    this.enablePullToRefresh = false,
    this.enableInfiniteScroll = false,
    this.itemsPerPage = 50,
    this.showLoadingIndicator = true,
    this.loadingIndicatorColor,
    
    // Custom Widgets
    this.emptyStateWidget,
    this.errorStateWidget,
    this.customCountryBuilder,
    this.customHeaderBuilder,
    this.customSearchBuilder,
    this.customFilterBuilder,
  });
}
```

**Methods:**
- `copyWith({...})`: Creates a copy with updated fields

**Example:**
```dart
const config = CountryPickerConfig(
  showDialCode: true,
  showCapital: true,
  showFlag: true,
  flagShape: FlagShape.circular,
  flagSize: Size(40, 40),
  enableSearch: true,
  searchDebounceMs: 200,
  includeRegions: ['Europe', 'Asia'],
  sortBy: CountrySortBy.population,
  itemHeight: 70.0,
  enableHapticFeedback: true,
);
```

### CountryFilter

Represents filter criteria for country selection.

```dart
class CountryFilter {
  const CountryFilter({
    this.regions = const [],
    this.subregions = const [],
    this.sortBy = CountrySortBy.name,
    this.includeIndependent = true,
    this.includeUnMembers = true,
    this.minPopulation = 0,
    this.maxPopulation = double.infinity,
    this.minArea = 0,
    this.maxArea = double.infinity,
    this.searchQuery = '',
  });

  final List<String> regions;
  final List<String> subregions;
  final CountrySortBy sortBy;
  final bool includeIndependent;
  final bool includeUnMembers;
  final int minPopulation;
  final double maxPopulation;
  final double minArea;
  final double maxArea;
  final String searchQuery;

  CountryFilter copyWith({...});
}
```

---

## Theme

### CountryPickerTheme

Controls the visual appearance of the country picker.

```dart
class CountryPickerTheme {
  const CountryPickerTheme({
    // Colors
    this.backgroundColor,
    this.headerColor,
    this.headerIconColor,
    this.searchBarColor,
    this.searchIconColor,
    this.searchBarBorderColor,
    this.filterBackgroundColor,
    this.filterSelectedColor,
    this.filterTextColor,
    this.filterSelectedTextColor,
    this.filterCheckmarkColor,
    this.filterIconColor,
    this.countryItemBackgroundColor,
    this.countryItemSelectedColor,
    this.countryItemSelectedBorderColor,
    this.countryItemSelectedIconColor,
    this.borderColor,
    this.shadowColor,
    
    // Text Styles
    this.headerTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.filterTextStyle,
    this.countryNameTextStyle,
    this.countrySubtitleTextStyle,
    
    // Border Radius
    this.searchBarBorderRadius,
    this.countryItemBorderRadius,
    this.borderRadius,
    this.scrollbarRadius,
    
    // Dimensions
    this.scrollbarThickness,
    this.elevation,
    
    // Animation
    this.animationDuration,
    
    // Features
    this.hapticFeedback,
  });
}
```

**Static Factory Methods:**

##### `defaultTheme()`
Returns the default light theme.

```dart
static CountryPickerTheme defaultTheme()
```

##### `darkTheme()`
Returns a dark theme optimized for dark mode apps.

```dart
static CountryPickerTheme darkTheme()
```

##### `material3Theme()`
Returns a Material Design 3 compliant theme.

```dart
static CountryPickerTheme material3Theme()
```

##### `custom()`
Creates a custom theme with specified colors.

```dart
static CountryPickerTheme custom({
  Color? primaryColor,
  Color? backgroundColor,
  Color? surfaceColor,
  Color? onSurfaceColor,
  Color? onBackgroundColor,
  bool isDark = false,
})
```

**Example:**
```dart
final customTheme = CountryPickerTheme.custom(
  primaryColor: Colors.purple,
  backgroundColor: Colors.white,
  isDark: false,
);

// Or use predefined
final theme = CountryPickerTheme.darkTheme();
```

---

## Utilities

### CountryUtils

Static utility class with helper methods for country operations.

#### Data Access Methods

##### `getAllCountries()`
```dart
static List<Country> getAllCountries()
```
Returns all countries (245+).

##### `getCountryByAlpha2Code()`
```dart
static Country? getCountryByAlpha2Code(String alpha2Code)
```
Get country by 2-letter code (e.g., "US").

##### `getCountryByAlpha3Code()`
```dart
static Country? getCountryByAlpha3Code(String alpha3Code)
```
Get country by 3-letter code (e.g., "USA").

##### `getCountryByNumericCode()`
```dart
static Country? getCountryByNumericCode(String numericCode)
```
Get country by numeric code (e.g., "840").

#### Search & Filter Methods

##### `searchCountries()`
```dart
static List<Country> searchCountries(String query)
```
Search countries by name (case-insensitive).

##### `getCountriesByRegion()`
```dart
static List<Country> getCountriesByRegion(String region)
```
Get all countries in a specific region (e.g., "Europe", "Asia").

##### `getCountriesBySubregion()`
```dart
static List<Country> getCountriesBySubregion(String subregion)
```
Get all countries in a specific subregion (e.g., "Western Europe").

##### `getCountriesByCallingCode()`
```dart
static List<Country> getCountriesByCallingCode(String callingCode)
```
Get countries with a specific calling code (e.g., "+1").

##### `getCountriesByCurrencyCode()`
```dart
static List<Country> getCountriesByCurrencyCode(String currencyCode)
```
Get countries using a specific currency (e.g., "EUR").

##### `getCountriesByLanguageCode()`
```dart
static List<Country> getCountriesByLanguageCode(String languageCode)
```
Get countries where a language is spoken (e.g., "en").

##### `getCountriesByTimezone()`
```dart
static List<Country> getCountriesByTimezone(String timezone)
```
Get countries in a specific timezone (e.g., "UTC+01:00").

##### `getBorderCountries()`
```dart
static List<Country> getBorderCountries(String alpha3Code)
```
Get all countries that border a specific country.

##### `getCountriesByMinPopulation()`
```dart
static List<Country> getCountriesByMinPopulation(int minPopulation)
```
Get countries with population >= specified value.

##### `getCountriesByMinArea()`
```dart
static List<Country> getCountriesByMinArea(double minArea)
```
Get countries with area >= specified value (km²).

##### `getIndependentCountries()`
```dart
static List<Country> getIndependentCountries()
```
Get only independent countries.

##### `getUnMemberCountries()`
```dart
static List<Country> getUnMemberCountries()
```
Get only UN member countries.

#### Sorting Methods

##### `getCountriesSortedByPopulation()`
```dart
static List<Country> getCountriesSortedByPopulation()
```
Returns countries sorted by population (descending).

##### `getCountriesSortedByArea()`
```dart
static List<Country> getCountriesSortedByArea()
```
Returns countries sorted by area (descending).

##### `getCountriesSortedByName()`
```dart
static List<Country> getCountriesSortedByName()
```
Returns countries sorted alphabetically by name.

#### Statistics Methods

##### `getMostPopulousCountry()`
```dart
static Country? getMostPopulousCountry()
```
Returns the country with the largest population.

##### `getLargestCountry()`
```dart
static Country? getLargestCountry()
```
Returns the country with the largest area.

##### `getSmallestCountry()`
```dart
static Country? getSmallestCountry()
```
Returns the country with the smallest area.

##### `getTotalWorldPopulation()`
```dart
static int getTotalWorldPopulation()
```
Returns sum of all countries' populations.

##### `getTotalWorldArea()`
```dart
static double getTotalWorldArea()
```
Returns sum of all countries' areas (km²).

##### `getAveragePopulation()`
```dart
static double getAveragePopulation()
```
Returns average population per country.

##### `getAverageArea()`
```dart
static double getAverageArea()
```
Returns average area per country (km²).

##### `getCountriesCountByRegion()`
```dart
static Map<String, int> getCountriesCountByRegion()
```
Returns map of region names to country counts.

##### `getCountriesCountBySubregion()`
```dart
static Map<String, int> getCountriesCountBySubregion()
```
Returns map of subregion names to country counts.

#### Collection Methods

##### `getAllRegions()`
```dart
static List<String> getAllRegions()
```
Returns list of all unique regions.

##### `getAllSubregions()`
```dart
static List<String> getAllSubregions()
```
Returns list of all unique subregions.

##### `getSubregionsByRegion()`
```dart
static List<String> getSubregionsByRegion(String region)
```
Returns subregions within a specific region.

##### `getAllCurrencies()`
```dart
static List<Currency> getAllCurrencies()
```
Returns list of all unique currencies.

##### `getAllLanguages()`
```dart
static List<Language> getAllLanguages()
```
Returns list of all unique languages.

##### `getAllTimezones()`
```dart
static List<String> getAllTimezones()
```
Returns list of all unique timezones.

##### `getAllCallingCodes()`
```dart
static List<String> getAllCallingCodes()
```
Returns list of all unique calling codes.

##### `getAllTopLevelDomains()`
```dart
static List<String> getAllTopLevelDomains()
```
Returns list of all unique top-level domains.

#### Validation Methods

##### `isValidAlpha2Code()`
```dart
static bool isValidAlpha2Code(String code)
```
Check if a 2-letter code is valid.

##### `isValidAlpha3Code()`
```dart
static bool isValidAlpha3Code(String code)
```
Check if a 3-letter code is valid.

##### `isValidNumericCode()`
```dart
static bool isValidNumericCode(String code)
```
Check if a numeric code is valid.

#### Formatting Methods

##### `formatPopulation()`
```dart
static String formatPopulation(int population)
```
Format population number with commas (e.g., "331,002,651").

##### `formatArea()`
```dart
static String formatArea(double area)
```
Format area number with commas (e.g., "9,833,520").

#### Accessor Methods

##### `getCountryFlagEmoji()`
```dart
static String getCountryFlagEmoji(String alpha2Code)
```
Get flag emoji for a country (e.g., "🇺🇸").

##### `getCountryFlagImagePath()`
```dart
static String getCountryFlagImagePath(String alpha2Code)
```
Get asset path for flag image.

##### `getCountryCallingCode()`
```dart
static String? getCountryCallingCode(String alpha2Code)
```
Get primary calling code for a country.

##### `getCountryCurrency()`
```dart
static Currency? getCountryCurrency(String alpha2Code)
```
Get primary currency for a country.

##### `getCountryPrimaryLanguage()`
```dart
static Language? getCountryPrimaryLanguage(String alpha2Code)
```
Get primary language for a country.

##### `getCountryTimezone()`
```dart
static String? getCountryTimezone(String alpha2Code)
```
Get primary timezone for a country.

##### `getCountryCapital()`
```dart
static String? getCountryCapital(String alpha2Code)
```
Get capital city of a country.

##### `getCountryRegion()`
```dart
static String? getCountryRegion(String alpha2Code)
```
Get region of a country.

##### `getCountrySubregion()`
```dart
static String? getCountrySubregion(String alpha2Code)
```
Get subregion of a country.

##### `getCountryPopulation()`
```dart
static int? getCountryPopulation(String alpha2Code)
```
Get population of a country.

##### `getCountryArea()`
```dart
static double? getCountryArea(String alpha2Code)
```
Get area of a country (km²).

##### `isCountryIndependent()`
```dart
static bool isCountryIndependent(String alpha2Code)
```
Check if a country is independent.

##### `isCountryUnMember()`
```dart
static bool isCountryUnMember(String alpha2Code)
```
Check if a country is a UN member.

##### `getCountryNameInLanguage()`
```dart
static String getCountryNameInLanguage(Country country, String languageCode)
```
Get translated country name in specific language.

##### `getCountryNamesInAllLanguages()`
```dart
static Map<String, String> getCountryNamesInAllLanguages(Country country)
```
Get all available translations of a country name.

---

## Enums

### FlagShape

```dart
enum FlagShape {
  rectangular,  // Standard rectangular flags
  circular,     // Circular flags
  rounded,      // Rounded corner flags
}
```

### CountrySortBy

```dart
enum CountrySortBy {
  name,        // Alphabetical by name
  population,  // By population (desc)
  area,        // By area (desc)
  region,      // By region name
  capital,     // Alphabetical by capital
}
```

### CountryGroupBy

```dart
enum CountryGroupBy {
  region,       // Group by region
  subregion,    // Group by subregion
  firstLetter,  // Group by first letter of name
  population,   // Group by population ranges
}
```

---

## Complete Usage Example

```dart
import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';

Future<void> selectCountry(BuildContext context) async {
  // Configure theme
  final theme = CountryPickerTheme.custom(
    primaryColor: Colors.blue,
    isDark: false,
  );

  // Configure behavior
  const config = CountryPickerConfig(
    showDialCode: true,
    showCapital: true,
    showFlag: true,
    flagShape: FlagShape.circular,
    enableSearch: true,
    includeRegions: ['Europe', 'Asia'],
    sortBy: CountrySortBy.name,
  );

  // Show picker
  final country = await ModalComprehensivePicker.showBottomSheet(
    context: context,
    theme: theme,
    config: config,
    showPhoneCode: true,
    searchEnabled: true,
  );

  if (country != null) {
    // Use selected country
    print('Name: ${country.name}');
    print('Code: ${country.alpha2Code}');
    print('Phone: ${country.callingCodes.join(", ")}');
    print('Capital: ${country.capital}');
    print('Population: ${CountryUtils.formatPopulation(country.population)}');
  }
}
```

---

## Error Handling

All methods that return `Country?` will return `null` if:
- Country code is invalid
- Country not found
- No matches for search criteria

Always check for null before using returned values:

```dart
final country = CountryUtils.getCountryByAlpha2Code('XX');
if (country != null) {
  print(country.name);
} else {
  print('Country not found');
}
```

---

## Performance Tips

1. **Cache Results**: Store frequently accessed data
2. **Use Appropriate Methods**: Use specific lookups (e.g., `getCountryByAlpha2Code`) instead of searching all
3. **Limit Config Options**: Enable only needed features
4. **Reuse Controllers**: Reuse `TextEditingController` and `ScrollController`
5. **Optimize Filters**: Use `includeCountries` for small lists instead of excluding

---

## Type Safety

All classes and methods are fully type-safe with:
- No dynamic types
- Null-safety compliance
- Const constructors where possible
- Immutable data structures
- Proper equality implementations

---

