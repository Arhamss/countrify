# Cursor AI Rules for Countrify Package

## Instructions for AI-Assisted Development

This file contains specific rules and guidelines that Cursor AI should follow when working with the Countrify Flutter package.

---

## Code Generation Rules

### 1. Import Organization

Always organize imports in this order:

```dart
// 1. Dart core imports
import 'dart:async';

// 2. Flutter framework imports
import 'package:flutter/material.dart';

// 3. Third-party package imports
import 'package:mocktail/mocktail.dart';

// 4. Internal package imports (from countrify)
import 'package:countrify/countrify.dart';

// 5. Relative imports (within same package)
import '../models/country.dart';
import 'country_utils.dart';
```

### 2. Class Structure

Follow this structure for all classes:

```dart
/// {@template class_name}
/// Brief description of the class.
/// 
/// More detailed description if needed.
/// {@endtemplate}
class ClassName {
  /// {@macro class_name}
  const ClassName({
    required this.property1,
    this.property2,
  });

  // 1. Constants
  static const defaultValue = 42;

  // 2. Final properties (required first, optional second)
  final String property1;
  final int? property2;

  // 3. Methods (public first, private after)
  void publicMethod() {}
  void _privateMethod() {}

  // 4. Overrides
  @override
  bool operator ==(Object other) {}
  
  @override
  int get hashCode => property1.hashCode;
  
  @override
  String toString() => 'ClassName(property1: $property1)';
}
```

### 3. Widget Structure

For StatelessWidget:

```dart
/// {@template widget_name}
/// Widget description.
/// {@endtemplate}
class WidgetName extends StatelessWidget {
  /// {@macro widget_name}
  const WidgetName({
    super.key,
    required this.property,
  });

  final String property;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

For StatefulWidget:

```dart
/// {@template widget_name}
/// Widget description.
/// {@endtemplate}
class WidgetName extends StatefulWidget {
  /// {@macro widget_name}
  const WidgetName({
    super.key,
    this.onChanged,
  });

  final ValueChanged<String>? onChanged;

  @override
  State<WidgetName> createState() => _WidgetNameState();
}

class _WidgetNameState extends State<WidgetName> {
  // 1. State variables
  String _value = '';
  
  // 2. Controllers
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 3. Methods
  void _handleChange() {
    widget.onChanged?.call(_value);
  }

  // 4. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### 4. Documentation Standards

Every public class, method, and property MUST have documentation:

```dart
/// Brief one-line description.
///
/// Optional longer description with multiple paragraphs.
///
/// Example:
/// ```dart
/// final result = methodName('param');
/// print(result); // Output
/// ```
///
/// See also:
/// * [RelatedClass] for related functionality
void methodName(String param) {}
```

### 5. Const Usage

ALWAYS use `const` when possible:

```dart
// ✅ CORRECT
const Text('Hello');
const EdgeInsets.all(16);
const CountryPickerConfig(showFlag: true);

// ❌ WRONG
Text('Hello');
EdgeInsets.all(16);
CountryPickerConfig(showFlag: true);
```

### 6. Null Safety

Handle nulls explicitly and correctly:

```dart
// ✅ CORRECT - Check before use
final country = CountryUtils.getCountryByAlpha2Code('US');
if (country != null) {
  print(country.name);
}

// ✅ CORRECT - Use null-aware operators
final name = CountryUtils.getCountryByAlpha2Code('US')?.name ?? 'Unknown';

// ❌ WRONG - Potential null error
final country = CountryUtils.getCountryByAlpha2Code('US');
print(country.name); // Might be null!

// ❌ WRONG - Unnecessary null check
final country = CountryUtils.getCountryByAlpha2Code('US');
if (country != null) {
  print(country!.name); // Already checked, ! is redundant
}
```

---

## API Design Rules

### 1. Method Naming

- Use descriptive verb-based names
- Use `get` prefix for retrieval methods
- Use `is`/`has` prefix for boolean checks
- Use `calculate`/`compute` for computation methods

```dart
// ✅ CORRECT
static Country? getCountryByAlpha2Code(String code) {}
static bool isValidAlpha2Code(String code) {}
static double calculateShippingCost(Country country) {}

// ❌ WRONG
static Country? countryByCode(String code) {}
static bool validCode(String code) {}
static double shipping(Country country) {}
```

### 2. Parameter Ordering

Required parameters first, optional after:

```dart
// ✅ CORRECT
void method({
  required String required1,
  required int required2,
  String? optional1,
  int? optional2,
}) {}

// ❌ WRONG
void method({
  String? optional1,
  required String required1,
  int? optional2,
  required int required2,
}) {}
```

### 3. Return Types

Always specify explicit return types:

```dart
// ✅ CORRECT
Future<Country?> selectCountry() async {}
List<Country> filterCountries() {}
void updateSelection() {}

// ❌ WRONG
selectCountry() async {} // No return type
filterCountries() {} // No return type
```

### 4. Configuration Classes

Use copyWith pattern for configuration classes:

```dart
class Config {
  const Config({
    this.property1,
    this.property2,
  });

