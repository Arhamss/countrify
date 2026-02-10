## 1.1.0

### New: Country Name Localization (132 languages)

- Added built-in country name translations for **132 languages** sourced from [CLDR](https://github.com/umpirsky/country-list) data
- New `CountryNameL10n` class with compile-time constant translation maps — zero runtime dependencies
- New `CountryUtils.getCountryNameInLanguage()` — get any country's name in any of 132 languages
- New `CountryUtils.getCountryNamesInAllLanguages()` — get all translations for a country
- New `CountryUtils.getSupportedLocales()` — list all 132 supported locale codes
- Added `tool/generate_translations.dart` to regenerate translation data from upstream CLDR source
- Added localization tests (10 `CountryNameL10n` tests + 4 `CountryUtils` l10n tests)

### New: Automatic Locale-Aware Widgets

- All picker widgets **auto-detect** the app locale from `Localizations.localeOf(context)` — just set your `MaterialApp` locale and every picker shows localized names automatically
- Optional `locale` parameter on `CountryPickerConfig` to explicitly override (e.g. `locale: 'de'`)
- Pass `locale: 'en'` to force English regardless of app locale
- Search across all pickers matches both localized and English names
- Sorting respects the active locale
- Fully backward-compatible — English apps with no locale set continue to work identically

### New: Fully Customizable Widget Strings

- All user-facing text strings in picker widgets are now configurable via `CountryPickerConfig`
- New string parameters: `titleText`, `searchHintText`, `emptyStateText`, `selectCountryHintText`, `filterTitleText`, `filterSortByText`, `filterRegionsText`, `filterAllText`, `filterCancelText`, `filterApplyText`
- The `CountryPicker` widget's config also adds `titleText` and `selectCountryHintText`
- Sensible English defaults — no changes needed for existing apps

### Bug Fixes

- Fixed incorrect ISO 3166-1 alpha-2 codes for Ireland (`ROI` → `IE`), North Macedonia (`MKD` → `MK`), and Palestine (`PNA` → `PS`)
- Fixed missing flag images and flag emojis for Ireland, North Macedonia, and Palestine
- Fixed incorrect region for Palestine (`Africa` → `Asia`)

### Housekeeping

- Updated package description to reflect localization support
- Updated README with full localization documentation and examples

## 1.0.5

- Fixed deprecated `RadioListTile.groupValue`/`onChanged` usage — migrated to `RadioGroup` widget
- Fixed all deprecated `withOpacity` calls — migrated to `withValues(alpha:)`
- Fixed Shahab Arif's contributor GitHub link
- Updated installation version in README

## 1.0.4

- Host screenshots externally to reduce package size (~2 MB → ~1 MB)
- Updated README to use externally hosted screenshot URLs

## 1.0.3

- Added new contributors: Muhammad Anas Akhtar, Muhammad Shoaib Irfan, Shahab Arif

## 1.0.2

- Fixed README screenshots not rendering on pub.dev (use absolute GitHub URLs)

## 1.0.1

- Added contributors section to documentation
- Updated Codeable branding and package metadata

## 1.0.0

Initial release of Countrify.

### Features

- **245+ countries** with comprehensive data (ISO 3166-1 alpha-2, alpha-3, numeric codes)
- **5 display modes**: Bottom Sheet, Dialog, Full Screen, Dropdown, and Inline
- **4 built-in themes**: Default (light), Dark, Material 3, and Custom color builder
- **Widgets**: `ModalComprehensivePicker`, `ModalCountryPicker`, `CountryDropdownField`, `PhoneCodePicker`, `ComprehensiveCountryPicker`
- **Real-time search** with configurable debounce across name, code, capital, region, and phone code
- **Advanced filtering** by region, subregion, independence status, and UN membership
- **Custom sorting** by name, population, area, region, or capital
- **Flag customization**: rectangular, circular, and rounded shapes with border and shadow options
- **Custom builders** for country items, headers, search bars, and filters
- **40+ utility methods** via `CountryUtils` for programmatic data access, search, statistics, and validation
- **Rich country model** with 15+ fields including capitals, currencies, languages, timezones, borders, population, and area
- **Haptic feedback** on country selection
- **Smooth animations** with configurable duration
- **Full theming** via `CountryPickerTheme` with `copyWith` support
- **Zero runtime dependencies** — only depends on Flutter SDK
- **Full null safety**
- **Cross-platform** support: iOS, Android, Web, macOS, Windows, Linux
