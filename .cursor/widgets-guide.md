# Countrify Widgets Guide

## Comprehensive Guide to Using Countrify Widgets

---

## Table of Contents

1. [Widget Architecture](#widget-architecture)
2. [Modal Pickers](#modal-pickers)
3. [Base Widgets](#base-widgets)
4. [Customization Patterns](#customization-patterns)
5. [State Management](#state-management)
6. [Performance Optimization](#performance-optimization)
7. [Common Patterns](#common-patterns)

---

## Widget Architecture

### Widget Hierarchy

```
┌─────────────────────────────────────┐
│    Modal Pickers (Entry Points)     │
│  ModalCountryPicker                 │
│  ModalComprehensivePicker           │
└──────────────┬──────────────────────┘
               │
               │ Wraps & Shows
               │
┌──────────────▼──────────────────────┐
│    Base Picker Widgets              │
│  CountryPicker                      │
│  ComprehensiveCountryPicker         │
│  PhoneCodePicker                    │
└──────────────┬──────────────────────┘
               │
               │ Uses
               │
┌──────────────▼──────────────────────┐
│    Internal Components              │
│  - Search Bar                       │
│  - Filter Panel                     │
│  - Country List                     │
│  - Country Item                     │
│  - Flag Widget                      │
│  - Empty State                      │
└─────────────────────────────────────┘
```

### Design Principles

1. **Separation of Concerns**
   - Modal wrappers handle presentation logic
   - Base widgets handle picker logic
   - Internal components handle UI details

2. **Composition Over Inheritance**
   - Widgets composed of smaller components
   - Easy to customize individual parts
   - Flexible configuration

3. **Reusability**
   - Base widgets can be used standalone
   - Components can be extracted and customized
   - Modals wrap any base widget

---

## Modal Pickers

### Purpose
Modal pickers are convenience methods that:
- Handle navigation/routing
- Provide appropriate context (bottom sheet, dialog, full screen)
- Return selected country
- Manage dismiss behavior

### When to Use Modal Pickers

✅ **Use Modal Pickers When:**
- You need a temporary selection UI
- You want standard presentation modes
- You need Future-based result handling
- You want built-in dismiss behavior

❌ **Don't Use Modal Pickers When:**
- Embedding picker in existing UI
- Need custom navigation
- Building multi-step flows
- Need persistent picker

### ModalCountryPicker

#### Bottom Sheet Example

```dart
// Basic usage
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
);

// With configuration
final country = await ModalCountryPicker.showBottomSheet(
  context: context,
  initialCountry: CountryUtils.getCountryByAlpha2Code('US'),
  title: 'Select Your Country',
  theme: CountryPickerTheme.defaultTheme(),
  config: const CountryPickerConfig(
    showDialCode: true,
    showCapital: true,
    enableSearch: true,
  ),
  isDismissible: true,
  enableDrag: true,
  barrierColor: Colors.black54,
);

// Handle result
if (country != null) {
  setState(() {
    selectedCountry = country;
  });
}
```

#### Dialog Example

```dart
final country = await ModalCountryPicker.showDialogPicker(
  context: context,
  initialCountry: selectedCountry,
  title: 'Choose Country',
  theme: CountryPickerTheme.material3Theme(),
  barrierDismissible: true,
  barrierColor: Colors.black45,
);
```

#### Full Screen Example

```dart
final country = await ModalCountryPicker.showFullScreen(
  context: context,
  initialCountry: selectedCountry,
  title: 'Select Country',
  showAppBar: true,
  theme: CountryPickerTheme.darkTheme(),
);
```

### ModalComprehensivePicker

Enhanced picker with phone codes and advanced features.

```dart
// Phone code picker
final country = await ModalComprehensivePicker.showBottomSheet(
  context: context,
  showPhoneCode: true,
  searchEnabled: true,
  searchHint: 'Search country or code...',
  theme: CountryPickerTheme.defaultTheme(),
  config: const CountryPickerConfig(
    showDialCode: true,
    showFlag: true,
    showCapital: true,
    flagShape: FlagShape.circular,
  ),
);

// Access phone code
if (country != null && country.callingCodes.isNotEmpty) {
  final phoneCode = country.callingCodes.first;
  print('Selected code: $phoneCode');
}
```

### Custom Modal Implementation

If you need custom modal behavior:

```dart
Future<Country?> showCustomCountryPicker(BuildContext context) async {
  return await showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Custom header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Country', style: TextStyle(fontSize: 20)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Embedded picker
          Expanded(
            child: CountryPicker(
              onCountrySelected: (country) {
                Navigator.pop(context, country);
              },
              theme: CountryPickerTheme.defaultTheme(),
              config: const CountryPickerConfig(
                showDialCode: true,
                showFlag: true,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
```

---

## Base Widgets

### Purpose
Base widgets are the actual picker implementations that can be:
- Embedded in any UI
- Customized extensively
- Controlled programmatically
- Used in complex layouts

### When to Use Base Widgets

✅ **Use Base Widgets When:**
- Embedding in existing screen
- Building custom navigation flows
- Need fine-grained control
- Creating complex UIs
- Need to observe state changes

### CountryPicker

Basic country picker that can be embedded anywhere.

#### Basic Embedding

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Country')),
      body: Column(
        children: [
          // Selected country display
          if (selectedCountry != null)
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Selected: ${selectedCountry!.name}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          
          // Embedded picker
          Expanded(
            child: CountryPicker(
              onCountrySelected: (country) {
                setState(() {
                  selectedCountry = country;
                });
              },
              initialCountry: selectedCountry,
              theme: CountryPickerTheme.defaultTheme(),
              config: const CountryPickerConfig(
                showDialCode: true,
                showCapital: true,
                showFlag: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

#### With Controllers

```dart
class ControlledPickerScreen extends StatefulWidget {
  @override
  State<ControlledPickerScreen> createState() => _ControlledPickerScreenState();
}

class _ControlledPickerScreenState extends State<ControlledPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Country? selectedCountry;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controlled Picker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearSearch,
            tooltip: 'Clear search',
          ),
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: _scrollToTop,
            tooltip: 'Scroll to top',
          ),
        ],
      ),
      body: CountryPicker(
        onCountrySelected: (country) {
          setState(() {
            selectedCountry = country;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected: ${country.name}')),
          );
        },
        initialCountry: selectedCountry,
        searchController: _searchController,
        scrollController: _scrollController,
        theme: CountryPickerTheme.defaultTheme(),
        config: const CountryPickerConfig(
          showDialCode: true,
          enableSearch: true,
          enableScrollbar: true,
        ),
      ),
    );
  }
}
```

### ComprehensiveCountryPicker

Advanced picker with extended features.

```dart
class ComprehensivePickerScreen extends StatefulWidget {
  @override
  State<ComprehensivePickerScreen> createState() => _ComprehensivePickerScreenState();
}

class _ComprehensivePickerScreenState extends State<ComprehensivePickerScreen> {
  Country? selectedCountry;
  String searchQuery = '';
  CountryFilter filter = const CountryFilter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprehensive Picker'),
      ),
      body: Column(
        children: [
          // Info bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedCountry != null
                        ? '${selectedCountry!.name} (${selectedCountry!.callingCodes.first})'
                        : 'No country selected',
                  ),
                ),
                if (searchQuery.isNotEmpty)
                  Chip(
                    label: Text('Search: "$searchQuery"'),
                    onDeleted: () {
                      setState(() {
                        searchQuery = '';
                      });
                    },
                  ),
              ],
            ),
          ),
          
          // Picker
          Expanded(
            child: ComprehensiveCountryPicker(
              onCountrySelected: (country) {
                setState(() {
                  selectedCountry = country;
                });
              },
              initialCountry: selectedCountry,
              showPhoneCode: true,
              searchEnabled: true,
              searchHint: 'Search country or code...',
              onSearchChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              onFilterChanged: (newFilter) {
                setState(() {
                  filter = newFilter;
                });
              },
              theme: CountryPickerTheme.defaultTheme(),
              config: const CountryPickerConfig(
                showDialCode: true,
                showCapital: true,
                showFlag: true,
                enableFilter: true,
                flagShape: FlagShape.circular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### PhoneCodePicker

Specialized picker for phone codes.

```dart
class PhoneInputScreen extends StatefulWidget {
  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  Country? selectedCountry;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Default to user's country (example: US)
    selectedCountry = CountryUtils.getCountryByAlpha2Code('US');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String get fullPhoneNumber {
    if (selectedCountry == null || _phoneController.text.isEmpty) {
      return '';
    }
    return '${selectedCountry!.callingCodes.first} ${_phoneController.text}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Phone Number')),
      body: Column(
        children: [
          // Phone input
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Country code picker
                InkWell(
                  onTap: () async {
                    final country = await ModalComprehensivePicker.showBottomSheet(
                      context: context,
                      initialCountry: selectedCountry,
                      showPhoneCode: true,
                      searchEnabled: true,
                    );
                    if (country != null) {
                      setState(() {
                        selectedCountry = country;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selectedCountry != null) ...[
                          Image.asset(
                            selectedCountry!.flagImagePath,
                            width: 24,
                            height: 18,
                            package: 'countrify',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedCountry!.callingCodes.first,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Phone number input
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Full number display
          if (fullPhoneNumber.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Full number: $fullPhoneNumber',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          
          // Submit button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: fullPhoneNumber.isNotEmpty
                  ? () {
                      // Submit phone number
                      print('Submitting: $fullPhoneNumber');
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Customization Patterns

### Theme Customization

#### Creating Custom Theme

```dart
// Simple custom theme
final theme = CountryPickerTheme.custom(
  primaryColor: Colors.purple,
  backgroundColor: Colors.white,
  isDark: false,
);

// Fully custom theme
final customTheme = CountryPickerTheme(
  backgroundColor: Colors.white,
  headerColor: Colors.purple[50],
  headerTextStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  ),
  searchBarColor: Colors.grey[100],
  searchBarBorderColor: Colors.purple,
  countryItemSelectedColor: Colors.purple[50],
  countryItemSelectedBorderColor: Colors.purple,
  flagBorderRadius: BorderRadius.circular(8),
);
```

#### Adaptive Theme

```dart
CountryPickerTheme getAdaptiveTheme(BuildContext context) {
  final brightness = Theme.of(context).brightness;
  final isDark = brightness == Brightness.dark;
  
  if (isDark) {
    return CountryPickerTheme.darkTheme();
  } else {
    return CountryPickerTheme.defaultTheme();
  }
}

// Usage
await ModalCountryPicker.showBottomSheet(
  context: context,
  theme: getAdaptiveTheme(context),
);
```

#### Brand Theme

```dart
class BrandTheme {
  static const primaryColor = Color(0xFF6C5CE7);
  static const secondaryColor = Color(0xFFA29BFE);
  
  static CountryPickerTheme getPickerTheme() {
    return CountryPickerTheme.custom(
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      isDark: false,
    ).copyWith(
      headerTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        letterSpacing: 0.5,
      ),
      countryItemBorderRadius: BorderRadius.circular(12),
    );
  }
}
```

### Config Customization

#### Regional Picker

```dart
const europeanConfig = CountryPickerConfig(
  includeRegions: ['Europe'],
  showDialCode: true,
  showCapital: true,
  sortBy: CountrySortBy.name,
);

const asianConfig = CountryPickerConfig(
  includeRegions: ['Asia'],
  showDialCode: true,
  showPopulation: true,
  sortBy: CountrySortBy.population,
);
```

#### Feature-Specific Configs

```dart
// Minimal config (name and flag only)
const minimalConfig = CountryPickerConfig(
  showFlag: true,
  showCountryName: true,
  showDialCode: false,
  showCapital: false,
  enableSearch: false,
);

// Detailed config (all information)
const detailedConfig = CountryPickerConfig(
  showFlag: true,
  showCountryName: true,
  showDialCode: true,
  showCapital: true,
  showRegion: true,
  showPopulation: true,
  enableSearch: true,
  enableFilter: true,
);

// Performance config (optimized)
const performanceConfig = CountryPickerConfig(
  showFlag: true,
  showCountryName: true,
  enableSearch: true,
  enableScrollbar: true,
  enableHapticFeedback: false,
  searchDebounceMs: 500,
  itemsPerPage: 30,
);
```

### Custom Builders

#### Custom Country Item

```dart
final config = CountryPickerConfig(
  customCountryBuilder: (context, country, isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[50] : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Flag
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              country.flagImagePath,
              width: 40,
              height: 30,
              package: 'countrify',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          
          // Country info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (country.callingCodes.isNotEmpty)
                  Text(
                    country.callingCodes.first,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          
          // Selected indicator
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.blue,
            ),
        ],
      ),
    );
  },
);
```

#### Custom Header

```dart
final config = CountryPickerConfig(
  customHeaderBuilder: (context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[600]!],
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.public, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          const Text(
            'Choose Your Country',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${CountryUtils.getAllCountries().length} countries available',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  },
);
```

#### Custom Search Bar

```dart
final config = CountryPickerConfig(
  customSearchBuilder: (context, controller, onChanged) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search by name, code, or capital...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  },
);
```

---

## State Management

### Local State

For simple use cases, use `StatefulWidget`:

```dart
class CountrySelectionScreen extends StatefulWidget {
  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return CountryPicker(
      onCountrySelected: (country) {
        setState(() {
          _selectedCountry = country;
        });
      },
      initialCountry: _selectedCountry,
    );
  }
}
```

### Provider Pattern

```dart
class CountryProvider extends ChangeNotifier {
  Country? _selectedCountry;

  Country? get selectedCountry => _selectedCountry;

  void selectCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCountry = null;
    notifyListeners();
  }
}

// Usage
Consumer<CountryProvider>(
  builder: (context, provider, child) {
    return CountryPicker(
      onCountrySelected: provider.selectCountry,
      initialCountry: provider.selectedCountry,
    );
  },
)
```

### Riverpod Pattern

```dart
final selectedCountryProvider = StateProvider<Country?>((ref) => null);

// Usage
Consumer(
  builder: (context, ref, child) {
    final selectedCountry = ref.watch(selectedCountryProvider);
    
    return CountryPicker(
      onCountrySelected: (country) {
        ref.read(selectedCountryProvider.notifier).state = country;
      },
      initialCountry: selectedCountry,
    );
  },
)
```

### Bloc Pattern

```dart
class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitial()) {
    on<CountrySelected>(_onCountrySelected);
    on<CountryCleared>(_onCountryCleared);
  }

  void _onCountrySelected(CountrySelected event, Emitter<CountryState> emit) {
    emit(CountryState(selectedCountry: event.country));
  }

  void _onCountryCleared(CountryCleared event, Emitter<CountryState> emit) {
    emit(CountryState(selectedCountry: null));
  }
}

// Usage
BlocBuilder<CountryBloc, CountryState>(
  builder: (context, state) {
    return CountryPicker(
      onCountrySelected: (country) {
        context.read<CountryBloc>().add(CountrySelected(country));
      },
      initialCountry: state.selectedCountry,
    );
  },
)
```

---

## Performance Optimization

### Tips for Optimal Performance

#### 1. Limit Displayed Data

```dart
// Only show countries from specific regions
const config = CountryPickerConfig(
  includeRegions: ['Europe', 'North America'],
);

// Or specify exact countries
final config = CountryPickerConfig(
  includeCountries: ['US', 'CA', 'GB', 'FR', 'DE'],
);
```

#### 2. Optimize Search Debounce

```dart
const config = CountryPickerConfig(
  searchDebounceMs: 300, // Adjust based on needs
);
```

#### 3. Reuse Controllers

```dart
class _MyWidgetState extends State<MyWidget> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Use controllers in widget
}
```

#### 4. Disable Unused Features

```dart
const config = CountryPickerConfig(
  enableHapticFeedback: false, // If not needed
  enableFilter: false,         // If not needed
  showPopulation: false,       // If not needed
  showRegion: false,           // If not needed
);
```

#### 5. Use Pagination

```dart
const config = CountryPickerConfig(
  enableInfiniteScroll: true,
  itemsPerPage: 30, // Load countries in chunks
);
```

---

## Common Patterns

### Pattern 1: Country + Phone Input

See [PhoneCodePicker example](#phonecodepicker) above.

### Pattern 2: Multi-Country Selection

```dart
class MultiCountrySelector extends StatefulWidget {
  @override
  State<MultiCountrySelector> createState() => _MultiCountrySelectorState();
}

class _MultiCountrySelectorState extends State<MultiCountrySelector> {
  final Set<Country> _selectedCountries = {};

  void _toggleCountry(Country country) {
    setState(() {
      if (_selectedCountries.contains(country)) {
        _selectedCountries.remove(country);
      } else {
        _selectedCountries.add(country);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Selected countries display
        Wrap(
          children: _selectedCountries.map((country) {
            return Chip(
              label: Text(country.name),
              onDeleted: () => _toggleCountry(country),
            );
          }).toList(),
        ),
        
        // Picker
        Expanded(
          child: CountryPicker(
            onCountrySelected: _toggleCountry,
            config: const CountryPickerConfig(
              allowMultipleSelection: true,
            ),
          ),
        ),
      ],
    );
  }
}
```

### Pattern 3: Form Integration

```dart
class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value?.isEmpty == true ? 'Required' : null,
          ),
          
          // Country selector
          InkWell(
            onTap: () async {
              final country = await ModalCountryPicker.showBottomSheet(
                context: context,
                initialCountry: _selectedCountry,
              );
              if (country != null) {
                setState(() {
                  _selectedCountry = country;
                });
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Country',
                errorText: _selectedCountry == null ? 'Please select country' : null,
              ),
              child: Text(
                _selectedCountry?.name ?? 'Select country',
              ),
            ),
          ),
          
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() && _selectedCountry != null) {
                // Submit form
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

### Pattern 4: Filtered Picker Button

```dart
Widget buildRegionalPicker(String region) {
  return ElevatedButton(
    onPressed: () async {
      final country = await ModalCountryPicker.showBottomSheet(
        context: context,
        config: CountryPickerConfig(
          includeRegions: [region],
        ),
      );
      // Handle selection
    },
    child: Text('Select from $region'),
  );
}
```

---

## Testing Widgets

### Unit Testing

```dart
testWidgets('CountryPicker calls onCountrySelected', (tester) async {
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

  // Find and tap a country
  await tester.tap(find.text('United States'));
  await tester.pump();

  expect(selectedCountry, isNotNull);
  expect(selectedCountry?.alpha2Code, 'US');
});
```

### Integration Testing

```dart
testWidgets('Full picker flow', (tester) async {
  await tester.pumpWidget(MyApp());

  // Open picker
  await tester.tap(find.text('Select Country'));
  await tester.pumpAndSettle();

  // Search
  await tester.enterText(find.byType(TextField), 'Canada');
  await tester.pumpAndSettle();

  // Select
  await tester.tap(find.text('Canada'));
  await tester.pumpAndSettle();

  // Verify selection
  expect(find.text('Selected: Canada'), findsOneWidget);
});
```

---

## Best Practices

1. **Always handle null returns** from modal pickers
2. **Dispose controllers** when using custom controllers
3. **Use const configs** when possible for performance
4. **Provide initial country** for better UX
5. **Match theme** to your app's design
6. **Limit data** when possible (use filters)
7. **Test on multiple screen sizes**
8. **Consider accessibility** (screen readers, contrast)
9. **Handle errors gracefully**
10. **Provide feedback** on selection (haptic, visual)

---