  final String? property1;
  final int? property2;

  Config copyWith({
    String? property1,
    int? property2,
  }) {
    return Config(
      property1: property1 ?? this.property1,
      property2: property2 ?? this.property2,
    );
  }
}
```

---

## Testing Rules

### 1. Test File Structure

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:countrify/countrify.dart';

void main() {
  group('ClassName', () {
    group('methodName', () {
      test('should do expected behavior', () {
        // Arrange
        final input = 'test';
        
        // Act
        final result = method(input);
        
        // Assert
        expect(result, expectedValue);
      });

      test('should handle edge case', () {
        // Test edge case
      });

      test('should throw error on invalid input', () {
        expect(() => method(null), throwsException);
      });
    });
  });
}
```

### 2. Widget Testing

```dart
testWidgets('widget should display correctly', (tester) async {
  // Build widget
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: YourWidget(),
      ),
    ),
  );

  // Verify
  expect(find.text('Expected Text'), findsOneWidget);
  expect(find.byType(Container), findsWidgets);
});

testWidgets('widget should handle interaction', (tester) async {
  var callbackCalled = false;
  
  await tester.pumpWidget(
    MaterialApp(
      home: YourWidget(
        onTap: () {
          callbackCalled = true;
        },
      ),
    ),
  );

  // Interact
  await tester.tap(find.byType(InkWell));
  await tester.pump();

  // Verify
  expect(callbackCalled, isTrue);
});
```

### 3. Test Coverage Requirements

- All public methods: 100% coverage
- All widgets: 90%+ coverage
- Edge cases: Must be tested
- Error cases: Must be tested

---

## Performance Rules

### 1. List Rendering

ALWAYS use builder pattern for long lists:

```dart
// ✅ CORRECT
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(item: items[index]);
  },
)

// ❌ WRONG - Creates all widgets at once
ListView(
  children: items.map((item) => ItemWidget(item: item)).toList(),
)
```

### 2. Const Constructors

Use const constructors whenever possible:

```dart
// ✅ CORRECT
class MyClass {
  const MyClass({
    required this.value,
  });

  final String value;
}

// Only use non-const when necessary (e.g., mutable state)
class MutableClass {
  MutableClass({
    required this.value,
  });

  String value; // Mutable
}
```

### 3. Resource Management

Always dispose of resources:

```dart
class _WidgetState extends State<Widget> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // MUST dispose in reverse order of creation
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### 4. Caching

Cache expensive computations:

```dart
class _WidgetState extends State<Widget> {
  List<Country>? _cachedCountries;

  List<Country> get countries {
    // Cache the result
    return _cachedCountries ??= CountryUtils.getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    // Use cached value
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return Text(countries[index].name);
      },
    );
  }
}
```

---

## Package-Specific Rules

### 1. CountryUtils Usage

Always use CountryUtils static methods for country operations:

```dart
// ✅ CORRECT
final countries = CountryUtils.getAllCountries();
final usa = CountryUtils.getCountryByAlpha2Code('US');
final european = CountryUtils.getCountriesByRegion('Europe');

// ❌ WRONG - Don't access data directly
final countries = AllCountries.all; // Internal implementation
```

### 2. Modal Picker Pattern

Use static factory methods for modal pickers:

```dart
// ✅ CORRECT
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  initialCountry: selected,
);

// ❌ WRONG - Don't instantiate directly
showModalBottomSheet(
  context: context,
  builder: (context) => ModalCountryPicker(...), // Wrong pattern
);
```

### 3. Configuration Pattern

Always provide default configurations:

```dart
// ✅ CORRECT
Future<Country?> showPicker({
  required BuildContext context,
  CountryPickerTheme? theme,
  CountryPickerConfig? config,
}) async {
  final effectiveTheme = theme ?? CountryPickerTheme.defaultTheme();
  final effectiveConfig = config ?? const CountryPickerConfig();
  // Use effectiveTheme and effectiveConfig
}

// ❌ WRONG - No defaults
Future<Country?> showPicker({
  required CountryPickerTheme theme, // Should be optional
  required CountryPickerConfig config, // Should be optional
}) async {}
```

### 4. Flag Asset Access

Always use the package parameter when loading flags:

```dart
// ✅ CORRECT
Image.asset(
  country.flagImagePath,
  package: 'countrify',
  width: 32,
  height: 24,
)

// ❌ WRONG - Missing package parameter
Image.asset(
  country.flagImagePath,
  width: 32,
  height: 24,
)
```

### 5. Theme Customization

Use factory methods or copyWith for theme customization:

```dart
// ✅ CORRECT - Use factory
final theme = CountryPickerTheme.custom(
  primaryColor: Colors.blue,
  isDark: false,
);

// ✅ CORRECT - Use copyWith
final customTheme = CountryPickerTheme.defaultTheme().copyWith(
  backgroundColor: Colors.white,
  headerColor: Colors.blue[50],
);

