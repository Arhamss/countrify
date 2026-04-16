## 2.5.0

Name-based pre-fill for edit flows — populate fields from backend strings
without needing IDs.

### Added

- **`CitySearchField.initialCityName`** (`String?`) — pre-fills the text
  field with a city name without requiring a city ID. When both
  `initialCityId` and `initialCityName` are provided, the ID takes priority.
  Reactive via `didUpdateWidget` when no ID is set.
- **`StateDropdownField.initialStateName`** (`String?`) — pre-fills the
  field and attempts to match a loaded state by name (case-insensitive).
  When `initialStateId` is null and `initialStateName` is set, the field
  matches against loaded states after hydration. ID-based matching always
  takes priority. Reactive via `didUpdateWidget`.

### Edge cases handled

- **ID + name both provided** — ID match takes priority; name is only used
  as a fallback if no ID match is found.
- **Name doesn't match any loaded state/city** — field shows the pre-filled
  text (city) or placeholder (state), no crash or empty state.
- **`didUpdateWidget` reactivity** — both fields react to external name
  changes, but only when no ID is set and no selection has been made.
- **Empty or null name** — silently ignored, no pre-fill.

## 2.4.1

### Fixed

- **CitySearchField** — field text now shows just the city name after
  selection instead of "City, State". The state is still available via the
  `onChanged` callback's `CitySearchResult` record.
- **City search matching** — `GeoRepository.searchCities()` now uses
  `SearchNormalizer.foldAccents()` for accent-insensitive, whitespace-trimmed
  matching (e.g. "sao" matches "S\u00e3o Paulo", "lodz" matches "\u0141\u00f3d\u017a"),
  consistent with all other picker search.
- **StateDropdownField** — `initialStateId` is now reactive. When it changes
  via `didUpdateWidget`, the internal selection updates and `onChanged` fires
  without requiring a full `countryIso2` change.

## 2.4.0

Global city search with auto-state resolution, and focus box shadow support
across all field widgets.

### Added

- **`CitySearchField`** — new searchable text field that searches across all
  cities for a given country without pre-selecting a state. When a city is
  selected the parent state is resolved automatically. The field displays
  results as "City, State" (e.g. "San Francisco, California") and the
  `onChanged` callback provides both the `City` and its parent
  `CountryState` via a `CitySearchResult` record.
- **`GeoRepository.searchCities()`** — searches all cities across all states
  for a country. Loads state city files in batches of 10 (lazy + cached),
  filters by `contains`, sorts prefix matches first, and caps results at a
  configurable `limit` (default 20).
- **`GeoRepository.preloadCities()`** — pre-loads all city files for a
  country in the background so subsequent `searchCities` calls are instant.
  `CitySearchField` calls this automatically on init.
- **`focusedBoxShadow`** on `CountrifyFieldStyle` — `List<BoxShadow>?`
  property that applies a box shadow around the field when focused. Supported
  by `PhoneNumberField`, `CountryDropdownField`, `StateDropdownField`,
  `CityDropdownField`, and `CitySearchField`. Default is `null` (no shadow).

### Changed

- **Focus tracking** — `StateDropdownField`, `CityDropdownField`,
  `CountryDropdownField`, and `CitySearchField` now track focus state
  internally via `setState` to support the new `focusedBoxShadow` property.
  All field widgets wrap their outermost container in a `DecoratedBox` that
  applies the shadow when focused and an empty shadow list when unfocused,
  avoiding widget tree instability on focus change.

### Testing

- Added 8 unit tests for `GeoRepository.searchCities` (matching, empty
  query, country boundaries, prefix sorting, limit, case insensitivity).
- Added 5 widget tests for `CitySearchField` (placeholder, multi-state
  results, selection with "City, State" display, clear behavior, country
  isolation).
- Added Nevada cities to test fixture for cross-state search testing.

## 2.3.0

Searchable dropdown fields, external labels, improved default styling, and
bug fixes across all picker and field widgets.

### Added

- **Searchable state & city fields** — `StateDropdownField` and
  `CityDropdownField` now default to `searchable: true`, rendering as text
  inputs that filter results in a dropdown overlay as the user types. Set
  `searchable: false` to restore the tap-to-open picker behavior.
- **`GeoSearchOverlay<T>`** — generic animated dropdown overlay used by the
  searchable fields. Supports auto-flip (opens above when keyboard covers
  below), fade-in/out animation, and dismiss-on-tap-outside.
- **External labels** — `CountrifyFieldStyle` gains `externalLabel`,
  `externalLabelStyle`, and `externalLabelPadding` for rendering labels above
  the field (outside `InputDecoration`). All field widgets call the new
  `wrapWithExternalLabel()` helper. `CountryStateCityField` uses external
  labels by default.
- **`CountryListTile` customization** — new parameters: `borderRadius`,
  `contentPadding`, `selectedBorderColor`, `splashColor`, `highlightColor`,
  and `enableSplash` for full control over tile appearance and tap feedback.

### Changed

