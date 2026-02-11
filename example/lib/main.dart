import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

// ─── Codeable Brand Colors (gocodeable.com) ───────────────────────────
class CodeableColors {
  CodeableColors._();

  // ── Primary Blue (main brand color) ──
  static const Color blue = Color(0xFF3B82F6);
  static const Color blueDark = Color(0xFF1D4ED8);
  static const Color blueLight = Color(0xFF60A5FA);
  static const Color blueSubtle = Color(0xFFDBEAFE);
  static const Color blueFaint = Color(0xFFEFF6FF);

  // ── Secondary Green (accent) ──
  static const Color green = Color(0xFF22C55E);
  static const Color greenDark = Color(0xFF16A34A);
  static const Color greenLight = Color(0xFF4ADE80);
  static const Color greenSubtle = Color(0xFFDCFCE7);
  static const Color greenFaint = Color(0xFFF0FDF4);

  // ── Light Theme ──
  static const Color lightBg = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8FAFC);
  static const Color lightSurfaceAlt = Color(0xFFF1F5F9);
  static const Color lightText = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextMuted = Color(0xFF9CA3AF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderStrong = Color(0xFFCBD5E1);
  static const Color lightDivider = Color(0xFFE5E7EB);

  // ── Dark Theme ──
  static const Color darkBg = Color(0xFF0B0B0F);
  static const Color darkSurface = Color(0xFF161619);
  static const Color darkSurfaceLight = Color(0xFF1E1E22);
  static const Color darkElevated = Color(0xFF222228);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextMuted = Color(0xFF6B7280);
  static const Color darkBorder = Color(0xFF2D2D33);
  static const Color darkBorderLight = Color(0xFF3F3F46);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countrify Example',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: CodeableColors.lightBg,
        colorScheme: const ColorScheme.light(
          primary: CodeableColors.blue,
          onPrimary: Colors.white,
          secondary: CodeableColors.green,
          onSecondary: Colors.white,
          surface: CodeableColors.lightSurface,
          onSurface: CodeableColors.lightText,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: CodeableColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
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
  CountryCode? get _selectedCountryCode =>
      CountryCodeExtension.fromAlpha2Code(_selectedCountry?.alpha2Code ?? '');
  String _phoneNumber = '';
  Country? _phoneCountry;

  String _getLocalizedCountryName(Country country) {
    final locale = Localizations.localeOf(context).languageCode;
    return CountryUtils.getCountryNameInLanguage(country, locale);
  }

  // ─── Light theme (Codeable Blue on white) ─────────────────────────
  CountryPickerTheme get _codeableLightTheme => const CountryPickerTheme(
        backgroundColor: CodeableColors.lightBg,
        headerColor: CodeableColors.blueFaint,
        headerTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CodeableColors.lightText,
        ),
        headerIconColor: CodeableColors.lightTextSecondary,
        searchBarColor: CodeableColors.lightSurface,
        searchTextStyle: TextStyle(
          fontSize: 16,
          color: CodeableColors.lightText,
        ),
        searchHintStyle: TextStyle(
          fontSize: 16,
          color: CodeableColors.lightTextMuted,
        ),
        searchIconColor: CodeableColors.lightTextMuted,
        searchBarBorderColor: CodeableColors.lightBorder,
        searchBarBorderRadius: BorderRadius.all(Radius.circular(12)),
        filterBackgroundColor: CodeableColors.lightSurfaceAlt,
        filterSelectedColor: CodeableColors.blue,
        filterTextColor: CodeableColors.lightText,
        filterSelectedTextColor: Colors.white,
        filterCheckmarkColor: Colors.white,
        filterIconColor: CodeableColors.lightTextSecondary,
        filterTextStyle: TextStyle(
          fontSize: 14,
          color: CodeableColors.lightText,
        ),
        countryItemBackgroundColor: CodeableColors.lightBg,
        countryItemSelectedColor: CodeableColors.blueSubtle,
        countryItemSelectedBorderColor: CodeableColors.blue,
        countryItemSelectedIconColor: CodeableColors.blue,
        countryItemBorderRadius: BorderRadius.all(Radius.circular(10)),
        countryNameTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CodeableColors.lightText,
        ),
        countrySubtitleTextStyle: TextStyle(
          fontSize: 14,
          color: CodeableColors.lightTextSecondary,
        ),
        borderColor: CodeableColors.lightBorder,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        scrollbarThickness: 4.0,
        scrollbarRadius: BorderRadius.all(Radius.circular(2)),
        shadowColor: Color(0x1A3B82F6),
        elevation: 8.0,
        animationDuration: Duration(milliseconds: 300),
        hapticFeedback: true,
        dropdownMenuBackgroundColor: CodeableColors.lightBg,
        dropdownMenuElevation: 8,
        dropdownMenuBorderRadius: BorderRadius.all(Radius.circular(12)),
        dropdownMenuBorderColor: CodeableColors.lightBorder,
        dropdownMenuBorderWidth: 1,
      );

  // ─── Dark theme (Codeable Blue on dark) ───────────────────────────
  CountryPickerTheme get _codeableDarkTheme => const CountryPickerTheme(
        backgroundColor: CodeableColors.darkSurface,
        headerColor: CodeableColors.darkSurfaceLight,
        headerTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: CodeableColors.darkText,
        ),
        headerIconColor: CodeableColors.darkTextSecondary,
        searchBarColor: CodeableColors.darkElevated,
        searchTextStyle: TextStyle(
          fontSize: 16,
          color: CodeableColors.darkText,
        ),
        searchHintStyle: TextStyle(
          fontSize: 16,
          color: CodeableColors.darkTextMuted,
        ),
        searchIconColor: CodeableColors.darkTextMuted,
        searchBarBorderColor: CodeableColors.darkBorder,
        searchBarBorderRadius: BorderRadius.all(Radius.circular(12)),
        filterBackgroundColor: CodeableColors.darkElevated,
        filterSelectedColor: CodeableColors.blueLight,
        filterTextColor: CodeableColors.darkTextSecondary,
        filterSelectedTextColor: Color(0xFF0B0B0F),
        filterCheckmarkColor: Color(0xFF0B0B0F),
        filterIconColor: CodeableColors.darkTextMuted,
        filterTextStyle: TextStyle(
          fontSize: 14,
          color: CodeableColors.darkTextSecondary,
        ),
        countryItemBackgroundColor: CodeableColors.darkSurface,
        countryItemSelectedColor: Color(0xFF1A2744),
        countryItemSelectedBorderColor: CodeableColors.blueLight,
        countryItemSelectedIconColor: CodeableColors.blueLight,
        countryItemBorderRadius: BorderRadius.all(Radius.circular(10)),
        countryNameTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CodeableColors.darkText,
        ),
        countrySubtitleTextStyle: TextStyle(
          fontSize: 14,
          color: CodeableColors.darkTextSecondary,
        ),
        borderColor: CodeableColors.darkBorder,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        scrollbarThickness: 4.0,
        scrollbarRadius: BorderRadius.all(Radius.circular(2)),
        shadowColor: Color(0x333B82F6),
        elevation: 12.0,
        animationDuration: Duration(milliseconds: 300),
        hapticFeedback: true,
        dropdownMenuBackgroundColor: CodeableColors.darkSurfaceLight,
        dropdownMenuElevation: 12,
        dropdownMenuBorderRadius: BorderRadius.all(Radius.circular(12)),
        dropdownMenuBorderColor: CodeableColors.darkBorder,
        dropdownMenuBorderWidth: 1,
      );

  // ─── Text style showcase theme (exercises all text-style hooks) ───────
  CountryPickerTheme get _textStyleShowcaseTheme => const CountryPickerTheme(
        backgroundColor: Color(0xFFFFFCF5),
        headerColor: Color(0xFFFFF3D6),
        headerTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF5B2E00),
          letterSpacing: 0.2,
        ),
        appBarTitleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF3F1F00),
          letterSpacing: 0.3,
        ),
        searchTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4A2900),
        ),
        searchHintStyle: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          color: Color(0xFF9A6A2A),
        ),
        filterTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4A2900),
        ),
        countryNameTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF3F1F00),
        ),
        countrySubtitleTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7A4A10),
        ),
        compactCountryNameTextStyle: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          color: Color(0xFF8A5415),
        ),
        compactDialCodeTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: Color(0xFF8E1E00),
        ),
        readOnlyHintTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFB07A3A),
        ),
        flagEmojiTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        dialogOptionTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3F1F00),
        ),
        dialogActionTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: Color(0xFFC23E00),
        ),
        borderColor: Color(0xFFF1C485),
        countryItemSelectedColor: Color(0xFFFFE7BF),
        countryItemSelectedBorderColor: Color(0xFFC46B00),
        countryItemSelectedIconColor: Color(0xFFC23E00),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: CodeableColors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Hero title
            const Text(
              'Beautiful Country\nPicker Examples',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: CodeableColors.lightText,
                height: 1.2,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Powered by Codeable',
              style: TextStyle(
                fontSize: 14,
                color: CodeableColors.blue,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Selected country display
            if (_selectedCountry != null) ...[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: CodeableColors.blueFaint,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: CodeableColors.blue.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: CodeableColors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'SELECTED COUNTRY',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: CodeableColors.blue,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getLocalizedCountryName(_selectedCountry!),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: CodeableColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildInfoChip('Code', _selectedCountry!.alpha2Code),
                        _buildInfoChip('Capital', _selectedCountry!.capital),
                        _buildInfoChip('Region', _selectedCountry!.region),
                        _buildInfoChip(
                          'Population',
                          CountryUtils.formatPopulation(
                              _selectedCountry!.population),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // ─── Dropdown Picker ────────────────────────────────────
            _buildSectionTitle('Dropdown Picker'),
            const SizedBox(height: 4),
            const Text(
              'Select a country using the dropdown widget:',
              style: TextStyle(
                  fontSize: 14, color: CodeableColors.lightTextSecondary),
            ),
            const SizedBox(height: 12),
            ModalComprehensivePicker.dropdown(
              initialCountryCode: CountryCode.ad,
              onCountrySelected: _updateSelectedCountry,
              onCountryChanged: _updateSelectedCountry,
              showPhoneCode: false,
              showFlag: true,
              showCountryName: true,
              theme: _codeableLightTheme,
            ),
            const SizedBox(height: 28),

            // ─── Country Dropdown Field ───────────────────────────
            _buildSectionTitle('Country Dropdown Field'),
            const SizedBox(height: 4),
            const Text(
              'A form-friendly field that opens a picker on tap:',
              style: TextStyle(
                  fontSize: 14, color: CodeableColors.lightTextSecondary),
            ),
            const SizedBox(height: 12),
            CountryDropdownField(
              initialCountryCode: CountryCode.ad,
              onCountrySelected: _updateSelectedCountry,
              onCountryChanged: _updateSelectedCountry,
              style: CountrifyFieldStyle.defaultStyle().copyWith(
                hintText: 'Select a country',
              ),
              showPhoneCode: false,
              showFlag: true,
              searchEnabled: true,
              pickerType: PickerDisplayType.none,
              theme: _codeableLightTheme,
            ),
            const SizedBox(height: 28),

            // ─── Basic Pickers ──────────────────────────────────────
            _buildSectionTitle('Basic Pickers'),
            const SizedBox(height: 8),
            _buildBlueButton(
              label: 'Bottom Sheet Picker',
              icon: CountrifyIcons.smartphone,
              onPressed: _showBottomSheetPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Dialog Picker',
              icon: CountrifyIcons.messageSquare,
              onPressed: _showDialogPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Full Screen Picker',
              icon: CountrifyIcons.maximize,
              onPressed: _showFullScreenPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Customized Picker',
              icon: CountrifyIcons.palette,
              onPressed: _showCustomizedPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Filtered Picker (Europe)',
              icon: CountrifyIcons.globe,
              onPressed: _showFilteredPicker,
            ),
            const SizedBox(height: 28),

            // ─── Comprehensive Pickers ──────────────────────────────
            _buildSectionTitle('Comprehensive Pickers'),
            const SizedBox(height: 8),
            _buildBlueButton(
              label: 'Comprehensive Bottom Sheet',
              icon: CountrifyIcons.rocket,
              onPressed: _showComprehensiveBottomSheet,
            ),
            const SizedBox(height: 10),
            _buildBlueButton(
              label: 'Comprehensive Dialog',
              icon: CountrifyIcons.messageCircle,
              onPressed: _showComprehensiveDialog,
            ),
            const SizedBox(height: 10),
            _buildBlueButton(
              label: 'Comprehensive Full Screen',
              icon: CountrifyIcons.expand,
              onPressed: _showComprehensiveFullScreen,
            ),
            const SizedBox(height: 10),
            _buildGreenButton(
              label: 'Phone Code Picker',
              icon: CountrifyIcons.phone,
              onPressed: _showPhoneCodePicker,
            ),
            const SizedBox(height: 28),

            // ─── Phone Number Field ─────────────────────────────────
            _buildSectionTitle('Phone Number Field'),
            const SizedBox(height: 4),
            const Text(
              'Inline dropdown to pick country code:',
              style: TextStyle(
                  fontSize: 14, color: CodeableColors.lightTextSecondary),
            ),
            const SizedBox(height: 12),
            PhoneNumberField(
              style: const CountrifyFieldStyle(
                hintText: 'Enter phone number',
                labelText: 'Phone',
                cursorColor: CodeableColors.blue,
              ),
              initialCountryCode: CountryCode.ad,
              theme: _codeableLightTheme,
              pickerType: PickerOpenType.none,
              showDropdownIcon: true,
              config: const CountryPickerConfig(
                enableSearch: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
              onPhoneNumberChanged: (phoneNumber, country) {
                setState(() {
                  _phoneNumber = phoneNumber;
                  _phoneCountry = country;
                });
              },
              onCountryChanged: (country) {
                setState(() {
                  _phoneCountry = country;
                });
              },
            ),
            if (_phoneNumber.isNotEmpty && _phoneCountry != null) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: CodeableColors.greenFaint,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CodeableColors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      CountrifyIcons.phone,
                      size: 18,
                      color: CodeableColors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '+${_phoneCountry!.callingCodes.first} $_phoneNumber',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CodeableColors.lightText,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Custom styled variant
            const Text(
              'With custom styling and larger flags:',
              style: TextStyle(
                  fontSize: 14, color: CodeableColors.lightTextSecondary),
            ),
            const SizedBox(height: 12),
            PhoneNumberField(
              theme: _codeableLightTheme,
              showDropdownIcon: false,
              flagSize: const Size(28, 20),
              dropdownMaxHeight: 300,
              style: CountrifyFieldStyle.defaultStyle().copyWith(
                hintText: 'Phone number',
                fieldBorderRadius: BorderRadius.circular(16),
                dialCodeTextStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: CodeableColors.blue,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 12,
              onPhoneNumberChanged: (phoneNumber, country) {},
            ),
            const SizedBox(height: 28),

            // ─── Flag Customization ─────────────────────────────────
            _buildSectionTitle('Flag Customization'),
            const SizedBox(height: 8),
            _buildOutlinedBlueButton(
              label: 'Circular Flags',
              icon: CountrifyIcons.circle,
              onPressed: _showCircularFlagsPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Rounded Flags',
              icon: CountrifyIcons.squareRoundCorner,
              onPressed: _showRoundedFlagsPicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Shadow Flags',
              icon: CountrifyIcons.sparkles,
              onPressed: _showShadowFlagsPicker,
            ),
            const SizedBox(height: 28),

            // ─── Theme Examples ─────────────────────────────────────
            _buildSectionTitle('Theme Examples'),
            const SizedBox(height: 8),
            _buildDarkButton(
              label: 'Dark Theme',
              icon: CountrifyIcons.moon,
              onPressed: _showDarkThemePicker,
            ),
            const SizedBox(height: 10),
            _buildGreenButton(
              label: 'Custom Color Theme',
              icon: CountrifyIcons.paintbrush,
              onPressed: _showCustomColorThemePicker,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Text Style Showcase',
              icon: CountrifyIcons.sparkles,
              onPressed: _showTextStyleShowcasePicker,
            ),
            const SizedBox(height: 28),

            // ─── Localization Demo ──────────────────────────────────
            _buildSectionTitle('Localization (132 Languages)'),
            const SizedBox(height: 4),
            const Text(
              'Select a country above, then explore translations:',
              style: TextStyle(
                  fontSize: 14, color: CodeableColors.lightTextSecondary),
            ),
            const SizedBox(height: 12),
            _buildBlueButton(
              label: 'Show Translations',
              icon: CountrifyIcons.globe,
              onPressed: _showLocalizationDemo,
            ),
            const SizedBox(height: 28),

            // ─── Data & Utilities ───────────────────────────────────
            _buildSectionTitle('Data & Utilities'),
            const SizedBox(height: 8),
            _buildOutlinedBlueButton(
              label: 'Country Data Examples',
              icon: CountrifyIcons.chartBar,
              onPressed: _showCountryData,
            ),
            const SizedBox(height: 10),
            _buildOutlinedBlueButton(
              label: 'Country Statistics',
              icon: CountrifyIcons.chartLine,
              onPressed: _showCountryStatistics,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ─── Info Chip (light style) ──────────────────────────────────────
  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: CodeableColors.lightBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CodeableColors.lightBorder),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: CodeableColors.lightTextMuted,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: CodeableColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section Title (blue accent bar) ──────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: CodeableColors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: CodeableColors.lightText,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  // ─── Blue filled button (primary CTA) ─────────────────────────────
  Widget _buildBlueButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CodeableColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Blue outlined button (secondary) ─────────────────────────────
  Widget _buildOutlinedBlueButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: CodeableColors.blue,
          side: const BorderSide(color: CodeableColors.lightBorderStrong),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: CodeableColors.blue),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CodeableColors.lightText,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Green filled button (accent) ─────────────────────────────────
  Widget _buildGreenButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CodeableColors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Dark button (for dark theme demo) ────────────────────────────
  Widget _buildDarkButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CodeableColors.darkSurface,
          foregroundColor: CodeableColors.darkText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: CodeableColors.blueLight),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
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

  // ─── Basic Picker Methods ─────────────────────────────────────────
  void _showBottomSheetPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
    );
    _updateSelectedCountry(country);
  }

  void _showDialogPicker() async {
    final country = await ModalCountryPicker.showDialogPicker(
      context: context,
      initialCountryCode: _selectedCountryCode,
    );
    _updateSelectedCountry(country);
  }

  void _showFullScreenPicker() async {
    final country = await ModalCountryPicker.showFullScreen(
      context: context,
      initialCountryCode: _selectedCountryCode,
    );
    _updateSelectedCountry(country);
  }

  void _showCustomizedPicker() async {
    final country = await ModalCountryPicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
    );
    _updateSelectedCountry(country);
  }

  void _showFilteredPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      config: const CountryPickerConfig(
        includeRegions: ['Europe'],
      ),
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
    );
    _updateSelectedCountry(country);
  }

  // ─── Comprehensive Picker Methods ─────────────────────────────────
  void _showComprehensiveBottomSheet() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
    );
    _updateSelectedCountry(country);
  }

  void _showComprehensiveDialog() async {
    final country = await ModalComprehensivePicker.showDialog(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
    );
    _updateSelectedCountry(country);
  }

  void _showComprehensiveFullScreen() async {
    final country = await ModalComprehensivePicker.showFullScreen(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
    );
    _updateSelectedCountry(country);
  }

  void _showPhoneCodePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
    );
    _updateSelectedCountry(country);
  }

  // ─── Flag Customization Methods ───────────────────────────────────
  void _showCircularFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
      flagShape: FlagShape.circular,
      flagSize: const Size(40, 40),
    );
    _updateSelectedCountry(country);
  }

  void _showRoundedFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
      flagShape: FlagShape.rounded,
      flagSize: const Size(40, 28),
    );
    _updateSelectedCountry(country);
  }

  void _showShadowFlagsPicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableLightTheme,
      config: const CountryPickerConfig(
        flagBorderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      flagShape: FlagShape.rectangular,
      flagSize: const Size(42, 30),
      flagShadowColor: const Color(0x333B82F6),
      flagShadowBlur: 8,
      flagShadowOffset: const Offset(0, 3),
    );
    _updateSelectedCountry(country);
  }

  // ─── Theme Methods ────────────────────────────────────────────────
  void _showDarkThemePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: _codeableDarkTheme,
    );
    _updateSelectedCountry(country);
  }

  void _showCustomColorThemePicker() async {
    final country = await ModalComprehensivePicker.showBottomSheet(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      theme: CountryPickerTheme.custom(
        primaryColor: CodeableColors.green,
        backgroundColor: CodeableColors.greenFaint,
        surfaceColor: CodeableColors.greenSubtle,
        onSurfaceColor: CodeableColors.lightText,
        isDark: false,
      ),
    );
    _updateSelectedCountry(country);
  }

  void _showTextStyleShowcasePicker() async {
    final country = await ModalComprehensivePicker.showFullScreen(
      context: context,
      initialCountryCode: _selectedCountryCode,
      showPhoneCode: true,
      searchEnabled: true,
      filterEnabled: true,
      theme: _textStyleShowcaseTheme,
    );
    _updateSelectedCountry(country);
  }

  // ─── Localization Demo ────────────────────────────────────────────
  void _showLocalizationDemo() {
    final country =
        _selectedCountry ?? CountryUtils.getCountryByAlpha2Code('US');
    if (country == null) return;

    String displayName(Country country) {
      final locale = Localizations.localeOf(context).languageCode;
      return CountryUtils.getCountryNameInLanguage(country, locale);
    }

    // A curated list of languages to showcase.
    const showcaseLanguages = <String, String>{
      'en': 'English',
      'ar': 'Arabic',
      'zh': 'Chinese',
      'nl': 'Dutch',
      'fr': 'French',
      'de': 'German',
      'el': 'Greek',
      'he': 'Hebrew',
      'hi': 'Hindi',
      'it': 'Italian',
      'ja': 'Japanese',
      'ko': 'Korean',
      'fa': 'Persian',
      'pl': 'Polish',
      'pt': 'Portuguese',
      'ru': 'Russian',
      'es': 'Spanish',
      'sw': 'Swahili',
      'sv': 'Swedish',
      'th': 'Thai',
      'tr': 'Turkish',
      'uk': 'Ukrainian',
      'ur': 'Urdu',
      'vi': 'Vietnamese',
      'zu': 'Zulu',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CodeableColors.lightBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  country.flagImagePath,
                  width: 32,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    displayName(country),
                    style: const TextStyle(
                      color: CodeableColors.lightText,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${CountryUtils.getSupportedLocales().length} languages available',
              style: const TextStyle(
                fontSize: 13,
                color: CodeableColors.lightTextMuted,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.separated(
            itemCount: showcaseLanguages.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: CodeableColors.lightDivider,
            ),
            itemBuilder: (context, index) {
              final langCode = showcaseLanguages.keys.elementAt(index);
              final langName = showcaseLanguages.values.elementAt(index);
              final translatedName = CountryUtils.getCountryNameInLanguage(
                country,
                langCode,
              );
              final isRtl = langCode == 'ar' ||
                  langCode == 'he' ||
                  langCode == 'fa' ||
                  langCode == 'ur';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CodeableColors.blueSubtle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        langCode,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: CodeableColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            langName,
                            style: const TextStyle(
                              fontSize: 11,
                              color: CodeableColors.lightTextMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            translatedName,
                            textDirection:
                                isRtl ? TextDirection.rtl : TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: CodeableColors.lightText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: CodeableColors.blue,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // ─── Data Methods ─────────────────────────────────────────────────
  void _showCountryData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CodeableColors.lightBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Country Data Examples',
          style: TextStyle(
            color: CodeableColors.lightText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogInfoRow('Total Countries',
                  '${CountryUtils.getAllCountries().length}'),
              _dialogInfoRow(
                  'Regions', CountryUtils.getAllRegions().join(', ')),
              _dialogInfoRow('Most Populous',
                  CountryUtils.getMostPopulousCountry()?.name ?? 'N/A'),
              _dialogInfoRow('Largest by Area',
                  CountryUtils.getLargestCountry()?.name ?? 'N/A'),
              _dialogInfoRow('European Countries',
                  '${CountryUtils.getCountriesByRegion('Europe').length}'),
              _dialogInfoRow('Asian Countries',
                  '${CountryUtils.getCountriesByRegion('Asia').length}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: CodeableColors.blue,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCountryStatistics() {
    final countries = CountryUtils.getAllCountries();
    final totalPopulation =
        countries.fold<int>(0, (sum, country) => sum + country.population);
    final totalArea =
        countries.fold<double>(0, (sum, country) => sum + country.area);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CodeableColors.lightBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Country Statistics',
          style: TextStyle(
            color: CodeableColors.lightText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogInfoRow('Total Countries', '${countries.length}'),
              _dialogInfoRow('Total Population',
                  CountryUtils.formatPopulation(totalPopulation)),
              _dialogInfoRow('Total Area', CountryUtils.formatArea(totalArea)),
              _dialogInfoRow(
                  'Avg Population',
                  CountryUtils.formatPopulation(
                      totalPopulation ~/ countries.length)),
              _dialogInfoRow('Avg Area',
                  CountryUtils.formatArea(totalArea / countries.length)),
              _dialogInfoRow(
                  'Regions', '${CountryUtils.getAllRegions().length}'),
              _dialogInfoRow('With Phone Codes',
                  '${countries.where((c) => c.callingCodes.isNotEmpty).length}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: CodeableColors.blue,
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _dialogInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 7),
            decoration: const BoxDecoration(
              color: CodeableColors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CodeableColors.lightTextSecondary,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: CodeableColors.lightText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