// ❌ WRONG - Manual construction without defaults
final theme = CountryPickerTheme(
  backgroundColor: Colors.white,
  // Missing many other properties
);
```

---

## Error Handling Rules

### 1. Null Checks

Always check for null before using:

```dart
// ✅ CORRECT
final country = CountryUtils.getCountryByAlpha2Code('US');
if (country != null) {
  print(country.name);
} else {
  print('Country not found');
}

// ❌ WRONG
final country = CountryUtils.getCountryByAlpha2Code('US');
print(country.name); // Null pointer exception!
```

### 2. User Feedback

Always provide feedback for async operations:

```dart
// ✅ CORRECT
Future<void> selectCountry() async {
  final country = await ModalCountryPicker.showBottomSheet(
    context: context,
  );
  
  if (country != null) {
    setState(() {
      selectedCountry = country;
    });
    
    // Show feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: ${country.name}')),
      );
    }
  }
}

// ❌ WRONG - No feedback
Future<void> selectCountry() async {
  final country = await ModalCountryPicker.showBottomSheet(
    context: context,
  );
  
  if (country != null) {
    setState(() {
      selectedCountry = country;
    });
  }
  // User doesn't know if selection worked
}
```

### 3. Validation

Validate input before processing:

```dart
// ✅ CORRECT
static Country? getCountryByAlpha2Code(String code) {
  if (code.length != 2) {
    return null; // Invalid code format
  }
  
  return _countryMap[code.toUpperCase()];
}

// ❌ WRONG - No validation
static Country? getCountryByAlpha2Code(String code) {
  return _countryMap[code]; // Might fail with lowercase or invalid length
}
```

---

## Accessibility Rules

### 1. Semantic Labels

Provide semantic labels for all interactive widgets:

```dart
// ✅ CORRECT
IconButton(
  icon: const Icon(Icons.search),
  tooltip: 'Search countries',
  onPressed: () {},
)

// ❌ WRONG - No tooltip
IconButton(
  icon: const Icon(Icons.search),
  onPressed: () {},
)
```

### 2. Contrast

Ensure sufficient contrast for text and interactive elements:

```dart
// ✅ CORRECT
Text(
  'Country Name',
  style: TextStyle(
    color: Colors.black87, // Good contrast on white
  ),
)

// ❌ WRONG - Poor contrast
Text(
  'Country Name',
  style: TextStyle(
    color: Colors.grey[300], // Poor contrast on white
  ),
)
```

---

## Version Control Rules

### 1. Commit Messages

Use conventional commit format:

```
feat: Add region filter to country picker
fix: Correct population formatting for large numbers
docs: Update API reference with new methods
test: Add tests for CountryUtils search methods
refactor: Simplify country filtering logic
perf: Optimize list rendering with keys
style: Format code according to style guide
chore: Update dependencies to latest versions
```

### 2. Breaking Changes

Document breaking changes clearly:

```dart
/// Returns country by code.
///
/// **Breaking Change (v2.0.0)**: Now returns null instead of throwing
/// exception when country is not found.
///
/// Before:
/// ```dart
/// try {
///   final country = getCountry('US');
/// } catch (e) {
///   // Handle error
/// }
/// ```
///
/// Now:
/// ```dart
/// final country = getCountry('US');
/// if (country != null) {
///   // Use country
/// }
/// ```
static Country? getCountryByAlpha2Code(String code) {}
```

---

## Code Review Checklist

Before submitting code, verify:

- [ ] All public APIs are documented
- [ ] All tests pass (`flutter test`)
- [ ] Code is formatted (`dart format .`)
- [ ] No linter warnings (`flutter analyze`)
- [ ] Used const where possible
- [ ] Null safety handled correctly
- [ ] Resources disposed properly
- [ ] Performance optimized (builders, keys, caching)
- [ ] Accessibility considered
- [ ] Examples provided for complex features
- [ ] CHANGELOG.md updated (if public API changed)
- [ ] Version bumped (if necessary)

---

## Quick Reference

### Common Patterns

**Get country by code:**
```dart
final country = CountryUtils.getCountryByAlpha2Code('US');
```

**Show picker:**
```dart
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
);
```

**Search countries:**
```dart
final results = CountryUtils.searchCountries('united');
```

**Filter by region:**
```dart
final european = CountryUtils.getCountriesByRegion('Europe');
```

**Custom theme:**
```dart
final theme = CountryPickerTheme.custom(
  primaryColor: Colors.blue,
  isDark: false,
);
```

**Custom config:**
```dart
const config = CountryPickerConfig(
  showDialCode: true,
  showCapital: true,
  enableSearch: true,
);
```

---

## When in Doubt

1. Check existing code for similar patterns
2. Refer to the API reference
3. Look at example implementations
4. Follow Flutter/Dart best practices
5. Prioritize user experience and performance
6. Write tests to verify behavior
7. Document your changes

---

## Summary

**Key Principles:**
1. **Const everywhere possible**
2. **Null safety first**
3. **Document all public APIs**
4. **Test everything**
5. **Optimize for performance**
6. **Dispose resources**
7. **Provide defaults**
8. **User feedback**
9. **Accessibility**
10. **Follow conventions**

---