- **Down arrow icon** — redesigned `CountrifyDownArrowIcon` with a cleaner,
  proportional chevron path (`M6,9 L12,15 L18,9`) and 2px stroke. All
  dropdown fields now render the arrow at size 20 with proper right padding.
- **Suffix icon constraints** — added `suffixIconConstraints: BoxConstraints()`
  to all four factory styles (`defaultStyle`, `darkStyle`, `outlineStyle`,
  `filledStyle`) so the suffix area no longer inflates to Flutter's default
  48×48 minimum.
- **Search bar compactness** — reduced prefix icon padding from
  `EdgeInsets.all(12)` to `EdgeInsets.only(left: 12, right: 8)` and added
  `prefixIconConstraints: BoxConstraints()` across all search bars (country
  picker, geo picker, country search bar, phone code picker). Fields are now
  ~38px tall instead of ~48px.
- **Country dropdown prefix** — globe icon now has explicit `size: 20` with
  compact padding; flag reduced from 32×24 to 28×20.
- **Geo picker list rows** — tighter vertical gaps, refined typography with
  primary-color highlighting on selected items, and improved header styling.
- **`CountryListTile` styling** — selected state now uses rounded `Material`
  with subtle primary-tinted background and border instead of a flat
  `Container` with `highlightColor`.
- **`PhoneCodePicker` header** — removed the close (X) button that called
  `Navigator.pop` (broke inline usage). Simplified to a clean title-only header.
- **Example app** — complete redesign with indigo/teal palette, 6 tabs
  (Phone, Country, Address, Themes, i18n, Blocks), `SliverAppBar`,
  showcase cards, and interactive demos. Added `GestureDetector` for keyboard
  dismissal on tap outside.

### Fixed

- **`_dirty` assertion crash** — `StateDropdownField.didUpdateWidget` and
  `CityDropdownField.didUpdateWidget` were calling `setState` during the build
  phase, causing `'!_dirty': is not true` when cascading selections. Fixed by
  mutating fields directly and deferring `onChanged` callbacks via
  `addPostFrameCallback`.
- **Pubspec description** — shortened from 215 to 152 characters to pass the
  pub.dev 60–180 character check.

## 2.2.0

Full country → state → city support with standalone pickers, cascading form
widget, and a polished search experience. Purely additive — no existing
widget, model, utility, or export was modified or removed.

### Added — Data

- Bundled the dr5hn `countries-states-cities-database` revision current as
  of release time: **250 countries**, **5,296 states / provinces**, and
  **153,823 cities**.
- Split the upstream dataset into per-country and per-state JSON files
  (`assets/geo/states/{ISO2}.json`, `assets/geo/cities/{stateId}.json`) so
  only the records the user actually selects are decoded into memory. Total
  bundled size ~28 MB across ~5,500 tiny files.
- `tool/sync_geo_data.dart` — regenerates the split assets from upstream.
  Supports `--ref <tag>` and `--input <path>` for reproducible rebuilds.

### Added — Models

- `CountryState` — state / province / region with `id`, `name`,
  `countryIso2`, ISO 3166-2 subdivision code, `type`, lat/lng, and
  `iso3166Code` helper.
- `City` — city / populated place with `id`, `name`, `stateId`, lat/lng.
- Both are `@immutable`, implement value equality, and document the JSON
  schema used by the bundled assets.

### Added — Data layer

- `GeoRepository` — lazy loader backed by the bundled assets. Caches
  per-country states and per-state cities in memory, deduplicates concurrent
  loads, returns `const []` on missing assets, and accepts an injectable
  `AssetBundle` for tests. Exposed as a singleton via
  `GeoRepository.instance`.

### Added — Widgets

- `StatePicker` — standalone state / province picker with 4 display modes
  (`bottomSheet`, `dialog`, `fullScreen`, `dropdown`), sort orders
  (`StateSortBy.name` / `type` / `id`), and fully customizable row / header
  / search / empty-state builders.
- `CityPicker` — standalone city picker mirroring `StatePicker`'s surface
  (`CitySortBy.name` / `id`, `showCoordinates`, same custom-builder hooks).
- `StateDropdownField` — form-style trigger that opens `StatePicker`.
  Reactive to `countryIso2` changes (auto-clears selection + re-fetches).
- `CityDropdownField` — form-style trigger that opens `CityPicker`.
  Reactive to `stateId` changes.
- `CountryStateCityField` — composite cascading widget that stacks
  `CountryDropdownField` + `StateDropdownField` + `CityDropdownField` for a
  complete country → state → city form input.
- `CountryStateCitySelection` — immutable selection snapshot with
  `isComplete` getter and value equality.
- `GeoItemPicker<T>` — generic picker scaffold powering the state + city
  pickers. Publicly exported for custom adapters on top of the same modes,
  theming, and search pipeline.

### Added — Theming & configuration

- `GeoPickerTheme` — 35 visual properties shared by state + city pickers
  (backgrounds, header, search field, item rows, icons, borders, shadows,
  scrollbar, empty state). Includes `GeoPickerTheme.light()` and
  `GeoPickerTheme.dark()` presets.
