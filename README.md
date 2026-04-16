<div align="center">

# Countrify

### The Ultimate Flutter Country Picker Package

*Beautiful, Comprehensive, and Highly Customizable*

[![pub package](https://img.shields.io/pub/v/countrify.svg?style=for-the-badge&color=blue)](https://pub.dev/packages/countrify)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%3E%3D3.0.0-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)

**[GitHub](https://github.com/Arhamss/countrify)** | **[Example](https://github.com/Arhamss/countrify/tree/main/example)** | **[Codeable](https://gocodeable.com)**

<a href="https://buymeacoffee.com/abdullahzer" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="217" height="60"></a>

---

A comprehensive Flutter package for country selection with **250 countries**, **5,296 states / provinces**, **153,823 cities**, **132 language translations**, beautiful UI, extensive theming, and **zero runtime dependencies**.

</div>

---

## Table of Contents

- [Overview](#overview)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
- [Display Modes](#display-modes)
  - [Bottom Sheet](#1-bottom-sheet)
  - [Dialog](#2-dialog)
  - [Full Screen](#3-full-screen)
  - [Dropdown](#4-dropdown)
  - [Inline](#5-inline)
- [Widgets](#widgets)
  - [CountryPicker](#countrypicker)
  - [PhoneNumberField](#phonenumberfield)
  - [CountryDropdownField](#countrydropdownfield)
  - [PhoneCodePicker](#phonecodepicker)
  - [CountryStateCityField](#countrystatecityfield)
  - [StatePicker](#statepicker)
  - [CityPicker](#citypicker)
  - [StateDropdownField](#statedropdownfield)
  - [CityDropdownField](#citydropdownfield)
  - [CitySearchField](#citysearchfield)
  - [Shared Building Blocks](#shared-building-blocks)
- [Theming](#theming)
  - [Built-in Themes](#built-in-themes)
  - [Custom Themes](#custom-themes)
  - [Full Theme Properties](#full-theme-properties)
- [Configuration](#configuration)
  - [Display Options](#display-options)
  - [Flag Customization](#flag-customization)
  - [Filtering Countries](#filtering-countries)
  - [Sorting](#sorting)
  - [Sizing](#sizing)
  - [Custom Builders](#custom-builders)
  - [Customizable Strings](#customizable-strings)
- [Country Data & Utilities](#country-data--utilities)
- [Localization (132 Languages)](#localization-132-languages)
- [Country Model](#country-model)
- [Enums Reference](#enums-reference)
- [Real-World Examples](#real-world-examples)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

Countrify is the most feature-rich country picker for Flutter. It ships with **250 countries**, **132 language translations**, **5 display modes**, **4 built-in themes**, **40+ utility methods**, a dedicated **phone number input field**, and a rich country data model — all with **zero runtime dependencies**.

| Metric | Value |
|---|---|
| Countries | 250 |
| Language Translations | 132 (CLDR-based) |
| Flag Assets | 250 PNG images |
| Utility Methods | 40+ |
| Display Modes | 5 |
| Built-in Themes | 4 |
| Runtime Dependencies | 0 |
| Platforms | iOS, Android, Web, macOS, Windows, Linux |

### Key Features

- **High-Quality Flag Images** — PNG flag assets for every country, bundled in the package
- **5 Display Modes** — Bottom Sheet, Dialog, Full Screen, Dropdown, and Inline
- **4 Built-in Themes** — Default (light), Dark, Material 3, and Custom color builder
- **PhoneNumberField** — Complete phone number input widget with integrated country code picker
- **CountryDropdownField** — Form-friendly dropdown with `InputDecoration` support
- **Real-Time Search** — Debounced search across name, code, capital, region, and phone code
- **Advanced Filtering** — Filter by region, subregion, independence status, UN membership
- **Custom Sorting** — Sort by name, population, area, region, or capital
- **Flag Customization** — Rectangular, circular, or rounded shapes with borders and shadows
- **Custom Builders** — Provide your own widgets for country items, headers, search bars, and filters
- **Customizable Strings** — Shared UI text via `CountryPickerConfig`, plus comprehensive filter labels via widget parameters
- **132 Language Translations** — Auto-detects your app locale; all pickers display localized country names, search, and sorting out of the box. Zero runtime dependencies
- **Rich Country Data** — 15+ fields per country including capitals, currencies, languages, timezones, borders
- **40+ Utility Methods** — Programmatic access to country data, search, statistics, and validation
- **Haptic Feedback** — Tactile response on country selection
- **Smooth Animations** — Fade transitions with configurable duration
- **Full Null Safety** — Sound null safety throughout
- **Custom Icons** — Ships with its own icon font (CountrifyIcons) — no Material Icons dependency for picker UI
- **Shared Building Blocks** — `CountryFlag`, `CountryListTile`, `CountrySearchBar`, `CountryListView` available as standalone widgets
- **Phone Validation** — Lightweight `PhoneMetadata` with auto-validation on `PhoneNumberField`
- **Accessibility** — `Semantics` labels and `Tooltip` on all interactive elements
- **focusedFillColor** — Separate fill color when field has focus via `CountrifyFieldStyle`
- **focusedBoxShadow** — Box shadow when field has focus via `CountrifyFieldStyle`
- **CitySearchField** — Global city search with auto-state resolution — search all cities for a country without pre-selecting a state

---

## Screenshots

<table>
<tr>
<th>Bottom Sheet (Light)</th>
<th>Bottom Sheet (Dark)</th>
<th>Phone Number Field</th>
</tr>
<tr>
<td><img src="https://i.ibb.co/6RKj2JGT/bottom-sheet-light.png" width="250"/></td>
<td><img src="https://i.ibb.co/MDqynzJY/bottom-sheet-dark.png" width="250"/></td>
<td><img src="https://i.ibb.co/prZC7FQS/phone-number-field.png" width="250"/></td>
</tr>
<tr>
<th>Country Dropdown Field</th>
<th>Dropdown Picker</th>
</tr>
<tr>
<td><img src="https://i.ibb.co/6JNrBQMw/country-dropdown-field.png" width="250"/></td>
<td><img src="https://i.ibb.co/2YNwhQyZ/dropdown-picker.png" width="250"/></td>
</tr>
</table>

---

## Getting Started

### Installation

Add `countrify` to your `pubspec.yaml`:

```yaml
dependencies:
  countrify: ^2.1.0
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:countrify/countrify.dart';
```

### Quick Start

The simplest way to add a phone number input:

```dart
PhoneNumberField(
  initialCountryCode: CountryCode.us,
  onChanged: (phoneNumber, country) {
    print('Full number: +${country.callingCodes.first}$phoneNumber');
  },
)
```

---

## Display Modes

Countrify supports **five** display modes out of the box via the `CountryPickerMode` enum. Each mode is suited for different UI scenarios. Set the mode with the `pickerMode` parameter on any widget.

### 1. Bottom Sheet

A modal bottom sheet that slides up from the bottom of the screen. Best for mobile-first UIs.

```dart
PhoneNumberField(
  pickerMode: CountryPickerMode.bottomSheet,
  onChanged: (phoneNumber, country) { },
)

// Or with CountryDropdownField:
CountryDropdownField(
  pickerMode: CountryPickerMode.bottomSheet,
  onChanged: (country) { },
)
```

### 2. Dialog

A centered dialog popup. Best for tablet and desktop layouts.

```dart
CountryDropdownField(
  pickerMode: CountryPickerMode.dialog,
  onChanged: (country) { },
)
```

### 3. Full Screen

A full-screen page with an AppBar. Best for complex selection flows.

```dart
CountryDropdownField(
  pickerMode: CountryPickerMode.fullScreen,
  onChanged: (country) { },
)
```

### 4. Dropdown

A compact scrollable dropdown anchored below the field. Best for forms.

```dart
PhoneNumberField(
  pickerMode: CountryPickerMode.dropdown,
  onChanged: (phoneNumber, country) { },
)
```

### 5. Inline

Use `CountryPicker` directly in your layout for an inline embedded list. Best for dashboard or settings pages.

```dart
CountryPicker(
  onCountrySelected: (country) {
    setState(() => selectedCountry = country);
  },
  showPhoneCode: true,
  searchEnabled: true,
)
```

---

## Widgets

### `CountryPicker`

The **primary widget** for country selection. Embed it directly in your layout or use it as the foundation for custom picker UIs. Supports rich theming, filtering, sorting, and all display options.

```dart
CountryPicker(
  initialCountryCode: CountryCode.us,
  onCountrySelected: (country) {
    print('Selected: ${country.name}');
  },
  theme: CountryPickerTheme.darkTheme(),
  config: const CountryPickerConfig(),
  showPhoneCode: true,
  showFlag: true,
  showCountryName: true,
  showCapital: false,
  showRegion: false,
  showPopulation: false,
  searchEnabled: true,
  filterEnabled: false,
)
```

---

### `PhoneNumberField`

A **complete phone number input widget** with an integrated country code picker as a prefix. The prefix displays the selected country flag and dial code. Tapping it opens a compact dropdown (default), or optionally a bottom sheet, dialog, or full-screen picker.

```dart
PhoneNumberField(
  initialCountryCode: CountryCode.us,
  style: const CountrifyFieldStyle(
    hintText: 'Enter phone number',
    labelText: 'Phone',
  ),
  onChanged: (phoneNumber, country) {
    print('Full number: +${country.callingCodes.first}$phoneNumber');
  },
  onCountryChanged: (country) {
    print('Country changed to: ${country.name}');
  },
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(15),
  ],
  theme: CountryPickerTheme.defaultTheme(),
)
```

**Customized PhoneNumberField:**

```dart
PhoneNumberField(
  showDropdownIcon: true,
  flagSize: const Size(28, 20),
  dropdownMaxHeight: 300,
  pickerMode: CountryPickerMode.dropdown,  // dropdown, bottomSheet, dialog, fullScreen
  style: CountrifyFieldStyle.defaultStyle().copyWith(
    hintText: 'Phone number',
    focusedFillColor: Colors.blue.shade50,
    fieldBorderRadius: BorderRadius.circular(16),
    dialCodeTextStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    ),
  ),
  maxLength: 12,
  validator: (value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    return null;
  },
  onChanged: (phoneNumber, country) { },
)
```

**Key Properties:**
| Property | Type | Default | Description |
|---|---|---|---|
| `initialCountryCode` | `CountryCode?` | First country with calling code | Pre-selected country code |
| `controller` | `TextEditingController?` | Internal | Phone text controller |
| `onChanged` | `Function(String, Country)?` | — | Called on text or country change |
| `onCountryChanged` | `ValueChanged<Country>?` | — | Called when country changes |
| `style` | `CountrifyFieldStyle?` | `null` | Unified style for decoration, text styles, cursor, divider, and prefix spacing |
| `showFlag` | `bool` | `true` | Show flag in prefix |
| `showDialCode` | `bool` | `true` | Show dial code in prefix |
| `showDropdownIcon` | `bool` | `true` | Show dropdown arrow |
| `pickerMode` | `CountryPickerMode` | `.dropdown` | How the picker opens (`.none` disables selection) |
| `dropdownMaxHeight` | `double` | `350` | Max height of dropdown overlay |
| `flagSize` | `Size` | `Size(24, 18)` | Flag dimensions |
| `validator` | `String? Function(String?)?` | — | Form validation |
| `inputFormatters` | `List<TextInputFormatter>?` | — | Input formatters |
| `maxLength` | `int?` | — | Max phone digits |

`style.toInputDecoration(...)` preserves built-in country prefix UI by default and only overrides it when you explicitly set `prefixIcon`/`suffixIcon`.

---

### `CountryDropdownField`

A form-friendly widget that looks and behaves like a `TextFormField`. Tapping it opens a country picker. Ideal for registration forms and settings pages.

```dart
CountryDropdownField(
  initialCountryCode: CountryCode.us,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  style: CountrifyFieldStyle.defaultStyle().copyWith(
    hintText: 'Select a country',
  ),
  showPhoneCode: false,
  showFlag: true,
  searchEnabled: true,
  pickerMode: CountryPickerMode.bottomSheet, // or .dialog, .fullScreen, .none
  theme: CountryPickerTheme.defaultTheme(),
)
```

**Key Properties:**
| Property | Type | Default | Description |
|---|---|---|---|
| `initialCountryCode` | `CountryCode?` | `null` | Pre-selected country code |
| `onChanged` | `ValueChanged<Country>?` | — | Selection callback |
| `style` | `CountrifyFieldStyle?` | `null` | Unified style object for label/hint/borders/fill/text styles |
| `showPhoneCode` | `bool` | `true` | Show calling code in display |
| `showFlag` | `bool` | `true` | Show flag in prefix |
| `pickerMode` | `CountryPickerMode` | `.bottomSheet` | How the picker opens (`.none` disables selection) |
| `enabled` | `bool` | `true` | Whether the field is interactive |
| `searchEnabled` | `bool` | `true` | Enables search in the picker |
| `filterEnabled` | `bool` | `false` | Enables filter chips in the picker |

Use `style: CountrifyFieldStyle.defaultStyle().copyWith(...)` to customize field decoration and text styles.

---

### `PhoneCodePicker`

A specialized widget for selecting phone/calling codes. Available in all 5 display modes.

```dart
PhoneCodePicker(
  initialCountryCode: CountryCode.us,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  showFlag: true,
  showCountryName: true,
  showDialCode: true,
  flagShape: FlagShape.circular,
  searchEnabled: true,
  pickerMode: CountryPickerMode.bottomSheet,
)
```

---

### CountryStateCityField

A composite cascading form widget that captures a complete
**country → state → city** selection with three stacked dropdowns. Country
data loads eagerly, states and cities are loaded lazily on demand from
bundled assets, and selecting a parent clears the children.

```dart
CountryStateCityField(
  initialCountryCode: CountryCode.us,
  onChanged: (selection) {
    print(selection.country?.name);   // e.g. "United States"
    print(selection.state?.name);     // e.g. "California"
    print(selection.city?.name);      // e.g. "San Francisco"
  },
  style: CountrifyFieldStyle.defaultStyle(),
  searchEnabled: true,
)
```

The dataset ships with **250 countries**, **5,296 states / provinces**, and
**153,823 cities** — sourced from
[dr5hn/countries-states-cities-database](https://github.com/dr5hn/countries-states-cities-database)
and split into per-country / per-state JSON files under `assets/geo/` so
only the records for the currently selected country / state are decoded.

For programmatic access, use `GeoRepository`:

```dart
final repo = GeoRepository.instance;
final states = await repo.statesOf('PK');     // List<CountryState>
final cities = await repo.citiesOf(states.first.id); // List<City>
```

---

### StatePicker

Standalone picker for the states / provinces / regions of a single country.
Supports four display modes (`bottomSheet`, `dialog`, `fullScreen`,
`dropdown`) and is fully themeable.

```dart
StatePicker(
  countryIso2: 'US',
  initialStateId: 1416,
  pickerMode: CountryPickerMode.bottomSheet,
  sortBy: StateSortBy.name,          // or .type, .id
  theme: GeoPickerTheme.light(),
  config: const GeoPickerConfig(
    title: 'Pick your state',
    searchHintText: 'Search states',
    hapticFeedback: true,
  ),
  customStateBuilder: (ctx, state, selected) => Row(
    children: [
      Expanded(child: Text(state.name)),
      if (state.iso2 != null) Text(state.iso2!),
    ],
  ),
  onStateSelected: (state) => print(state.name),
)
```

Every picker supports:

- **Display modes** via `pickerMode` — bottom sheet, dialog, full screen, dropdown, or `none` to suppress opening
- **Sort order** via `sortBy`
- **Accent-insensitive search** — `sao paulo` matches `São Paulo` (toggle via `GeoPickerConfig.accentInsensitiveSearch`)
- **Debounced search** with configurable delay, initial query, and autofocus
- **Live clear button** that reacts instantly to typing
- **`onSearchChanged(query)`** and **`onResultsChanged(List<T>)`** callbacks for observing search state
- **`customMatcher`** hook for fully custom matching logic (fuzzy search, ISO-only search, etc.)
- **Theme** (`GeoPickerTheme`) — 35 visual properties + light/dark presets
- **Config** (`GeoPickerConfig`) — behavior, haptics, heights, text labels
- **Custom row builder** (`customStateBuilder`)
- **Custom header / search / empty-state builders** for full control

#### Search example

```dart
StatePicker(
  countryIso2: 'BR',
  config: const GeoPickerConfig(
    initialSearchText: 'sao',            // Pre-fills the search field
    searchDebounce: Duration(milliseconds: 200),
    accentInsensitiveSearch: true,       // "sao paulo" matches "São Paulo"
    autofocusSearch: true,
  ),
  onSearchChanged: (q) => print('typed: $q'),
  onResultsChanged: (results) => print('${results.length} match'),
  customMatcher: (state, query) =>
      state.name.toLowerCase().contains(query) ||
      (state.iso2?.toLowerCase() == query),
  onStateSelected: (s) => print(s.name),
)
```

Or build a completely custom search field using `customSearchBuilder`:

```dart
StatePicker(
  countryIso2: 'US',
  customSearchBuilder: (context, controller) => TextField(
    controller: controller,               // Wiring the provided controller is required
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.travel_explore),
      labelText: 'Find your state',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    ),
  ),
  onStateSelected: (s) => print(s.name),
)
```

---

### CityPicker

Mirrors `StatePicker` but takes a `stateId` instead of `countryIso2`.

```dart
CityPicker(
  stateId: 1416,
  initialCityId: 111825,
  pickerMode: CountryPickerMode.dialog,
  showCoordinates: true,
  sortBy: CitySortBy.name,
  theme: GeoPickerTheme.dark(),
  onCitySelected: (city) => print('${city.name} (${city.latitude}, ${city.longitude})'),
)
```

---

### StateDropdownField

Form-style dropdown trigger that opens `StatePicker`. Uses
`CountrifyFieldStyle` for decoration so it matches `PhoneNumberField` and
`CountryDropdownField` out of the box.

```dart
String? _countryIso2 = 'US';
CountryState? _state;

StateDropdownField(
  countryIso2: _countryIso2,                // null → disabled
  initialStateId: _state?.id,
  style: CountrifyFieldStyle.defaultStyle().copyWith(labelText: 'State'),
  pickerTheme: GeoPickerTheme.light(),
  pickerConfig: const GeoPickerConfig(searchEnabled: true),
  pickerMode: CountryPickerMode.bottomSheet,
  sortBy: StateSortBy.name,
  showType: true,                            // "province" / "region" as subtitle
  onChanged: (s) => setState(() => _state = s),
)
```

Changing `countryIso2` automatically clears the selection and refetches
states. The field shows an inline spinner while loading.

---

### CityDropdownField

Companion of `StateDropdownField` — cascades from `stateId`.

```dart
CityDropdownField(
  stateId: _state?.id,
  initialCityId: _city?.id,
  style: CountrifyFieldStyle.outlineStyle(),
  pickerMode: CountryPickerMode.bottomSheet,
  showCoordinates: false,
  onChanged: (c) => setState(() => _city = c),
)
```

---

### CitySearchField

Searchable text field that searches across **all** cities for a country
without requiring a pre-selected state. When a city is selected the parent
state is resolved automatically.

```dart
CitySearchField(
  countryIso2: 'US',
  style: CountrifyFieldStyle.defaultStyle().copyWith(
    focusedBoxShadow: [
      BoxShadow(
        color: Colors.blue.withValues(alpha: 0.15),
        blurRadius: 8,
        spreadRadius: 2,
      ),
    ],
  ),
  onChanged: (result) {
    if (result != null) {
      print('${result.city.name}, ${result.state.name}');
      // e.g. "San Francisco, California"
    }
  },
)
```

The field displays results as "City, State" and the `onChanged` callback
provides a `CitySearchResult` record containing both the `City` and its
parent `CountryState`. City files are pre-loaded in the background on init
for snappy search. Changing `countryIso2` clears the selection and
re-preloads.

---

#### Regenerating the bundled dataset

When the upstream dataset releases a new revision, regenerate the vendored
assets with:

```bash
dart run tool/sync_geo_data.dart                     # latest master
dart run tool/sync_geo_data.dart --ref v2.6          # specific tag
dart run tool/sync_geo_data.dart --input path.json   # offline source
```

---

### Shared Building Blocks

Countrify exposes the internal building-block widgets so you can compose custom UIs:

**`CountryFlag`** — Displays a country's flag image with automatic emoji fallback:

```dart
CountryFlag(
  country: CountryUtils.getCountryByAlpha2Code('US')!,
  size: const Size(32, 24),
  borderRadius: BorderRadius.circular(4),
)
```

**`CountryListTile`** — A ready-made list tile showing flag, name, and optional phone code:

```dart
CountryListTile(
  country: country,
  showPhoneCode: true,
  onTap: () => print(country.name),
)
```

**`CountrySearchBar`** — A themed search bar wired up for country filtering:

```dart
CountrySearchBar(
  onChanged: (query) => print('Searching: $query'),
  theme: CountryPickerTheme.defaultTheme(),
)
```

---

## Theming

Countrify ships with **4 theme presets** and supports fully custom themes. Every visual aspect of the picker is themeable.

### Built-in Themes

```dart
// Default light theme
CountryPickerTheme.defaultTheme()

// Dark theme
CountryPickerTheme.darkTheme()

// Material Design 3 theme
CountryPickerTheme.material3Theme()

// Custom theme from a primary color
CountryPickerTheme.custom(
  primaryColor: Colors.teal,
  backgroundColor: Colors.white,
  isDark: false,
)
```

### Applying a Theme

```dart
CountryPicker(
  onCountrySelected: (country) { },
  theme: CountryPickerTheme.darkTheme(),
)
```

### Custom Themes

Use `CountryPickerTheme.custom()` for quick theming, or `copyWith()` for fine-grained control:

```dart
final customTheme = CountryPickerTheme.custom(
  primaryColor: Colors.deepPurple,
  backgroundColor: Colors.white,
  isDark: false,
).copyWith(
  countryItemBorderRadius: BorderRadius.circular(16),
  searchBarBorderRadius: BorderRadius.circular(24),
  headerTextStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  ),
);
```

### Full Theme Properties

Every visual aspect is customizable via `CountryPickerTheme`:

```dart
const theme = CountryPickerTheme(
  // ─── Background ──────────────────────────────────
  backgroundColor: Colors.white,
  headerColor: Color(0xFFF5F5F5),

  // ─── Header ──────────────────────────────────────
  headerTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  headerIconColor: Colors.black54,

  // ─── Search Bar ──────────────────────────────────
  searchBarColor: Color(0xFFF8F9FA),
  searchTextStyle: TextStyle(fontSize: 16),
  searchHintStyle: TextStyle(fontSize: 16, color: Colors.black54),
  searchIconColor: Colors.black54,
  searchBarBorderColor: Color(0xFFE0E0E0),
  searchBarBorderRadius: BorderRadius.all(Radius.circular(12)),
  searchHintText: 'Search countries...',
  searchCursorColor: Colors.blue,
  searchFocusedBorderColor: Colors.blue,
  searchInputDecoration: null,         // Full InputDecoration override

  // ─── Country Items ───────────────────────────────
  countryItemBackgroundColor: Colors.white,
  countryItemSelectedColor: Color(0xFFE3F2FD),
  countryItemSelectedBorderColor: Color(0xFF2196F3),
  countryItemSelectedIconColor: Color(0xFF2196F3),
  countryItemBorderRadius: BorderRadius.all(Radius.circular(8)),
  countryNameTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  countrySubtitleTextStyle: TextStyle(fontSize: 14, color: Colors.grey),
  compactCountryNameTextStyle: TextStyle(fontSize: 13, color: Colors.black54),
  compactDialCodeTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  readOnlyHintTextStyle: TextStyle(fontSize: 14, color: Colors.black54),
  flagEmojiTextStyle: TextStyle(fontSize: 16),
  appBarTitleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  dialogOptionTextStyle: TextStyle(fontSize: 14),
  dialogActionTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),

  // ─── Filter Chips ────────────────────────────────
  filterBackgroundColor: Color(0xFFF0F0F0),
  filterSelectedColor: Color(0xFF2196F3),
  filterTextColor: Colors.black87,
  filterSelectedTextColor: Colors.white,
  filterCheckmarkColor: Colors.white,
  filterIconColor: Colors.black54,

  // ─── Borders & Elevation ─────────────────────────
  borderColor: Color(0xFFE0E0E0),
  borderRadius: BorderRadius.all(Radius.circular(20)),
  elevation: 8.0,
  shadowColor: Color(0x1A000000),

  // ─── Scrollbar ───────────────────────────────────
  scrollbarThickness: 6.0,
  scrollbarRadius: BorderRadius.all(Radius.circular(3)),

  // ─── Dropdown-Specific ───────────────────────────
  dropdownMenuBackgroundColor: Colors.white,
  dropdownMenuElevation: 8,
  dropdownMenuBorderRadius: BorderRadius.all(Radius.circular(12)),
  dropdownMenuBorderColor: Colors.grey,
  dropdownMenuBorderWidth: 1,

  // ─── Customizable Icons ──────────────────────────
  closeIcon: CountrifyIcons.x,
  searchIcon: CountrifyIcons.search,
  clearIcon: CountrifyIcons.circleX,
  selectedIcon: CountrifyIcons.circleCheckBig,
  filterIcon: CountrifyIcons.listFilter,
  dropdownIcon: CountrifyIcons.chevronDown,
  emptyStateIcon: CountrifyIcons.searchX,
  defaultCountryIcon: CountrifyIcons.globe,

  // ─── Behavior ────────────────────────────────────
  animationDuration: Duration(milliseconds: 300),
  hapticFeedback: true,
);
```

---

## Configuration

`CountryPickerConfig` now contains only **shared** options used across multiple widgets.

Use widget-level parameters on `CountryPicker` for advanced behavior (custom builders, sorting/filter defaults, advanced flag shape/size/shadow, sizing, etc.).

### Display Options

```dart
const config = CountryPickerConfig(
  locale: 'en',                      // Optional locale override
  enableSearch: true,                // Shared search toggle
  includeRegions: ['Europe'],        // Shared include filter
  excludeRegions: ['Antarctica'],    // Shared exclude filter
  includeCountries: ['US', 'CA'],    // Shared include by alpha-2
  excludeCountries: ['AQ'],          // Shared exclude by alpha-2
);
```

### Flag Customization

Shared flag styling via config (border only):

```dart
const config = CountryPickerConfig(
  flagBorderRadius: BorderRadius.all(Radius.circular(6)),
  flagBorderColor: Colors.grey,
  flagBorderWidth: 2,
);
```

Advanced flag styling via `CountryPicker` (widget-level):

```dart
CountryPicker(
  onCountrySelected: (country) { },
  flagShape: FlagShape.rounded,
  flagSize: Size(40, 28),
  flagShadowColor: Colors.black26,
  flagShadowBlur: 6,
  flagShadowOffset: Offset(0, 3),
)
```

### Filtering Countries

```dart
const config = CountryPickerConfig(
  // Include only specific regions
  includeRegions: ['Europe', 'Asia'],

  // Exclude specific regions
  excludeRegions: ['Antarctica'],

  // Include only specific countries (by alpha-2 code)
  includeCountries: ['US', 'CA', 'GB', 'DE', 'FR'],

  // Exclude specific countries (by alpha-2 code)
  excludeCountries: ['XX'],
);
```

### Sorting

Sorting is a widget-level parameter on `CountryPicker`:

```dart
CountryPicker(
  onCountrySelected: (country) { },
  sortBy: CountrySortBy.name,        // Alphabetical (default)
  // sortBy: CountrySortBy.population, // Most populous first
  // sortBy: CountrySortBy.area,       // Largest area first
  // sortBy: CountrySortBy.region,     // Grouped by region
  // sortBy: CountrySortBy.capital,    // Alphabetical by capital
)
```

### Sizing

Sizing is a widget-level parameter on `CountryPicker`:

```dart
CountryPicker(
  onCountrySelected: (country) { },
  maxHeight: 600.0,           // Maximum picker height
  minHeight: 200.0,           // Minimum picker height
  dropdownMaxHeight: 400.0,   // Maximum dropdown menu height
)
```

### Custom Builders

Custom builders are available on `CountryPicker` (not shared config):

```dart
CountryPicker(
  onCountrySelected: (country) { },
  // Custom country item
  customCountryBuilder: (context, country, isSelected) {
    return ListTile(
      leading: Image.asset(
        country.flagImagePath,
        package: 'countrify',
        width: 32,
        height: 24,
      ),
      title: Text(country.name),
      subtitle: Text('+${country.callingCodes.first}'),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Colors.blue)
          : null,
    );
  },

  // Custom header
  customHeaderBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text('Pick Your Country',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  },

  // Custom search bar
  customSearchBuilder: (context, controller, onChanged) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Type to search...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  },

  // Custom filter bar
  customFilterBuilder: (context, filter, onChanged) {
    return Wrap(
      children: ['Europe', 'Asia', 'Africa'].map((region) {
        return FilterChip(
          label: Text(region),
          selected: filter.regions.contains(region),
          onSelected: (selected) {
            final regions = selected
                ? [...filter.regions, region]
                : filter.regions.where((r) => r != region).toList();
            onChanged(filter.copyWith(regions: regions));
          },
        );
      }).toList(),
    );
  },
)
```

### Customizable Strings

`CountryPickerConfig` controls **shared** strings used by multiple widgets:

```dart
const config = CountryPickerConfig(
  titleText: 'Choose Your Country',       // Shared picker title
  searchHintText: 'Type to search...',    // Shared search placeholder
  emptyStateText: 'Nothing found',        // Shared empty state message
  selectCountryHintText: 'Tap to choose', // Shared unselected hint
);
```

Filter labels are widget-level parameters on `CountryPicker`:

```dart
CountryPicker(
  onCountrySelected: (country) { },
  filterTitleText: 'Filter Options',       // Filter dialog title
  filterSortByText: 'Sort:',               // Filter sort label
  filterRegionsText: 'Regions:',           // Filter regions label
  filterAllText: 'All',                    // "All" filter chip label
  filterCancelText: 'Cancel',              // Filter cancel button
  filterApplyText: 'Done',                 // Filter apply button
)
```

**`CountryPickerConfig` from `CountryPicker`:**

```dart
const config = CountryPickerConfig(
  titleText: 'Choose Your Country',        // Picker header title
  searchHint: 'Type to search...',         // Search bar placeholder
  emptyStateMessage: 'Nothing found',      // Shown when search has no results
  selectCountryHintText: 'Tap to choose',  // Placeholder when nothing is selected
);
```

All strings have sensible English defaults, so existing apps require **zero changes**.

| Parameter | Default | Where it appears |
|-----------|---------|-----------------|
| `titleText` | `'Select Country'` | Header of every picker |
| `searchHintText` / `searchHint` | `'Search countries...'` | Search bar placeholder |
| `emptyStateText` / `emptyStateMessage` | `'No countries found'` | Empty search results |
| `selectCountryHintText` | `'Select a country'` | Dropdown/field placeholder |
| `filter*Text` | Widget-level params | Comprehensive filter UI |

---

## Country Data & Utilities

Use `CountryUtils` to access country data programmatically without showing any picker UI.

### Fetching Countries

```dart
// Get all 250 countries
final countries = CountryUtils.getAllCountries();

// Get by ISO code
final usa = CountryUtils.getCountryByAlpha2Code('US');
final canada = CountryUtils.getCountryByAlpha3Code('CAN');
final germany = CountryUtils.getCountryByNumericCode('276');

// Search by name (case-insensitive)
final results = CountryUtils.searchCountries('united');

// Get by region or subregion
final european = CountryUtils.getCountriesByRegion('Europe');
final southAmerican = CountryUtils.getCountriesBySubregion('South America');

// Get by calling code
final countriesWith1 = CountryUtils.getCountriesByCallingCode('+1');

// Get by currency
final euroCountries = CountryUtils.getCountriesByCurrencyCode('EUR');

// Get by language
final englishSpeaking = CountryUtils.getCountriesByLanguageCode('en');

// Get bordering countries
final neighbors = CountryUtils.getBorderCountries('USA');
```

### Sorting

```dart
final byPopulation = CountryUtils.getCountriesSortedByPopulation();
final byArea = CountryUtils.getCountriesSortedByArea();
final alphabetical = CountryUtils.getCountriesSortedByName();
```

### Filtered Collections

```dart
final independent = CountryUtils.getIndependentCountries();
final unMembers = CountryUtils.getUnMemberCountries();
```

### Statistics

```dart
final totalPopulation = CountryUtils.getTotalWorldPopulation();
final totalArea = CountryUtils.getTotalWorldArea();

final mostPopulous = CountryUtils.getMostPopulousCountry();
final largest = CountryUtils.getLargestCountry();
final smallest = CountryUtils.getSmallestCountry();

// Formatted output
print(CountryUtils.formatPopulation(totalPopulation)); // "7,794,798,739"
print(CountryUtils.formatArea(totalArea));              // "148,940,000.00"
```

### Metadata Lookups

```dart
final regions = CountryUtils.getAllRegions();         // ["Africa", "Americas", ...]
final subregions = CountryUtils.getAllSubregions();   // ["Caribbean", "Central Asia", ...]
final currencies = CountryUtils.getAllCurrencies();
final languages = CountryUtils.getAllLanguages();
final timezones = CountryUtils.getAllTimezones();
```

### Validation

```dart
CountryUtils.isValidAlpha2Code('US');   // true
CountryUtils.isValidAlpha3Code('USA');  // true
CountryUtils.isValidNumericCode('840'); // true
CountryUtils.isValidAlpha2Code('XX');   // false
```

---

## Localization (132 Languages)

Countrify ships with built-in country name translations for **132 languages**, sourced from [CLDR data](https://github.com/umpirsky/country-list). All translations are compile-time constants — zero runtime dependencies, no network requests, no JSON parsing.

### Automatic Locale Detection (Recommended)

**All picker widgets auto-detect the locale from your `MaterialApp`.** If your app already sets a locale, every Countrify widget will display localized country names, search results, and sort order automatically — no extra configuration needed.

```dart
// 1. Add flutter_localizations to your pubspec.yaml:
//    dependencies:
//      flutter_localizations:
//        sdk: flutter

// 2. Configure your MaterialApp:
import 'package:flutter_localizations/flutter_localizations.dart';

MaterialApp(
  locale: const Locale('ja'), // or any of 132 supported languages
  supportedLocales: const [
    Locale('ja'),
    Locale('en'),
    // ... your supported locales
  ],
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  // ...
);

// 3. That's it! All Countrify pickers now show Japanese country names.
//    No per-widget configuration needed.
PhoneNumberField(
  onChanged: (phoneNumber, country) { },
)
// → shows アメリカ合衆国, ドイツ, フランス, ...
```

> **How it works:** Every picker widget calls `Localizations.localeOf(context)` to read the current locale from the widget tree. If your `MaterialApp` sets a locale and includes it in `supportedLocales` with the appropriate delegates, all pickers will pick it up automatically.

### Explicit Locale Override

Use `CountryPickerConfig.locale` to override the auto-detected locale for a specific widget:

```dart
// Force German names on this picker, regardless of app locale
CountryPicker(
  onCountrySelected: (country) { },
  config: CountryPickerConfig(locale: 'de'),
)

// Force English even if app locale is non-English
PhoneNumberField(
  onChanged: (phoneNumber, country) { },
  config: CountryPickerConfig(locale: 'en'),
)
```

| Scenario | What to do |
|----------|-----------|
| App already has a locale set | Nothing — auto-detected |
| Override locale for one widget | `CountryPickerConfig(locale: 'de')` |
| Force English in a non-English app | `CountryPickerConfig(locale: 'en')` |
| No locale set anywhere | Defaults to English |

### Programmatic Access

Use `CountryUtils` to get localized names in code (outside of widgets):

```dart
final usa = CountryUtils.getCountryByAlpha2Code('US')!;

CountryUtils.getCountryNameInLanguage(usa, 'de'); // "Vereinigte Staaten"
CountryUtils.getCountryNameInLanguage(usa, 'fr'); // "États-Unis"
CountryUtils.getCountryNameInLanguage(usa, 'ja'); // "アメリカ合衆国"
CountryUtils.getCountryNameInLanguage(usa, 'ar'); // "الولايات المتحدة"
CountryUtils.getCountryNameInLanguage(usa, 'zh'); // "美国"
CountryUtils.getCountryNameInLanguage(usa, 'hi'); // "संयुक्त राज्य"
```

The method checks the country's `nameTranslations` map first (for user-provided overrides), then falls back to the built-in CLDR data, and finally returns the English name.

### Get All Translations for a Country

```dart
final allNames = CountryUtils.getCountryNamesInAllLanguages(usa);
// Returns a Map<String, String> with 130+ entries:
// {"af": "Verenigde State van Amerika", "ar": "الولايات المتحدة", "de": "Vereinigte Staaten", ...}
```

### List Supported Locales

```dart
final locales = CountryUtils.getSupportedLocales();
// ["af", "ak", "am", "ar", "as", "az", "be", "bg", ..., "zh", "zu"]
// 132 locale codes
```

### Direct Access via CountryNameL10n

For lower-level access without going through `CountryUtils`:

```dart
import 'package:countrify/countrify.dart';

// Get a single translation
final name = CountryNameL10n.getLocalizedName('DE', 'fr'); // "Allemagne"

// Get all country names for a locale
final frenchNames = CountryNameL10n.getTranslationsForLocale('fr');
// {"AD": "Andorre", "AE": "Émirats arabes unis", "AF": "Afghanistan", ...}

// Check supported locales
final locales = CountryNameL10n.supportedLocales; // 132 entries
```

### Supported Languages

<details>
<summary>Full list of 132 supported language codes</summary>

`af` `ak` `am` `ar` `as` `az` `be` `bg` `bm` `bn` `bo` `br` `bs` `ca` `ce` `cs` `cy` `da` `de` `dz` `ee` `el` `en` `eo` `es` `et` `eu` `fa` `ff` `fi` `fo` `fr` `fy` `ga` `gd` `gl` `gu` `gv` `ha` `he` `hi` `hr` `hu` `hy` `ia` `id` `ig` `ii` `is` `it` `ja` `jv` `ka` `ki` `kk` `kl` `km` `kn` `ko` `ks` `ku` `kw` `ky` `lb` `lg` `ln` `lo` `lt` `lu` `lv` `mg` `mi` `mk` `ml` `mn` `mr` `ms` `mt` `my` `nb` `nd` `ne` `nl` `nn` `no` `om` `or` `os` `pa` `pl` `ps` `pt` `qu` `rm` `rn` `ro` `ru` `rw` `se` `sg` `si` `sk` `sl` `sn` `so` `sq` `sr` `sv` `sw` `ta` `te` `tg` `th` `ti` `tk` `tl` `to` `tr` `tt` `ug` `uk` `ur` `uz` `vi` `vo` `wo` `xh` `yo` `zh` `zu`

</details>

---

## Country Model

Each `Country` object contains comprehensive data:

```dart
class Country {
  final String name;                          // "United States"
  final Map<String, String> nameTranslations; // {"es": "Estados Unidos", ...}
  final String alpha2Code;                    // "US"
  final String alpha3Code;                    // "USA"
  final String numericCode;                   // "840"
  final String flagEmoji;                     // Unicode flag emoji
  final String flagImagePath;                 // Asset path for PNG flag
  final String capital;                       // "Washington, D.C."
  final String? largestCity;                  // "New York City"
  final String region;                        // "Americas"
  final String subregion;                     // "Northern America"
  final int population;                       // 331002651
  final double area;                          // 9833520.0 (km2)
  final List<String> callingCodes;            // ["1"]
  final List<String> topLevelDomains;         // [".us"]
  final List<Currency> currencies;            // [Currency(code: "USD", ...)]
  final List<Language> languages;             // [Language(name: "English", ...)]
  final List<String> timezones;               // ["UTC-12:00", ...]
  final List<String> borders;                 // ["CAN", "MEX"]
  final bool isIndependent;                   // true
  final bool isUnMember;                      // true
}

class Currency {
  final String code;    // "USD"
  final String name;    // "United States dollar"
  final String symbol;  // "$"
}

class Language {
  final String iso6391;    // "en"
  final String iso6392;    // "eng"
  final String name;       // "English"
  final String nativeName; // "English"
}
```

---

## Enums Reference

### `FlagShape`

| Value | Description |
|---|---|
| `FlagShape.rectangular` | Standard rectangular flag (default) |
| `FlagShape.circular` | Circular cropped flag |
| `FlagShape.rounded` | Rounded rectangle flag |

### `CountrySortBy`

| Value | Description |
|---|---|
| `CountrySortBy.name` | Alphabetical by country name (default) |
| `CountrySortBy.population` | Descending by population |
| `CountrySortBy.area` | Descending by area |
| `CountrySortBy.region` | Alphabetical by region |
| `CountrySortBy.capital` | Alphabetical by capital city |

### `CountryPickerType`

| Value | Description |
|---|---|
| `CountryPickerType.bottomSheet` | Slides up from bottom |
| `CountryPickerType.dialog` | Centered popup |
| `CountryPickerType.fullScreen` | Full screen page |
| `CountryPickerType.dropdown` | Inline dropdown with popup menu |
| `CountryPickerType.inline` | Embedded inline list |
| `CountryPickerType.none` | Read-only mode (disables changing selection) |

### `CountryPickerMode`

Used by `PhoneNumberField`, `CountryDropdownField`, and `PhoneCodePicker` to control how the picker is presented.

| Value | Description |
|---|---|
| `CountryPickerMode.dropdown` | Compact scrollable dropdown anchored below the field |
| `CountryPickerMode.bottomSheet` | Modal bottom sheet |
| `CountryPickerMode.dialog` | Centered dialog popup |
| `CountryPickerMode.fullScreen` | Full screen page |
| `CountryPickerMode.none` | Read-only mode (disables changing selection) |

---

## Real-World Examples

### Phone Number Input with PhoneNumberField

```dart
PhoneNumberField(
  style: const CountrifyFieldStyle(
    hintText: 'Enter phone number',
    labelText: 'Phone',
  ),
  theme: CountryPickerTheme.defaultTheme(),
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(15),
  ],
  onChanged: (phoneNumber, country) {
    print('Full number: +${country.callingCodes.first}$phoneNumber');
  },
  onCountryChanged: (country) {
    print('Country changed: ${country.name}');
  },
)
```

### Registration Form with CountryDropdownField

```dart
CountryDropdownField(
  initialCountryCode: _selectedCountryCode,
  onChanged: (country) {
    setState(() => _selectedCountry = country);
  },
  style: CountrifyFieldStyle.defaultStyle().copyWith(
    hintText: 'Select your country',
  ),
  showPhoneCode: false,
  showFlag: true,
  searchEnabled: true,
  pickerMode: CountryPickerMode.bottomSheet,
)
```

### European Countries Only

```dart
CountryPicker(
  onCountrySelected: (country) { },
  config: const CountryPickerConfig(
    includeRegions: ['Europe'],
  ),
  showPhoneCode: true,
  searchEnabled: true,
)
```

### Dark Theme Picker

```dart
CountryPicker(
  onCountrySelected: (country) { },
  theme: CountryPickerTheme.darkTheme(),
  showPhoneCode: true,
  searchEnabled: true,
)
```

### Circular Flags

```dart
CountryPicker(
  onCountrySelected: (country) { },
  flagShape: FlagShape.circular,
  flagSize: const Size(40, 40),
  showPhoneCode: true,
)
```

### Custom Country Item Builder

```dart
CountryPicker(
  onCountrySelected: (country) { },
  customCountryBuilder: (context, country, isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              country.flagImagePath,
              package: 'countrify',
              width: 48,
              height: 36,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(country.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('+${country.callingCodes.first}',
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.blue),
        ],
      ),
    );
  },
)
```

### Using CountryFlag Standalone

Use the `CountryFlag` widget to display a country's flag anywhere in your app:

```dart
CountryFlag(
  country: CountryUtils.getCountryByAlpha2Code('US')!,
  size: const Size(32, 24),
  borderRadius: BorderRadius.circular(4),
)
```

If you need direct asset access, include the `package` parameter:

```dart
Image.asset(
  country.flagImagePath,
  package: 'countrify',
  width: 32,
  height: 24,
)
```

---

## Troubleshooting

<details>
<summary><strong>Flag images not loading</strong></summary>

Use the `CountryFlag` widget for automatic fallback handling. If using `Image.asset` directly, always include the `package` parameter:

```dart
// Recommended:
CountryFlag(
  country: country,
  size: const Size(32, 24),
)

// Or with Image.asset directly:
Image.asset(
  country.flagImagePath,
  package: 'countrify',  // Don't forget this!
  width: 32,
  height: 24,
)
```

</details>

<details>
<summary><strong>Picker not appearing</strong></summary>

Ensure the widget is placed inside a valid widget tree with a `BuildContext` that has access to a `Navigator`. If using `CountryDropdownField` or `PhoneNumberField`, ensure they are inside a `Scaffold` or similar root widget.

</details>

<details>
<summary><strong>Country not found by code</strong></summary>

Country codes must be **uppercase**:

```dart
final country = CountryUtils.getCountryByAlpha2Code('US'); // Correct
// Not: CountryUtils.getCountryByAlpha2Code('us');          // Wrong
```

</details>

<details>
<summary><strong>Selected country not appearing at top of list</strong></summary>

Pass the `initialCountryCode` parameter so the picker places it at the top:

```dart
CountryPicker(
  initialCountryCode: _selectedCountryCode,
  onCountrySelected: (country) { },
)
```

</details>

<details>
<summary><strong>PhoneNumberField dropdown not dismissing</strong></summary>

The dropdown overlay dismisses when tapping outside it. If you're embedding `PhoneNumberField` in a scrollable view, ensure the overlay has space to render below the field. You can adjust `dropdownMaxHeight` to control its size.

</details>

---

## FAQ

<details>
<summary><strong>Is this package free to use?</strong></summary>

Yes. Countrify is open-source under the MIT License.
</details>

<details>
<summary><strong>Does it work on all platforms?</strong></summary>

Yes. Countrify works on iOS, Android, Web, macOS, Windows, and Linux.
</details>

<details>
<summary><strong>How large is the package?</strong></summary>

Approximately 3–4 MB. Most of that is PNG flag images (~2.5 MB) and the built-in translation data for 132 languages (~1 MB). The translation data is compile-time constant and tree-shakable.
</details>

<details>
<summary><strong>Does it support RTL languages?</strong></summary>

Yes. The package respects Flutter's text direction settings. Country name translations are available for RTL languages including Arabic (`ar`), Hebrew (`he`), Persian/Farsi (`fa`), Urdu (`ur`), and Pashto (`ps`).
</details>

<details>
<summary><strong>How does localization work?</strong></summary>

All picker widgets **auto-detect** the locale from your `MaterialApp`. If your app sets `locale: Locale('de')` (with matching `supportedLocales` and `localizationsDelegates`), every Countrify picker will show German country names automatically — no per-widget configuration needed. You can also override per-widget with `CountryPickerConfig(locale: 'ja')`. Under the hood, all 132 language translations are sourced from [CLDR data](https://github.com/umpirsky/country-list) and stored as compile-time `static const` maps — no runtime dependencies, no network requests, no JSON parsing. See the [Localization](#localization-132-languages) section for full details.
</details>

<details>
<summary><strong>Can I customize the picker's UI text strings?</strong></summary>

Yes. Shared strings (title/search/empty/hint) are configurable via `CountryPickerConfig`. Filter labels are configurable via `CountryPicker` widget parameters.
</details>

<details>
<summary><strong>Can I filter countries?</strong></summary>

Yes. Use shared include/exclude filters in `CountryPickerConfig` and sorting/filter defaults via `CountryPicker` widget parameters.
</details>

<details>
<summary><strong>Can I provide my own country item UI?</strong></summary>

Yes. Use `customCountryBuilder` (and related custom builders) on `CountryPicker`.
</details>

<details>
<summary><strong>Is the country data accurate?</strong></summary>

The data is sourced from public ISO 3166-1 records and is kept as current as possible. Please report any inaccuracies via GitHub issues.
</details>

<details>
<summary><strong>What's the difference between CountryDropdownField and PhoneNumberField?</strong></summary>

`CountryDropdownField` is a form field for selecting a country (displays country name/flag). `PhoneNumberField` is a complete phone input widget that combines a country code picker prefix with a text input for the phone number.
</details>

---

## Contributing

Contributions are welcome! Here's how to get started:

```bash
# Clone the repository
git clone https://github.com/Arhamss/countrify.git
cd countrify

# Install dependencies
flutter pub get

# Run the example app
cd example && flutter run

# Run tests
flutter test

# Run analysis
flutter analyze
```

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## Contributors

<table>
<tr>
<td align="center">
<a href="https://github.com/Arhamss">
<img src="https://github.com/Arhamss.png" width="80" style="border-radius:50%;" alt="Arham Imran"/>
<br />
<b>Syed Arham Imran</b>
</a>
<br />
<a href="https://www.linkedin.com/in/syed-arham">LinkedIn</a>
</td>
<td align="center">
<a href="https://github.com/Abdullah-Zeb-0301">
<img src="https://github.com/Abdullah-Zeb-0301.png" width="80" style="border-radius:50%;" alt="Abdullah Zeb"/>
<br />
<b>Abdullah Zeb</b>
</a>
<br />
<a href="https://linkedin.com/in/abdullah-zeb-65095b226/">LinkedIn</a>
</td>
<td align="center">
<a href="https://github.com/Manas1255">
<img src="https://github.com/Manas1255.png" width="80" style="border-radius:50%;" alt="Muhammad Anas Akhtar"/>
<br />
<b>Muhammad Anas Akhtar</b>
</a>
<br />
<a href="https://www.linkedin.com/feed/update/urn:li:activity:7426607827072413697/">LinkedIn</a>
</td>
</tr>
<tr>
<td align="center">
<a href="https://github.com/ShoaibIrfan">
<img src="https://github.com/ShoaibIrfan.png" width="80" style="border-radius:50%;" alt="Muhammad Shoaib Irfan"/>
<br />
<b>Muhammad Shoaib Irfan</b>
</a>
<br />
<a href="https://www.linkedin.com/in/shoaib-irfan-2ba9991b9/">LinkedIn</a>
</td>
<td align="center">
<a href="https://github.com/shahab699">
<img src="https://github.com/shahab699.png" width="80" style="border-radius:50%;" alt="Shahab Arif"/>
<br />
<b>Shahab Arif</b>
</a>
<br />
<a href="https://www.linkedin.com/in/shahab-arif-b272721b7/">LinkedIn</a>
</td>
</tr>
</table>

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">

**[GitHub](https://github.com/Arhamss/countrify)** | **[Issues](https://github.com/Arhamss/countrify/issues)** | **[Codeable](https://gocodeable.com)**

<a href="https://buymeacoffee.com/abdullahzer" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="217" height="60"></a>

Built with ❤️ by **[Codeable](https://gocodeable.com)**

</div>
