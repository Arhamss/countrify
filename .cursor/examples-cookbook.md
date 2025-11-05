# Countrify Examples Cookbook

## Real-World Usage Examples and Patterns

---

## Table of Contents

1. [Basic Examples](#basic-examples)
2. [Form Integration](#form-integration)
3. [Phone Number Input](#phone-number-input)
4. [Multi-Language Support](#multi-language-support)
5. [Custom UI Variations](#custom-ui-variations)
6. [Advanced Filtering](#advanced-filtering)
7. [State Management](#state-management)
8. [E-commerce Integration](#e-commerce-integration)
9. [Shipping & Delivery](#shipping--delivery)
10. [User Registration](#user-registration)

---

## Basic Examples

### Example 1: Simple Country Selector

```dart
import 'package:flutter/material.dart';
import 'package:countrify/countrify.dart';

class SimpleCountrySelector extends StatefulWidget {
  const SimpleCountrySelector({super.key});

  @override
  State<SimpleCountrySelector> createState() => _SimpleCountrySelectorState();
}

class _SimpleCountrySelectorState extends State<SimpleCountrySelector> {
  Country? _selectedCountry;

  Future<void> _selectCountry() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
    );
    
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Country')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedCountry != null) ...[
              Image.asset(
                _selectedCountry!.flagImagePath,
                package: 'countrify',
                width: 64,
                height: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _selectedCountry!.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _selectedCountry!.capital,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ] else ...[
              const Text('No country selected'),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _selectCountry,
              child: const Text('Select Country'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Example 2: Quick Country Search

```dart
class QuickCountrySearch extends StatelessWidget {
  const QuickCountrySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Search')),
      body: CountryPicker(
        onCountrySelected: (country) {
          // Show selected country
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected: ${country.name}'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        },
        config: const CountryPickerConfig(
          enableSearch: true,
          showDialCode: true,
          showCapital: true,
        ),
      ),
    );
  }
}
```

---

## Form Integration

### Example 3: Registration Form with Country

```dart
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  Country? _selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectCountry() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      title: 'Select Country',
    );
    
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCountry != null) {
      // Process form
      final data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'country': _selectedCountry!.alpha2Code,
      };
      
      print('Submitting: $data');
      
      // Show success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );
    } else if (_selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a country')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Country selector
            InkWell(
              onTap: _selectCountry,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Country',
                  border: const OutlineInputBorder(),
                  errorText: _selectedCountry == null 
                      ? 'Please select a country' 
                      : null,
                ),
                child: Row(
                  children: [
                    if (_selectedCountry != null) ...[
                      Image.asset(
                        _selectedCountry!.flagImagePath,
                        package: 'countrify',
                        width: 32,
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _selectedCountry!.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Select country',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Phone Number Input

### Example 4: International Phone Input

```dart
class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final _phoneController = TextEditingController();
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    // Default to US
    _selectedCountry = CountryUtils.getCountryByAlpha2Code('US');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectCountryCode() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
      searchHint: 'Search country or code...',
      theme: CountryPickerTheme.defaultTheme(),
      config: const CountryPickerConfig(
        showDialCode: true,
        showFlag: true,
        flagShape: FlagShape.circular,
        sortBy: CountrySortBy.name,
      ),
    );
    
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  String get fullPhoneNumber {
    if (_selectedCountry == null || _phoneController.text.isEmpty) {
      return '';
    }
    return '${_selectedCountry!.callingCodes.first}${_phoneController.text}';
  }

  bool get isValidPhoneNumber {
    // Simple validation (customize as needed)
    return _phoneController.text.length >= 7 && 
           _selectedCountry != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            
            // Phone input row
            Row(
              children: [
                // Country code selector
                InkWell(
                  onTap: _selectCountryCode,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_selectedCountry != null) ...[
                          ClipOval(
                            child: Image.asset(
                              _selectedCountry!.flagImagePath,
                              package: 'countrify',
                              width: 28,
                              height: 28,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedCountry!.callingCodes.first,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        const SizedBox(width: 4),
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
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Full number display
            if (fullPhoneNumber.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Full number: $fullPhoneNumber',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            
            const Spacer(),
            
            // Submit button
            ElevatedButton(
              onPressed: isValidPhoneNumber
                  ? () {
                      print('Submitting phone: $fullPhoneNumber');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Phone number: $fullPhoneNumber'),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Multi-Language Support

### Example 5: Localized Country Names

```dart
class LocalizedCountryPicker extends StatefulWidget {
  const LocalizedCountryPicker({super.key});

  @override
  State<LocalizedCountryPicker> createState() => _LocalizedCountryPickerState();
}

class _LocalizedCountryPickerState extends State<LocalizedCountryPicker> {
  Country? _selectedCountry;
  String _currentLanguage = 'en'; // en, es, fr, de, etc.

  String _getLocalizedCountryName(Country country) {
    return country.nameTranslations[_currentLanguage] ?? country.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localized Picker'),
        actions: [
          // Language selector
          PopupMenuButton<String>(
            initialValue: _currentLanguage,
            onSelected: (language) {
              setState(() {
                _currentLanguage = language;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'es', child: Text('Español')),
              const PopupMenuItem(value: 'fr', child: Text('Français')),
              const PopupMenuItem(value: 'de', child: Text('Deutsch')),
              const PopupMenuItem(value: 'ja', child: Text('日本語')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedCountry != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: Row(
                children: [
                  Image.asset(
                    _selectedCountry!.flagImagePath,
                    package: 'countrify',
                    width: 48,
                    height: 36,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getLocalizedCountryName(_selectedCountry!),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Native: ${_selectedCountry!.name}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          Expanded(
            child: CountryPicker(
              onCountrySelected: (country) {
                setState(() {
                  _selectedCountry = country;
                });
              },
              initialCountry: _selectedCountry,
              config: CountryPickerConfig(
                customCountryBuilder: (context, country, isSelected) {
                  return ListTile(
                    leading: Image.asset(
                      country.flagImagePath,
                      package: 'countrify',
                      width: 32,
                      height: 24,
                    ),
                    title: Text(_getLocalizedCountryName(country)),
                    subtitle: Text(country.name),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    selected: isSelected,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## Custom UI Variations

### Example 6: Grid View Country Picker

```dart
class GridCountryPicker extends StatefulWidget {
  const GridCountryPicker({super.key});

  @override
  State<GridCountryPicker> createState() => _GridCountryPickerState();
}

class _GridCountryPickerState extends State<GridCountryPicker> {
  Country? _selectedCountry;
  List<Country> _countries = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _countries = CountryUtils.getAllCountries();
  }

  List<Country> get _filteredCountries {
    if (_searchQuery.isEmpty) return _countries;
    return CountryUtils.searchCountries(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Country Picker'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Grid view
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = _selectedCountry == country;
                
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCountry = country;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Colors.blue[50] : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          country.flagImagePath,
                          package: 'countrify',
                          width: 48,
                          height: 36,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          country.alpha2Code,
                          style: TextStyle(
                            fontWeight: isSelected 
                                ? FontWeight.bold 
                                : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

### Example 7: Compact Country Selector

```dart
class CompactCountrySelector extends StatefulWidget {
  const CompactCountrySelector({super.key});

  @override
  State<CompactCountrySelector> createState() => _CompactCountrySelectorState();
}

class _CompactCountrySelectorState extends State<CompactCountrySelector> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryUtils.getCountryByAlpha2Code('US');
  }

  Future<void> _showCountryPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
    );
    
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showCountryPicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedCountry != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  _selectedCountry!.flagImagePath,
                  package: 'countrify',
                  width: 24,
                  height: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _selectedCountry!.name,
                style: const TextStyle(fontSize: 14),
              ),
            ],
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 20, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
```

---

## Advanced Filtering

### Example 8: Regional Country Selector

```dart
class RegionalCountrySelector extends StatefulWidget {
  const RegionalCountrySelector({super.key});

  @override
  State<RegionalCountrySelector> createState() => _RegionalCountrySelectorState();
}

class _RegionalCountrySelectorState extends State<RegionalCountrySelector> {
  String _selectedRegion = 'All';
  Country? _selectedCountry;

  List<String> get _regions {
    return ['All', ...CountryUtils.getAllRegions()];
  }

  Future<void> _selectCountry() async {
    final config = _selectedRegion == 'All'
        ? const CountryPickerConfig()
        : CountryPickerConfig(
            includeRegions: [_selectedRegion],
          );

    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      config: config,
      title: _selectedRegion == 'All' 
          ? 'Select Country' 
          : 'Select Country from $_selectedRegion',
    );
    
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regional Selector')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Region selector
            const Text(
              'Select Region',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _regions.map((region) {
                final isSelected = region == _selectedRegion;
                return ChoiceChip(
                  label: Text(region),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedRegion = region;
                        _selectedCountry = null; // Reset selection
                      });
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // Selected country display
            if (_selectedCountry != null) ...[
              Card(
                child: ListTile(
                  leading: Image.asset(
                    _selectedCountry!.flagImagePath,
                    package: 'countrify',
                    width: 48,
                    height: 36,
                  ),
                  title: Text(_selectedCountry!.name),
                  subtitle: Text(_selectedCountry!.region),
                  trailing: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _selectedCountry = null;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Select button
            ElevatedButton(
              onPressed: _selectCountry,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                _selectedRegion == 'All'
                    ? 'Select Country'
                    : 'Select from $_selectedRegion',
              ),
            ),
            
            // Region statistics
            const SizedBox(height: 24),
            if (_selectedRegion != 'All') ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$_selectedRegion Statistics',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Countries: ${CountryUtils.getCountriesByRegion(_selectedRegion).length}',
                      ),
                      Text(
                        'Subregions: ${CountryUtils.getSubregionsByRegion(_selectedRegion).length}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## State Management

### Example 9: Provider Pattern

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countrify/countrify.dart';

// Provider class
class CountrySelectionProvider extends ChangeNotifier {
  Country? _selectedCountry;
  List<Country> _recentlySelected = [];

  Country? get selectedCountry => _selectedCountry;
  List<Country> get recentlySelected => _recentlySelected;

  void selectCountry(Country country) {
    _selectedCountry = country;
    
    // Add to recent (max 5)
    _recentlySelected.removeWhere((c) => c.alpha2Code == country.alpha2Code);
    _recentlySelected.insert(0, country);
    if (_recentlySelected.length > 5) {
      _recentlySelected = _recentlySelected.take(5).toList();
    }
    
    notifyListeners();
  }

  void clearSelection() {
    _selectedCountry = null;
    notifyListeners();
  }

  void clearHistory() {
    _recentlySelected.clear();
    notifyListeners();
  }
}

// Main app
class CountryProviderApp extends StatelessWidget {
  const CountryProviderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountrySelectionProvider(),
      child: MaterialApp(
        home: const CountryProviderScreen(),
      ),
    );
  }
}

// Screen
class CountryProviderScreen extends StatelessWidget {
  const CountryProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Example')),
      body: Consumer<CountrySelectionProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Selected country
              if (provider.selectedCountry != null)
                Card(
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    leading: Image.asset(
                      provider.selectedCountry!.flagImagePath,
                      package: 'countrify',
                      width: 48,
                      height: 36,
                    ),
                    title: Text(provider.selectedCountry!.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: provider.clearSelection,
                    ),
                  ),
                ),
              
              // Recently selected
              if (provider.recentlySelected.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recently Selected',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: provider.clearHistory,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.recentlySelected.length,
                    itemBuilder: (context, index) {
                      final country = provider.recentlySelected[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () => provider.selectCountry(country),
                          child: Column(
                            children: [
                              Image.asset(
                                country.flagImagePath,
                                package: 'countrify',
                                width: 48,
                                height: 36,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                country.alpha2Code,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              
              // Picker
              Expanded(
                child: CountryPicker(
                  onCountrySelected: provider.selectCountry,
                  initialCountry: provider.selectedCountry,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

---

## E-commerce Integration

### Example 10: Shipping Country Selector

```dart
class ShippingCountrySelector extends StatefulWidget {
  const ShippingCountrySelector({super.key});

  @override
  State<ShippingCountrySelector> createState() => _ShippingCountrySelectorState();
}

class _ShippingCountrySelectorState extends State<ShippingCountrySelector> {
  Country? _shippingCountry;
  
  // Available shipping countries
  static const _availableCountries = ['US', 'CA', 'GB', 'AU', 'DE', 'FR'];
  
  double _calculateShipping() {
    if (_shippingCountry == null) return 0;
    
    // Example shipping logic
    switch (_shippingCountry!.alpha2Code) {
      case 'US':
        return 5.99;
      case 'CA':
        return 9.99;
      default:
        return 14.99;
    }
  }

  Future<void> _selectShippingCountry() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _shippingCountry,
      title: 'Select Shipping Country',
      config: CountryPickerConfig(
        includeCountries: _availableCountries,
        showFlag: true,
        showDialCode: false,
        customCountryBuilder: (context, country, isSelected) {
          final shippingCost = _calculateShippingFor(country);
          return ListTile(
            leading: Image.asset(
              country.flagImagePath,
              package: 'countrify',
              width: 48,
              height: 36,
            ),
            title: Text(country.name),
            subtitle: Text('Shipping: \$${shippingCost.toStringAsFixed(2)}'),
            trailing: isSelected ? const Icon(Icons.check_circle) : null,
            selected: isSelected,
          );
        },
      ),
    );
    
    if (country != null) {
      setState(() {
        _shippingCountry = country;
      });
    }
  }

  double _calculateShippingFor(Country country) {
    switch (country.alpha2Code) {
      case 'US':
        return 5.99;
      case 'CA':
        return 9.99;
      default:
        return 14.99;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shippingCost = _calculateShipping();
    const productPrice = 49.99;
    final totalPrice = productPrice + shippingCost;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Product
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
              ),
              title: const Text('Sample Product'),
              subtitle: const Text('\$49.99'),
            ),
          ),
          const SizedBox(height: 16),
          
          // Shipping country
          const Text(
            'Shipping Country',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: _selectShippingCountry,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (_shippingCountry != null) ...[
                      Image.asset(
                        _shippingCountry!.flagImagePath,
                        package: 'countrify',
                        width: 48,
                        height: 36,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _shippingCountry!.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Shipping: \$${shippingCost.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      const Expanded(
                        child: Text(
                          'Select shipping country',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Price breakdown
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Product'),
                      Text('\$${productPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Shipping'),
                      Text('\$${shippingCost.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Checkout button
          ElevatedButton(
            onPressed: _shippingCountry != null
                ? () {
                    // Process checkout
                    print('Checkout with ${_shippingCountry!.name}');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Complete Order'),
          ),
        ],
      ),
    );
  }
}
```

---

## Best Practices

### DO

✅ Always handle null returns from modal pickers
✅ Provide initial country for better UX
✅ Use appropriate display mode for context
✅ Show user feedback on selection
✅ Validate country selection in forms
✅ Cache country data when reusing
✅ Match theme to your app design
✅ Provide search for long lists
✅ Consider accessibility

### DON'T

❌ Block UI unnecessarily
❌ Ignore user's locale/region
❌ Show all countries when subset would work
❌ Forget to handle selection cancellation
❌ Mix different picker styles inconsistently
❌ Overcomplicate simple selections
❌ Ignore performance with large lists
❌ Forget to dispose controllers

---

