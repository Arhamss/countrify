# Countrify - Cursor AI Context

Welcome to the Countrify Flutter package. This directory contains comprehensive context and documentation for AI-assisted development with Cursor.

---

## 📚 Documentation Index

### 1. [Overview](./overview.md)
**Complete project overview and architecture**
- Project structure and organization
- Core architecture and design decisions
- Key features and capabilities
- Technical design rationale
- Performance characteristics
- Known limitations and future roadmap

**Read this first** to understand the overall architecture and design philosophy.

### 2. [API Reference](./api-reference.md)
**Complete API documentation**
- Modal Pickers (ModalCountryPicker, ModalComprehensivePicker)
- Base Widgets (CountryPicker, ComprehensiveCountryPicker, PhoneCodePicker)
- Models (Country, Currency, Language)
- Configuration (CountryPickerConfig, CountryFilter)
- Theme (CountryPickerTheme)
- Utilities (CountryUtils - 40+ methods)
- Enums and constants

**Use this** when you need specific method signatures and parameter details.

### 3. [Widgets Guide](./widgets-guide.md)
**Comprehensive widget usage guide**
- Widget architecture and hierarchy
- Modal pickers usage and patterns
- Base widgets implementation
- Customization patterns (theme, config, builders)
- State management integration
- Performance optimization
- Common patterns and best practices

**Use this** when implementing or customizing picker widgets.

### 4. [Development Guide](./development-guide.md)
**Development and contribution guidelines**
- Development setup
- Code style and standards
- Adding new features
- Testing guidelines
- Performance considerations
- Common development tasks
- Troubleshooting

**Use this** when contributing to or extending the package.

### 5. [Examples Cookbook](./examples-cookbook.md)
**Real-world usage examples**
- Basic examples (simple selectors, searches)
- Form integration (registration forms)
- Phone number input (international phone)
- Multi-language support (localized names)
- Custom UI variations (grid view, compact)
- Advanced filtering (regional selectors)
- State management (Provider, Riverpod, Bloc)
- E-commerce integration (shipping selectors)

**Use this** for copy-paste ready implementation examples.

### 6. [Cursor Rules](./cursor-rules.md)
**AI-specific development rules**
- Code generation patterns
- API design rules
- Testing requirements
- Performance rules
- Package-specific patterns
- Error handling
- Accessibility requirements

**Cursor AI should follow these rules** for all code generation and modifications.

---

## 🚀 Quick Start

### For First-Time Users

1. **Read the [Overview](./overview.md)** - Understand what Countrify is and how it works
2. **Browse [Examples Cookbook](./examples-cookbook.md)** - Find an example similar to your use case
3. **Check [API Reference](./api-reference.md)** - Look up specific methods and parameters
4. **Refer to [Widgets Guide](./widgets-guide.md)** - Customize the picker to your needs

### For Contributors

1. **Read [Development Guide](./development-guide.md)** - Set up your development environment
2. **Study [Cursor Rules](./cursor-rules.md)** - Understand code standards and patterns
3. **Review [API Reference](./api-reference.md)** - Understand the public API
4. **Check [Overview](./overview.md)** - Understand architectural decisions

### For Cursor AI

1. **Start with [Cursor Rules](./cursor-rules.md)** - Follow these rules for all operations
2. **Reference [API Reference](./api-reference.md)** - For accurate method signatures
3. **Use [Examples Cookbook](./examples-cookbook.md)** - For implementation patterns
4. **Consult [Overview](./overview.md)** - For architectural context

---

## 📖 Common Tasks

### Implementing a Basic Country Picker

```dart
// 1. Import the package
import 'package:countrify/countrify.dart';

// 2. Show the picker
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
);

// 3. Use the selected country
if (country != null) {
  print('Selected: ${country.name}');
}
```