- `GeoPickerConfig` — behavior + text knobs (title, search hint,
  empty-state text, debounce, haptics, min/max height, scrollbar, content
  padding, item extent, selected-icon toggle, initial search text,
  autofocus, accent-insensitive search flag).
- `StateSortBy` / `CitySortBy` enums.
- Typedefs: `StateItemBuilder`, `CityItemBuilder`, `StateMatcher`,
  `CityMatcher`, `GeoItemBuilder`, `GeoHeaderBuilder`, `GeoSearchBuilder`,
  `GeoEmptyStateBuilder`.

### Added — Search

- **Accent-insensitive search** (default on) — `sao paulo` matches `São
  Paulo`, `lodz` matches `Łódź`, etc. Toggle via
  `GeoPickerConfig.accentInsensitiveSearch`.
- **Live clear button** — the trailing ✕ appears/disappears instantly while
  typing, powered by a `ValueListenableBuilder` on the controller (filter
  stays debounced).
- `onSearchChanged(String query)` — fires with every debounced change on
  `StatePicker`, `CityPicker`, `StateDropdownField`, `CityDropdownField`,
  and `GeoItemPicker`.
- `onResultsChanged(List<T> results)` — fires whenever the filtered list
  changes (including initial load). Useful for rendering "N results"
  counters outside the picker.
- `customMatcher` — overridable matching function on all four state / city
  widgets. Receives a pre-normalized query so custom matchers focus purely
  on comparison logic.
- `GeoPickerConfig.initialSearchText` — pre-populates the search field on
  open.
- `GeoPickerConfig.autofocusSearch` — requests keyboard focus on mount
  (ideal for full-screen mode).
- `SearchNormalizer` — public utility exposing `.basic()` (trim +
  lower-case) and `.foldAccents()` for use in custom matchers and external
  logic.

### Testing

- Added test coverage for models, `GeoRepository`, `SearchNormalizer`,
  `GeoPickerTheme` / `GeoPickerConfig`, and every new widget
  (`StatePicker`, `CityPicker`, `StateDropdownField`, `CityDropdownField`,
  `CountryStateCityField`).

## 2.1.0

### Breaking Changes
- Removed legacy `CountryPicker` widget — use the new `CountryPicker` (formerly `ComprehensiveCountryPicker`)
- Removed `ModalCountryPicker` and `ModalComprehensivePicker` — use `CountryPickerMode` parameter on widgets instead
- Replaced `PickerOpenType` and `PickerDisplayType` with unified `CountryPickerMode` enum
- Renamed `onCountrySelected` to `onChanged` across all widgets
- Renamed `onPhoneNumberChanged` to `onChanged` on `PhoneNumberField`
- Renamed `pickerType` to `pickerMode` on all widgets

### Added
- `focusedFillColor` on `CountrifyFieldStyle` — separate fill color when field has focus
- `CountryFlag` widget — standalone, accessible flag display (public API)
- `CountryListTile` widget — reusable country row with selection support (public API)
- `CountrySearchBar` widget — debounced, theme-aware search field (public API)
- `CountryListView` widget — filtered country list with empty state (public API)
- `CountryEmptyState` widget — customizable empty state display (public API)
- `CountryPickerMode` — unified enum for all picker display modes
- `PhoneMetadata` — lightweight phone number length validation (zero dependencies)
- Auto-validation on `PhoneNumberField` when `PhoneMetadata` is available
- Hint text from example phone numbers
- Accessibility: `Semantics` labels on all flags, list items, and interactive elements
- Accessibility: `Tooltip` on all icon buttons
- Per-locale l10n files with lazy loading (was single 33K-line file)

### Fixed
- `Country.copyWith()` now includes `largestCity` parameter

### Internal
- Extracted shared widgets (flag, list tile, search bar, list view, empty state)
- Each widget in its own file/folder following clean architecture
- Widget tests for shared components
- Comprehensive example app with 5 demo tabs

## 2.0.0

### Breaking Changes

- Replaced field-level styling parameters in `CountryDropdownField` and
  `PhoneNumberField` with a unified `style` API:
  - Removed direct parameters such as `hintText`, `labelText`,
    `labelTextStyle`, `decoration`, `phoneTextStyle`, `dialCodeTextStyle`,
    `dividerColor`, `prefixPadding`, `fieldBorderRadius`, and
    `contentPadding`.
  - Use `style: CountrifyFieldStyle(...)` or
    `CountrifyFieldStyle.defaultStyle().copyWith(...)` instead.

### Added

- Added new public `CountrifyFieldStyle` export in `countrify.dart`.
- Added `CountrifyFieldStyle` to centralize:
  - `InputDecoration` properties
  - phone and dial-code text styling
  - cursor color, divider color, prefix padding, and border radius
- Added helper constructors for fast theming:
  - `defaultStyle()`
  - `darkStyle()`
  - `outlineStyle()`
  - `filledStyle()`

### Changed

- Refactored `CountryDropdownField` and `PhoneNumberField` internals to build
  decoration via `CountrifyFieldStyle.toInputDecoration()`.
- Updated README examples and API docs to use `style`.

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
