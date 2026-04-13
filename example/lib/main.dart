import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CountrifyExampleApp());

class CountrifyExampleApp extends StatelessWidget {
  const CountrifyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countrify Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Countrify'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Phone Input'),
              Tab(text: 'Country Picker'),
              Tab(text: 'Theming'),
              Tab(text: 'Localization'),
              Tab(text: 'Building Blocks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PhoneInputTab(),
            CountryPickerTab(),
            ThemingTab(),
            LocalizationTab(),
            BuildingBlocksTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1: Phone Input
// ---------------------------------------------------------------------------

class PhoneInputTab extends StatefulWidget {
  const PhoneInputTab({super.key});

  @override
  State<PhoneInputTab> createState() => _PhoneInputTabState();
}

class _PhoneInputTabState extends State<PhoneInputTab> {
  String _phoneNumber = '';
  String _countryName = 'United States';
  String _dialCode = '+1';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        PhoneNumberField(
          initialCountryCode: CountryCode.us,
          style: CountrifyFieldStyle.defaultStyle().copyWith(
            fillColor: const Color(0xFFF0F4FF),
            focusedFillColor: const Color(0xFFE3ECFF),
            hintText: 'Enter phone number',
          ),
          onChanged: (phoneNumber, country) {
            debugPrint('Phone: +${country.callingCodes.first}$phoneNumber');
            setState(() {
              _phoneNumber = phoneNumber;
              _countryName = country.name;
              _dialCode = '+${country.callingCodes.first}';
            });
          },
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected country: $_countryName',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Number: $_dialCode $_phoneNumber',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2: Country Picker
// ---------------------------------------------------------------------------

class CountryPickerTab extends StatefulWidget {
  const CountryPickerTab({super.key});

  @override
  State<CountryPickerTab> createState() => _CountryPickerTabState();
}

class _CountryPickerTabState extends State<CountryPickerTab> {
  String _selectedCountry = 'None';
  CountryPickerMode _pickerMode = CountryPickerMode.dropdown;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _modeButton('Dropdown', CountryPickerMode.dropdown),
            _modeButton('Bottom Sheet', CountryPickerMode.bottomSheet),
            _modeButton('Dialog', CountryPickerMode.dialog),
            _modeButton('Full Screen', CountryPickerMode.fullScreen),
          ],
        ),
        const SizedBox(height: 24),
        CountryDropdownField(
          key: ValueKey(_pickerMode),
          pickerMode: _pickerMode,
          style: CountrifyFieldStyle.defaultStyle().copyWith(
            labelText: 'Select a country',
          ),
          onChanged: (country) {
            setState(() {
              _selectedCountry = country.name;
            });
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Selected: $_selectedCountry',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _modeButton(String label, CountryPickerMode mode) {
    final isSelected = _pickerMode == mode;
    return FilledButton(
      onPressed: () => setState(() => _pickerMode = mode),
      style: FilledButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      child: Text(label),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3: Theming
// ---------------------------------------------------------------------------

class ThemingTab extends StatefulWidget {
  const ThemingTab({super.key});

  @override
  State<ThemingTab> createState() => _ThemingTabState();
}

class _ThemingTabState extends State<ThemingTab> {
  int _selectedTheme = 0;
  static const _themeLabels = ['Default', 'Dark', 'Material 3'];

  CountryPickerTheme get _currentTheme {
    switch (_selectedTheme) {
      case 1:
        return CountryPickerTheme.darkTheme();
      case 2:
        return CountryPickerTheme.material3Theme();
      default:
        return CountryPickerTheme.defaultTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Wrap(
          spacing: 8,
          children: List.generate(_themeLabels.length, (i) {
            return ChoiceChip(
              label: Text(_themeLabels[i]),
              selected: _selectedTheme == i,
              onSelected: (_) => setState(() => _selectedTheme = i),
            );
          }),
        ),
        const SizedBox(height: 24),
        PhoneNumberField(
          initialCountryCode: CountryCode.us,
          theme: _currentTheme,
          style: CountrifyFieldStyle.defaultStyle().copyWith(
            hintText: 'Themed phone field',
          ),
          onChanged: (phone, country) {
            debugPrint('Phone: $phone, Country: ${country.name}');
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 4: Localization
// ---------------------------------------------------------------------------

class LocalizationTab extends StatefulWidget {
  const LocalizationTab({super.key});

  @override
  State<LocalizationTab> createState() => _LocalizationTabState();
}

class _LocalizationTabState extends State<LocalizationTab> {
  String _selectedLocale = 'en';

  static const _locales = <String, String>{
    'en': 'English',
    'ar': 'Arabic',
    'fr': 'French',
    'es': 'Spanish',
    'de': 'German',
    'zh': 'Chinese',
    'ja': 'Japanese',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedLocale,
            decoration: const InputDecoration(
              labelText: 'Language',
              border: OutlineInputBorder(),
            ),
            items: _locales.entries
                .map((e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _selectedLocale = value);
            },
          ),
        ),
        Expanded(
          child: CountryPicker(
            key: ValueKey(_selectedLocale),
            pickerType: CountryPickerType.inline,
            config: CountryPickerConfig(locale: _selectedLocale),
            onCountrySelected: (country) {
              debugPrint('Selected: ${country.name}');
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 5: Building Blocks
// ---------------------------------------------------------------------------

class BuildingBlocksTab extends StatelessWidget {
  const BuildingBlocksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final us = CountryUtils.getCountryByCode(CountryCode.us)!;
    final gb = CountryUtils.getCountryByCode(CountryCode.gb)!;
    final jp = CountryUtils.getCountryByCode(CountryCode.jp)!;
    final br = CountryUtils.getCountryByCode(CountryCode.br)!;

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('CountryFlag', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            CountryFlag(country: us, size: const Size(48, 36)),
            CountryFlag(country: gb, size: const Size(48, 36)),
            CountryFlag(country: jp, size: const Size(48, 36)),
            CountryFlag(country: br, size: const Size(48, 36)),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          'CountrySearchBar',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        CountrySearchBar(
          hintText: 'Search countries...',
          onChanged: (query) => debugPrint('Search: $query'),
        ),
        const SizedBox(height: 32),
        Text(
          'CountryListTile',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        CountryListTile(
          country: us,
          isSelected: true,
          onTap: (country) => debugPrint('Tapped: ${country.name}'),
        ),
        CountryListTile(
          country: gb,
          onTap: (country) => debugPrint('Tapped: ${country.name}'),
        ),
        CountryListTile(
          country: jp,
          onTap: (country) => debugPrint('Tapped: ${country.name}'),
        ),
        CountryListTile(
          country: br,
          onTap: (country) => debugPrint('Tapped: ${country.name}'),
        ),
      ],
    );
  }
}
