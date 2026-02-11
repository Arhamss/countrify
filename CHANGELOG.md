## 1.2.0

### Breaking Changes

- Removed `initialCountry` (`Country?`) from public picker/field APIs.
- Initial selection is now enum-based only via `initialCountryCode` (`CountryCode?`).

### Added

- Added `CountryCode` enum support across all picker entry points.
- Added disabled selection modes:
  - `CountryPickerType.none`
  - `PickerDisplayType.none`
  - `PickerOpenType.none`
- Added `labelTextStyle` support to:
  - `CountryDropdownField`
  - `PhoneNumberField`
- Expanded text-style theming in `CountryPickerTheme`:
  - `compactCountryNameTextStyle`
  - `compactDialCodeTextStyle`
  - `readOnlyHintTextStyle`
  - `flagEmojiTextStyle`
  - `appBarTitleTextStyle`
  - `dialogOptionTextStyle`
  - `dialogActionTextStyle`

### Changed

- Updated example app to use enum-based initial country (`initialCountryCode`).
- Updated README examples, enum reference, and theme-property docs to match current API.
- Refactored `CountryPickerConfig` to shared-only fields used across multiple widgets.
- Moved comprehensive-specific options from shared config to `ComprehensiveCountryPicker` / `ModalComprehensivePicker` parameters:
  - sorting/filter defaults, filter dialog labels, custom builders
  - list sizing/debounce/scrollbar options
  - advanced flag shape/size/shadow options
- `enableSearch` is now enforced consistently across picker variants, including phone picker overlays/modals.
- Wired shared `emptyStateText` into pickers that previously rendered blank empty lists.
- `InputDecoration` handling in `PhoneNumberField` and `CountryDropdownField` now merges with built-in defaults instead of replacing them, so country prefix/flag UI is preserved unless explicitly overridden.

## 1.1.1

- Added Buy Me a Coffee support link to README

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
