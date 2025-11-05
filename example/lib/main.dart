import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countrify Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Countrify Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Countrify - Beautiful Country Picker Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Selected country display
            if (_selectedCountry != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      'Selected Country: ${_selectedCountry!.name}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Code: ${_selectedCountry!.alpha2Code}'),
                    Text('Capital: ${_selectedCountry!.capital}'),
                    Text('Region: ${_selectedCountry!.region}'),
                    Text('Population: ${CountryUtils.formatPopulation(_selectedCountry!.population)}'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            
            // Basic Picker Examples
            _buildSectionTitle('Basic Picker Examples'),
            ElevatedButton(
              onPressed: () => _showBottomSheetPicker(),
              child: const Text('📱 Bottom Sheet Picker'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showDialogPicker(),
              child: const Text('💬 Dialog Picker'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showFullScreenPicker(),
              child: const Text('📺 Full Screen Picker'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showCustomizedPicker(),
              child: const Text('🎨 Customized Picker'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showFilteredPicker(),
              child: const Text('🌍 Filtered Picker (Europe Only)'),
            ),
            const SizedBox(height: 20),
            
            // Comprehensive Picker Examples
            _buildSectionTitle('🚀 Comprehensive Picker Examples'),
            ElevatedButton(
              onPressed: () => _showComprehensiveBottomSheet(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('📱 Comprehensive Bottom Sheet'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showComprehensiveDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('💬 Comprehensive Dialog'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showComprehensiveFullScreen(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('📺 Comprehensive Full Screen'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showPhoneCodePicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('📞 Phone Code Picker'),
            ),
            const SizedBox(height: 20),
            
            // Flag Customization Examples
            _buildSectionTitle('🏳️ Flag Customization Examples'),
            ElevatedButton(
              onPressed: () => _showCircularFlagsPicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('⭕ Circular Flags'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showRoundedFlagsPicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('🔲 Rounded Flags'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showShadowFlagsPicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('✨ Shadow Flags'),
            ),
            const SizedBox(height: 20),
            
            // Theme Examples
            _buildSectionTitle('🎨 Theme Examples'),
            ElevatedButton(
              onPressed: () => _showDarkThemePicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
              child: const Text('🌙 Dark Theme'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showCustomColorThemePicker(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('🌈 Custom Color Theme'),
            ),
            const SizedBox(height: 20),
            
            // Data Examples
            _buildSectionTitle('📊 Data & Utilities'),
            ElevatedButton(
              onPressed: () => _showCountryData(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              child: const Text('📈 Country Data Examples'),
            ),
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: () => _showCountryStatistics(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('📊 Country Statistics'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _updateSelectedCountry(Country? country) {
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  // Basic Picker Methods
  void _showBottomSheetPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
    );
    _updateSelectedCountry(country);
  }

  void _showDialogPicker() async {
    final country = await ModalCountryPicker.showDialogPicker(
      context: context,
      initialCountry: _selectedCountry,
    );
    _updateSelectedCountry(country);
  }

  void _showFullScreenPicker() async {
    final country = await ModalCountryPicker.showFullScreen(
      context: context,
      initialCountry: _selectedCountry,
    );
    _updateSelectedCountry(country);
  }

  void _showCustomizedPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
    );
    _updateSelectedCountry(country);
  }

  void _showFilteredPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
    );
    _updateSelectedCountry(country);
  }

  // Comprehensive Picker Methods
  void _showComprehensiveBottomSheet() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showComprehensiveDialog() async {
    final country = await ModalComprehensivePicker.showDialog(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showComprehensiveFullScreen() async {
    final country = await ModalComprehensivePicker.showFullScreen(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showPhoneCodePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  // Flag Customization Methods
  void _showCircularFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showRoundedFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showShadowFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  // Theme Methods
  void _showDarkThemePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  void _showCustomColorThemePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountry: _selectedCountry,
      showPhoneCode: true,
      searchEnabled: true,
    );
    _updateSelectedCountry(country);
  }

  // Data Methods
  void _showCountryData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Country Data Examples'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Countries: ${CountryUtils.getAllCountries().length}'),
              const SizedBox(height: 8),
              Text('Regions: ${CountryUtils.getAllRegions().join(', ')}'),
              const SizedBox(height: 8),
              Text('Most Populous: ${CountryUtils.getMostPopulousCountry()?.name ?? 'N/A'}'),
              const SizedBox(height: 8),
              Text('Largest by Area: ${CountryUtils.getLargestCountry()?.name ?? 'N/A'}'),
              const SizedBox(height: 8),
              Text('European Countries: ${CountryUtils.getCountriesByRegion('Europe').length}'),
              const SizedBox(height: 8),
              Text('Asian Countries: ${CountryUtils.getCountriesByRegion('Asia').length}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCountryStatistics() {
    final countries = CountryUtils.getAllCountries();
    final totalPopulation = countries.fold<int>(0, (sum, country) => sum + country.population);
    final totalArea = countries.fold<double>(0, (sum, country) => sum + country.area);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Country Statistics'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Countries: ${countries.length}'),
              const SizedBox(height: 8),
              Text('Total Population: ${CountryUtils.formatPopulation(totalPopulation)}'),
              const SizedBox(height: 8),
              Text('Total Area: ${CountryUtils.formatArea(totalArea)}'),
              const SizedBox(height: 8),
              Text('Average Population: ${CountryUtils.formatPopulation(totalPopulation ~/ countries.length)}'),
              const SizedBox(height: 8),
              Text('Average Area: ${CountryUtils.formatArea(totalArea / countries.length)}'),
              const SizedBox(height: 8),
              Text('Regions: ${CountryUtils.getAllRegions().length}'),
              const SizedBox(height: 8),
              Text('Countries with Phone Codes: ${countries.where((c) => c.callingCodes.isNotEmpty).length}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}