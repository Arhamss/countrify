# Countrify Development Guide

## Guide for Contributing to and Extending Countrify

---

## Table of Contents

1. [Development Setup](#development-setup)
2. [Project Structure](#project-structure)
3. [Code Style & Standards](#code-style--standards)
4. [Adding Features](#adding-features)
5. [Testing Guidelines](#testing-guidelines)
6. [Performance Considerations](#performance-considerations)
7. [Common Development Tasks](#common-development-tasks)
8. [Troubleshooting](#troubleshooting)

---

## Development Setup

### Prerequisites

```bash
# Required versions
Flutter SDK: >=3.0.0
Dart SDK: >=3.0.0

# Recommended IDE
- Visual Studio Code with Flutter extension
- OR Android Studio with Flutter plugin
```

### Initial Setup

```bash
# Clone the repository
git clone <repository-url>
cd countrify

# Get dependencies
flutter pub get

# Run code generation (if needed)
flutter pub run build_runner build

# Run tests to verify setup
flutter test

# Run example app
cd example
flutter run
```

### Development Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.4           # Mocking for tests
  very_good_analysis: ^9.0.0  # Strict linting
  flutter_lints: ^3.0.0       # Additional lints
  csv: ^6.0.0                 # For data parsing
```

---

## Project Structure

### Directory Layout

```
lib/
├── countrify.dart              # Main export file (PUBLIC API)
├── generated/
│   └── assets.dart             # Auto-generated asset paths
└── src/                        # Internal implementation
    ├── countrify.dart          # Core class
    ├── data/                   # Country data
    │   ├── all_countries.dart  # Data access layer
    │   ├── countries_data.dart # Generated data
    │   └── countries_data_extended.dart
    ├── models/                 # Data models
    │   └── country.dart
    ├── utils/                  # Utility functions
    │   └── country_utils.dart
    └── widgets/                # UI components
        ├── country_picker.dart
        ├── country_picker_config.dart
        ├── country_picker_theme.dart
        ├── comprehensive_country_picker.dart
        ├── modal_country_picker.dart
        ├── modal_comprehensive_picker.dart
        └── phone_code_picker.dart
```

### File Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `lowerCamelCase` or `SCREAMING_SNAKE_CASE` for compile-time constants
- **Private members**: Prefix with `_`

### Import Organization

```dart
// 1. Dart imports
import 'dart:async';
import 'dart:math';

// 2. Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Package imports
import 'package:mocktail/mocktail.dart';

// 4. Relative imports
import '../models/country.dart';
import 'country_utils.dart';
```

---

## Code Style & Standards

### Linting

The project uses `very_good_analysis` with additional custom rules:

```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml

linter:
  rules:
    # Add custom rules here
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
```

### Running Linter

```bash
# Analyze entire project
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Code Formatting

```bash
# Format all Dart files
dart format .

# Check formatting without applying
dart format --set-exit-if-changed .
```

### Documentation Standards

#### Class Documentation

```dart
/// {@template country_picker}
/// A widget that displays a list of countries for selection.
/// 
/// This picker supports:
/// - Search functionality
/// - Custom theming
/// - Filtering by region
/// - Multiple display modes
/// 
/// Example:
/// ```dart
/// CountryPicker(
///   onCountrySelected: (country) {
///     print(country.name);
///   },
/// )
/// ```
/// {@endtemplate}
class CountryPicker extends StatefulWidget {
  /// {@macro country_picker}
  const CountryPicker({
    super.key,
    this.onCountrySelected,
  });

  /// Callback invoked when a country is selected.
  final ValueChanged<Country>? onCountrySelected;
}
```

#### Method Documentation

```dart
/// Returns all countries in the specified [region].
///
/// The [region] parameter must be one of the valid region names
/// (e.g., "Europe", "Asia", "Africa").
///
/// Returns an empty list if the region is invalid or has no countries.
///
/// Example:
/// ```dart
/// final europeanCountries = CountryUtils.getCountriesByRegion('Europe');
/// ```
static List<Country> getCountriesByRegion(String region) {
  // Implementation
}
```

### Const Usage

Use `const` wherever possible:

```dart
// Good
const CountryPickerConfig(
  showDialCode: true,
  showFlag: true,
);

const theme = CountryPickerTheme(
  backgroundColor: Colors.white,
);

// Bad
CountryPickerConfig(
  showDialCode: true,
  showFlag: true,
);
```

### Null Safety

Always handle nulls properly:

```dart
// Good
final country = CountryUtils.getCountryByAlpha2Code('US');
if (country != null) {
  print(country.name);
}

// Or use null-aware operators
final name = CountryUtils.getCountryByAlpha2Code('US')?.name ?? 'Unknown';

// Bad
final country = CountryUtils.getCountryByAlpha2Code('US');
print(country.name); // Potential null error
```

---

## Adding Features

### Adding a New Utility Method

1. **Add method to CountryUtils**

```dart
// lib/src/utils/country_utils.dart

/// Returns countries that have a coast (not landlocked).
static List<Country> getCoastalCountries() {
  return getAllCountries().where((country) {
    // A landlocked country has only land borders
    // This is a simplified check
    return country.borders.length < 6; // Example logic
  }).toList();
}
```

2. **Add tests**

```dart
// test/src/countrify_test.dart

test('getCoastalCountries returns non-landlocked countries', () {
  final coastalCountries = CountryUtils.getCoastalCountries();
  
  expect(coastalCountries, isNotEmpty);
  expect(coastalCountries.length, greaterThan(0));
  
  // Verify known coastal country is included
  expect(
    coastalCountries.any((c) => c.alpha2Code == 'US'),
    isTrue,
  );
});
```

3. **Document in API reference**
4. **Add example usage**

### Adding a New Configuration Option

1. **Add to CountryPickerConfig**

```dart
// lib/src/widgets/country_picker_config.dart

class CountryPickerConfig {
  const CountryPickerConfig({
    // ... existing parameters
    this.showArea = false, // NEW
  });

  /// Whether to show country area in km².
  final bool showArea; // NEW

  CountryPickerConfig copyWith({
    // ... existing parameters
    bool? showArea, // NEW
  }) {
    return CountryPickerConfig(
      // ... existing assignments
      showArea: showArea ?? this.showArea, // NEW
    );
  }
}
```

2. **Update picker widgets to use config**

```dart
// lib/src/widgets/country_picker.dart

Widget _buildCountryItem(Country country) {
  return Column(
    children: [
      Text(country.name),
      if (widget.config?.showArea ?? false) // NEW
        Text('${CountryUtils.formatArea(country.area)} km²'),
    ],
  );
}
```

3. **Add tests**
4. **Update documentation**

### Adding a New Widget

1. **Create widget file**

```dart
// lib/src/widgets/region_picker.dart

import 'package:flutter/material.dart';
import '../utils/country_utils.dart';

/// {@template region_picker}
/// A widget that displays a list of regions for selection.
/// {@endtemplate}
class RegionPicker extends StatelessWidget {
  /// {@macro region_picker}
  const RegionPicker({
    super.key,
    required this.onRegionSelected,
  });

  /// Callback invoked when a region is selected.
  final ValueChanged<String> onRegionSelected;

  @override
  Widget build(BuildContext context) {
    final regions = CountryUtils.getAllRegions();
    
    return ListView.builder(
      itemCount: regions.length,
      itemBuilder: (context, index) {
        final region = regions[index];
        return ListTile(
          title: Text(region),
          onTap: () => onRegionSelected(region),
        );
      },
    );
  }
}
```

2. **Export from main library file**

```dart
// lib/countrify.dart

export 'src/widgets/region_picker.dart';
```

3. **Add tests**
4. **Add to documentation**
5. **Add example usage**

### Adding Country Data

If you need to add new country data or update existing data:

1. **Update CSV file**

```csv
# assets/country_data.csv
name,alpha2,alpha3,numeric,capital,region,...
```

2. **Run data parser**

```bash
dart tool/parse_csv.dart
```

3. **Verify generated code**

```dart
// lib/src/data/countries_data.dart
// Should be regenerated with new data
```

4. **Update tests to include new data**
5. **Increment package version**

---

## Testing Guidelines

### Test Structure

```
test/
├── src/
│   ├── countrify_test.dart        # Main tests
│   ├── models/
│   │   └── country_test.dart      # Model tests
│   ├── utils/
│   │   └── country_utils_test.dart # Utility tests
│   └── widgets/
│       ├── country_picker_test.dart
│       └── modal_country_picker_test.dart
```

### Writing Unit Tests

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:countrify/countrify.dart';

void main() {
  group('CountryUtils', () {
    test('getAllCountries returns non-empty list', () {
      final countries = CountryUtils.getAllCountries();
      expect(countries, isNotEmpty);
      expect(countries.length, greaterThan(200));
    });

    test('getCountryByAlpha2Code returns correct country', () {
      final usa = CountryUtils.getCountryByAlpha2Code('US');
      expect(usa, isNotNull);
      expect(usa?.name, 'United States');
      expect(usa?.alpha3Code, 'USA');
      expect(usa?.numericCode, '840');
    });

    test('getCountryByAlpha2Code returns null for invalid code', () {
      final invalid = CountryUtils.getCountryByAlpha2Code('XX');
      expect(invalid, isNull);
    });

    test('searchCountries finds countries by name', () {
      final results = CountryUtils.searchCountries('united');
      expect(results, isNotEmpty);
      expect(
        results.any((c) => c.name.toLowerCase().contains('united')),
        isTrue,
      );
    });
  });

  group('Country', () {
    test('equality works correctly', () {
      final country1 = CountryUtils.getCountryByAlpha2Code('US');
      final country2 = CountryUtils.getCountryByAlpha2Code('US');
      final country3 = CountryUtils.getCountryByAlpha2Code('CA');

      expect(country1, equals(country2));
      expect(country1, isNot(equals(country3)));
    });

    test('copyWith works correctly', () {
      final original = CountryUtils.getCountryByAlpha2Code('US')!;
      final copy = original.copyWith(name: 'Test Name');

      expect(copy.name, 'Test Name');
      expect(copy.alpha2Code, original.alpha2Code);
      expect(copy.capital, original.capital);
    });
  });
}
```

### Writing Widget Tests

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:countrify/countrify.dart';

void main() {
  group('CountryPicker', () {
    testWidgets('displays list of countries', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryPicker(
              onCountrySelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('United States'), findsOneWidget);
    });

    testWidgets('calls onCountrySelected when tapped', (tester) async {
      Country? selectedCountry;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryPicker(
              onCountrySelected: (country) {
                selectedCountry = country;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('United States'));
      await tester.pump();

      expect(selectedCountry, isNotNull);
      expect(selectedCountry?.alpha2Code, 'US');
    });

    testWidgets('shows search bar when enabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryPicker(
              onCountrySelected: (_) {},
              config: const CountryPickerConfig(
                enableSearch: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('filters countries when searching', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountryPicker(
              onCountrySelected: (_) {},
              config: const CountryPickerConfig(
                enableSearch: true,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Canada');
      await tester.pumpAndSettle();

      expect(find.text('Canada'), findsOneWidget);
      expect(find.text('United States'), findsNothing);
    });
  });
}
```

### Mocking with Mocktail

```dart
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCountryService extends Mock implements CountryService {}

void main() {
  group('CountryService', () {
    late MockCountryService mockService;

    setUp(() {
      mockService = MockCountryService();
    });

    test('fetches country successfully', () async {
      final expectedCountry = CountryUtils.getCountryByAlpha2Code('US')!;
      
      when(() => mockService.fetchCountry('US'))
          .thenAnswer((_) async => expectedCountry);

      final result = await mockService.fetchCountry('US');

      expect(result, expectedCountry);
      verify(() => mockService.fetchCountry('US')).called(1);
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/src/countrify_test.dart

# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Coverage Goals

- **Minimum**: 80% code coverage
- **Target**: 90%+ code coverage
- **Critical paths**: 100% coverage

---

## Performance Considerations

### Memory Management

1. **Use const constructors**

```dart
// Good
const Country(...);
const CountryPickerConfig(...);

// Bad
Country(...); // Non-const when it could be
```

2. **Dispose controllers**

```dart
@override
void dispose() {
  _searchController.dispose();
  _scrollController.dispose();
  super.dispose();
}
```

3. **Avoid unnecessary rebuilds**

```dart
// Use const where possible
const Text('Hello');

// Use keys for list items
ListView.builder(
  itemBuilder: (context, index) {
    return CountryItem(
      key: ValueKey(countries[index].alpha2Code),
      country: countries[index],
    );
  },
);
```

### Widget Performance

1. **Use ListView.builder** for long lists
2. **Implement caching** for expensive operations
3. **Debounce search** to avoid excessive rebuilds
4. **Limit data** with filters when possible

```dart
// Good - uses builder
ListView.builder(
  itemCount: countries.length,
  itemBuilder: (context, index) {
    return CountryItem(country: countries[index]);
  },
);

// Bad - creates all widgets at once
ListView(
  children: countries.map((c) => CountryItem(country: c)).toList(),
);
```

### Data Access Performance

```dart
// Cache frequently accessed data
class _MyWidgetState extends State<MyWidget> {
  late final List<Country> _allCountries;
  late final Map<String, Country> _countryByCode;

  @override
  void initState() {
    super.initState();
    _allCountries = CountryUtils.getAllCountries();
    _countryByCode = {
      for (final country in _allCountries)
        country.alpha2Code: country,
    };
  }

  Country? getCountry(String code) {
    return _countryByCode[code]; // O(1) lookup
  }
}
```

### Asset Loading

Flag images are bundled, so they load instantly:

```dart
// Efficient - loads from bundled assets
Image.asset(
  country.flagImagePath,
  package: 'countrify',
  width: 32,
  height: 24,
);
```

---

## Common Development Tasks

### Updating Country Data

1. Edit `assets/country_data.csv`
2. Run `dart tool/parse_csv.dart`
3. Verify generated files
4. Run tests
5. Update CHANGELOG.md
6. Commit changes

### Adding New Flag

1. Add PNG file to `assets/images/flags/{ALPHA2_CODE}.png`
2. Ensure size is consistent (32x24 recommended)
3. Update country data if needed
4. Test flag displays correctly
5. Commit with descriptive message

### Updating Dependencies

```bash
# Check for outdated packages
flutter pub outdated

# Update to latest compatible versions
flutter pub upgrade

# Update to latest major versions (carefully!)
flutter pub upgrade --major-versions

# Verify nothing broke
flutter test
```

### Publishing New Version

1. **Update version in pubspec.yaml**

```yaml
version: 1.1.0 # Increment appropriately
```

2. **Update CHANGELOG.md**

```markdown
## [1.1.0] - 2024-01-15

### Added
- New feature X
- New utility method Y

### Changed
- Improved performance of Z

### Fixed
- Fixed bug in A
```

3. **Run checks**

```bash
flutter analyze
flutter test
dart pub publish --dry-run
```

4. **Publish**

```bash
dart pub publish
```

5. **Tag release**

```bash
git tag v1.1.0
git push origin v1.1.0
```

---

## Troubleshooting

### Common Issues

#### Issue: Asset not found

```
Error: Unable to load asset: packages/countrify/assets/images/flags/XX.png
```

**Solution**: 
- Verify flag file exists
- Check file name matches alpha-2 code
- Ensure assets are declared in pubspec.yaml
- Run `flutter clean` and `flutter pub get`

#### Issue: Linter errors

```
error • Prefer const constructors • prefer_const_constructors
```

**Solution**:
```bash
# Auto-fix
dart fix --apply

# Or fix manually by adding const
const CountryPickerConfig(...)
```

#### Issue: Test failures after data update

**Solution**:
- Update test expectations
- Verify data format is correct
- Check for breaking changes in data structure

#### Issue: Performance degradation

**Solution**:
- Profile with Flutter DevTools
- Check for unnecessary rebuilds
- Verify using ListView.builder
- Add keys to list items
- Implement caching

### Debugging Tips

1. **Use Flutter DevTools**

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

2. **Enable debug prints**

```dart
debugPrint('Selected country: ${country.name}');
```

3. **Use assert statements**

```dart
assert(country.alpha2Code.length == 2, 'Invalid alpha-2 code');
```

4. **Check widget tree**

```dart
debugDumpApp(); // Dump widget tree
debugDumpRenderTree(); // Dump render tree
```

### Getting Help

1. Check existing GitHub issues
2. Review documentation
3. Search pub.dev comments
4. Ask in Flutter community forums
5. Create detailed GitHub issue with:
   - Flutter version
   - Countrify version
   - Minimal reproduction code
   - Expected vs actual behavior
   - Error messages/stack traces

---

## Best Practices Summary

### DO

✅ Use const constructors everywhere possible
✅ Write tests for all new features
✅ Document all public APIs
✅ Follow existing code style
✅ Handle null values properly
✅ Dispose controllers and resources
✅ Use meaningful variable names
✅ Keep functions focused and small
✅ Add examples for complex features
✅ Run linter before committing

### DON'T

❌ Expose internal implementation details
❌ Break backward compatibility without major version bump
❌ Add dependencies unless absolutely necessary
❌ Commit without running tests
❌ Ignore linter warnings
❌ Create memory leaks
❌ Use dynamic types unnecessarily
❌ Write overly complex code
❌ Skip documentation
❌ Hardcode values that should be configurable

---

## Version Control

### Commit Messages

Follow conventional commits:

```
feat: Add region picker widget
fix: Correct population formatting
docs: Update API reference
test: Add tests for CountryUtils
refactor: Simplify search logic
perf: Optimize country list rendering
style: Format code with dart format
chore: Update dependencies
```

### Branch Naming

```
feature/add-region-picker
fix/population-formatting
docs/update-readme
refactor/simplify-search
```

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added
- [ ] Example app tested

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped (if needed)
```

---