**More details:** [Examples Cookbook - Basic Examples](./examples-cookbook.md#basic-examples)

### Customizing the Theme

```dart
final theme = CountryPickerTheme.custom(
  primaryColor: Colors.purple,
  backgroundColor: Colors.white,
  isDark: false,
);

final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  theme: theme,
);
```

**More details:** [Widgets Guide - Theme Customization](./widgets-guide.md#theme-customization)

### Creating a Phone Number Input

```dart
// See complete example with country code picker
// integrated with phone number input
```

**More details:** [Examples Cookbook - Phone Number Input](./examples-cookbook.md#phone-number-input)

### Filtering Countries by Region

```dart
const config = CountryPickerConfig(
  includeRegions: ['Europe', 'Asia'],
);

final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  config: config,
);
```

**More details:** [API Reference - CountryPickerConfig](./api-reference.md#countrypickerconfig)

### Accessing Country Data

```dart
// Get all countries
final countries = CountryUtils.getAllCountries();

// Search by name
final results = CountryUtils.searchCountries('united');

// Get by code
final usa = CountryUtils.getCountryByAlpha2Code('US');

// Get by region
final european = CountryUtils.getCountriesByRegion('Europe');
```

**More details:** [API Reference - CountryUtils](./api-reference.md#utilities)

---

## 🎯 Package Overview

### What is Countrify?

Countrify is a comprehensive Flutter package for country selection that provides:

- **Rich Country Data**: 245+ countries with ISO codes, capitals, populations, currencies, languages, etc.
- **Beautiful UI**: Customizable picker widgets with multiple display modes
- **Flag Assets**: High-quality PNG flags for all countries
- **Utility Functions**: 40+ helper methods for country operations
- **Type Safe**: Full null-safety and type-safe API
- **Zero Dependencies**: No external runtime dependencies

### Key Features

1. **Multiple Display Modes**
   - Bottom Sheet (slides from bottom)
   - Dialog (centered popup)
   - Full Screen (takes entire screen)

2. **Comprehensive Data**
   - ISO 3166-1 codes (alpha-2, alpha-3, numeric)
   - Phone/calling codes
   - Geographic data (region, subregion, borders)
   - Demographics (population, area)
   - Economic data (currencies)
   - Linguistic data (languages)
   - Temporal data (timezones)

3. **Advanced Features**
   - Real-time search with debouncing
   - Multi-criteria filtering
   - Region/subregion filtering
   - Custom sorting
   - Grouping support
   - Multiple selection
   - Custom builders for UI

4. **Customization**
   - Complete theme control (colors, typography, spacing)
   - Flag customization (shape, size, borders, shadows)
   - Behavioral configuration (search, filters, animations)
   - Custom widget builders

### Package Structure

```
countrify/
├── lib/
│   ├── countrify.dart              # Main export (PUBLIC API)
│   ├── src/
│   │   ├── data/                   # Country data
│   │   │   ├── all_countries.dart
│   │   │   └── countries_data.dart
│   │   ├── models/                 # Data models
│   │   │   └── country.dart
│   │   ├── utils/                  # Utility functions
│   │   │   └── country_utils.dart
│   │   └── widgets/                # UI components
│   │       ├── country_picker.dart
│   │       ├── comprehensive_country_picker.dart
│   │       ├── modal_country_picker.dart
│   │       ├── modal_comprehensive_picker.dart
│   │       ├── phone_code_picker.dart
│   │       ├── country_picker_config.dart
│   │       └── country_picker_theme.dart
│   └── generated/
│       └── assets.dart             # Generated asset paths
├── assets/
│   └── images/
│       └── flags/                  # 245+ flag PNGs
├── example/                        # Example application
├── test/                          # Unit tests
└── .cursor/                       # THIS DIRECTORY
    ├── README.md                  # This file
    ├── overview.md
    ├── api-reference.md
    ├── widgets-guide.md
    ├── development-guide.md
    ├── examples-cookbook.md
    └── cursor-rules.md
```

---

## 🔧 Development Information

### Requirements

- **Dart**: ^3.0.0
- **Flutter**: ^3.0.0
- **No external runtime dependencies**

### Development Dependencies

- `flutter_test`: Testing framework
- `mocktail`: Mocking for tests
- `very_good_analysis`: Strict linting rules
- `flutter_lints`: Additional linting
- `csv`: Data parsing tool

### Getting Started

```bash
# Clone and setup
git clone <repository>
cd countrify
flutter pub get

# Run tests
flutter test

# Run example
cd example
flutter run

# Analyze code
flutter analyze

# Format code
dart format .
```

### Contributing

1. Follow the [Development Guide](./development-guide.md)
2. Adhere to [Cursor Rules](./cursor-rules.md) for code style
3. Write tests for all new features
4. Update documentation
5. Submit PR with clear description

---

## 📊 Statistics

### Package Metrics

- **Countries**: 245+
- **Flag Assets**: 245 PNG images (~2 MB)
- **Utility Methods**: 40+ helper functions
- **Widget Components**: 7 main widgets
- **Code Coverage**: 80%+ target
- **Dependencies**: 0 runtime dependencies

### Data Coverage

- ✅ ISO 3166-1 codes (alpha-2, alpha-3, numeric)
- ✅ Flag images (PNG format)
- ✅ Calling codes (phone codes)
- ✅ Capitals and largest cities
- ✅ Geographic regions and subregions
- ✅ Population and area data
- ✅ Currencies with symbols
- ✅ Languages with native names
- ✅ Timezones
- ✅ Border countries
- ✅ Independence and UN membership status
- ✅ Name translations (limited)

---

## 🎓 Learning Resources

### For Beginners

1. Start with the [Overview](./overview.md) to understand the package
2. Try the basic examples in [Examples Cookbook](./examples-cookbook.md)
3. Experiment with the example app
4. Gradually explore customization options

### For Intermediate Users

1. Explore advanced examples in [Examples Cookbook](./examples-cookbook.md)
2. Learn about customization in [Widgets Guide](./widgets-guide.md)
3. Study state management integration patterns
4. Build custom UI variations

### For Advanced Users

1. Read [Development Guide](./development-guide.md) for contribution
2. Understand architecture from [Overview](./overview.md)
3. Explore extending the package with new features
4. Optimize performance for specific use cases

---

## ❓ FAQ

### How do I show a country picker?

```dart
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
);
```

See: [API Reference - ModalCountryPicker](./api-reference.md#modalcountrypicker)

### How do I customize the theme?

Use `CountryPickerTheme.custom()` or one of the predefined themes.

See: [Widgets Guide - Theme Customization](./widgets-guide.md#theme-customization)

### How do I filter countries by region?

Use `CountryPickerConfig` with `includeRegions` parameter.

See: [Examples Cookbook - Advanced Filtering](./examples-cookbook.md#advanced-filtering)

### How do I implement phone number input?

Use `ModalComprehensivePicker` with `showPhoneCode: true`.

See: [Examples Cookbook - Phone Number Input](./examples-cookbook.md#phone-number-input)

### How do I access country data without showing a picker?

Use `CountryUtils` static methods.

See: [API Reference - CountryUtils](./api-reference.md#utilities)

### How do I add custom country item UI?

Use `customCountryBuilder` in `CountryPickerConfig`.

See: [Widgets Guide - Custom Builders](./widgets-guide.md#custom-builders)

### How do I handle multiple country selection?

Set `allowMultipleSelection: true` in config and manage selection state.

See: [Examples Cookbook - Common Patterns](./examples-cookbook.md#common-patterns)

### How do I integrate with form validation?

Wrap picker in form field and validate in form submission.

See: [Examples Cookbook - Form Integration](./examples-cookbook.md#form-integration)

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: Flag images not loading
- **Solution**: Ensure `package: 'countrify'` parameter is set in `Image.asset()`

**Issue**: Picker not showing
- **Solution**: Check that context is valid and mounted

**Issue**: Country not found by code
- **Solution**: Verify code is uppercase and valid (use `CountryUtils.isValidAlpha2Code()`)

**Issue**: Performance issues with large lists
- **Solution**: Enable pagination, use filters to limit data, or implement custom caching

**More help**: See [Development Guide - Troubleshooting](./development-guide.md#troubleshooting)

---

## 📞 Support

### Getting Help

1. **Documentation**: Check the relevant guide in this directory
2. **Examples**: Look for similar examples in [Examples Cookbook](./examples-cookbook.md)
3. **API Reference**: Verify you're using the correct API
4. **GitHub Issues**: Search existing issues
5. **Community**: Ask in Flutter forums

### Reporting Bugs

When reporting bugs, include:
- Flutter version (`flutter --version`)
- Countrify version
- Minimal reproduction code
- Expected vs actual behavior
- Error messages/stack traces

### Feature Requests

Feature requests are welcome! Please describe:
- Use case and motivation
- Proposed API/interface
- Examples of usage
- Impact on existing functionality

---

## 📝 License

MIT License - See LICENSE file for details

---

## 🙏 Acknowledgments

This package provides comprehensive country data and a beautiful UI for Flutter applications, making international app development easier and more consistent.

---

**Last Updated**: November 2024
**Package Version**: 1.0.0
**Documentation Version**: 1.0.0

---

