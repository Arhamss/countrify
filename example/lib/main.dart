import 'package:countrify/countrify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const CountrifyExampleApp());

// ═══════════════════════════════════════════════════════════════════════════
// Design Tokens
// ═══════════════════════════════════════════════════════════════════════════

class _C {
  _C._();
  // Primary palette
  static const indigo = Color(0xFF4F46E5);
  static const indigoSubtle = Color(0xFFEEF2FF);

  // Accent
  static const teal = Color(0xFF0D9488);
  static const tealSubtle = Color(0xFFCCFBF1);

  // Neutrals
  static const slate900 = Color(0xFF0F172A);
  static const slate700 = Color(0xFF334155);
  static const slate500 = Color(0xFF64748B);
  static const slate400 = Color(0xFF94A3B8);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate50 = Color(0xFFF8FAFC);
  static const white = Colors.white;

  // Surfaces
  static const cardBg = Colors.white;
  static const scaffoldBg = Color(0xFFF8FAFC);
}

// ═══════════════════════════════════════════════════════════════════════════
// App Root
// ═══════════════════════════════════════════════════════════════════════════

class CountrifyExampleApp extends StatelessWidget {
  const CountrifyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countrify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: _C.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: _C.scaffoldBg,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Home — Tab Navigation
// ═══════════════════════════════════════════════════════════════════════════

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabs = [
    _TabItem(icon: Icons.phone_outlined, label: 'Phone'),
    _TabItem(icon: Icons.public_outlined, label: 'Country'),
    _TabItem(icon: Icons.location_city_outlined, label: 'Address'),
    _TabItem(icon: Icons.palette_outlined, label: 'Themes'),
    _TabItem(icon: Icons.translate_outlined, label: 'i18n'),
    _TabItem(icon: Icons.widgets_outlined, label: 'Blocks'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      backgroundColor: _C.scaffoldBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0.5,
            backgroundColor: _C.white,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 24, bottom: 56),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_C.indigo, _C.teal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.public,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Countrify',
                    style: TextStyle(
                      color: _C.slate900,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: Container(
                decoration: const BoxDecoration(
                  color: _C.white,
                  border: Border(
                    bottom: BorderSide(color: _C.slate200, width: 1),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: const EdgeInsets.only(left: 16),
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.5,
                  indicatorColor: _C.indigo,
                  labelColor: _C.indigo,
                  unselectedLabelColor: _C.slate400,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  tabs: _tabs
                      .map((t) => Tab(
                            height: 44,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(t.icon, size: 16),
                                const SizedBox(width: 6),
                                Text(t.label),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            PhoneInputTab(),
            CountryPickerTab(),
            AddressTab(),
            ThemingTab(),
            LocalizationTab(),
            BuildingBlocksTab(),
          ],
        ),
      ),
    ),
    );
  }
}

class _TabItem {
  const _TabItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared UI Components
// ═══════════════════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.icon,
  });
  final String title;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: _C.indigoSubtle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: _C.indigo),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _C.slate900,
              letterSpacing: -0.4,
              height: 1.2,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 14,
                color: _C.slate500,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.child,
    this.padding,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _C.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.slate200.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: _C.slate900.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.icon,
  });
  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: _C.slate400),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: _C.slate500,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: _C.slate900,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 1: Phone Input
// ═══════════════════════════════════════════════════════════════════════════

class PhoneInputTab extends StatefulWidget {
  const PhoneInputTab({super.key});

  @override
  State<PhoneInputTab> createState() => _PhoneInputTabState();
}

class _PhoneInputTabState extends State<PhoneInputTab> {
  String _phoneNumber = '';
  String _countryName = 'United States';
  String _dialCode = '+1';
  String _countryEmoji = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      children: [
        const _SectionHeader(
          icon: Icons.phone_outlined,
          title: 'Phone Number Input',
          subtitle:
              'A complete phone input with country code picker, validation, and formatting.',
        ),
        _ShowcaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhoneNumberField(
                initialCountryCode: CountryCode.us,
                style: CountrifyFieldStyle.defaultStyle().copyWith(
                  fillColor: _C.slate50,
                  focusedFillColor: _C.indigoSubtle,
                  hintText: 'Enter phone number',
                  cursorColor: _C.indigo,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: _C.indigo, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: _C.slate200, width: 1),
                  ),
                ),
                onChanged: (phoneNumber, country) {
                  setState(() {
                    _phoneNumber = phoneNumber;
                    _countryName = country.name;
                    _dialCode = '+${country.callingCodes.first}';
                    _countryEmoji = country.flagEmoji;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _C.slate50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 14, color: _C.slate400),
                        SizedBox(width: 6),
                        Text(
                          'Current Value',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _C.slate400,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.flag_outlined,
                      label: 'Country',
                      value: '$_countryEmoji $_countryName',
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.dialpad,
                      label: 'Number',
                      value: _phoneNumber.isEmpty
                          ? _dialCode
                          : '$_dialCode $_phoneNumber',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const _SectionHeader(
          title: 'Field Styles',
          subtitle: 'Pre-built style variants for different design needs.',
        ),
        _ShowcaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStyleLabel('Filled Style'),
              const SizedBox(height: 8),
              PhoneNumberField(
                initialCountryCode: CountryCode.gb,
                style: CountrifyFieldStyle.filledStyle(
                  fillColor: _C.slate100,
                  focusedBorderColor: _C.teal,
                ).copyWith(
                  hintText: 'Filled variant',
                  cursorColor: _C.teal,
                ),
                onChanged: (_, __) {},
              ),
              const SizedBox(height: 20),
              _buildStyleLabel('Outline Style'),
              const SizedBox(height: 8),
              PhoneNumberField(
                initialCountryCode: CountryCode.jp,
                style: CountrifyFieldStyle.outlineStyle(
                  borderColor: _C.slate200,
                  focusedBorderColor: _C.indigo,
                ).copyWith(
                  hintText: 'Outline variant',
                  cursorColor: _C.indigo,
                ),
                onChanged: (_, __) {},
              ),
              const SizedBox(height: 20),
              _buildStyleLabel('Dark Style'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: PhoneNumberField(
                  initialCountryCode: CountryCode.br,
                  style: CountrifyFieldStyle.darkStyle().copyWith(
                    hintText: 'Dark variant',
                  ),
                  onChanged: (_, __) {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleLabel(String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _C.teal,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _C.slate500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 2: Country Picker
// ═══════════════════════════════════════════════════════════════════════════

class CountryPickerTab extends StatefulWidget {
  const CountryPickerTab({super.key});

  @override
  State<CountryPickerTab> createState() => _CountryPickerTabState();
}

class _CountryPickerTabState extends State<CountryPickerTab> {
  String _selectedCountry = 'None';
  String _selectedFlag = '';
  CountryPickerMode _pickerMode = CountryPickerMode.bottomSheet;

  static const _modes = {
    CountryPickerMode.dropdown: ('Dropdown', Icons.arrow_drop_down_circle_outlined),
    CountryPickerMode.bottomSheet: ('Sheet', Icons.drag_handle_rounded),
    CountryPickerMode.dialog: ('Dialog', Icons.picture_in_picture_outlined),
    CountryPickerMode.fullScreen: ('Full', Icons.fullscreen_outlined),
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      children: [
        const _SectionHeader(
          icon: Icons.public_outlined,
          title: 'Country Picker',
          subtitle:
              'Choose from four display modes. Tap a mode below to switch.',
        ),
        // Mode selector
        _ShowcaseCard(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: _modes.entries.map((e) {
              final isSelected = _pickerMode == e.key;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _pickerMode = e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? _C.indigo : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            e.value.$2,
                            size: 20,
                            color: isSelected
                                ? _C.white
                                : _C.slate400,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            e.value.$1,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? _C.white
                                  : _C.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        _ShowcaseCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CountryDropdownField(
                key: ValueKey(_pickerMode),
                pickerMode: _pickerMode,
                style: CountrifyFieldStyle.defaultStyle().copyWith(
                  labelText: 'Select a country',
                  fillColor: _C.slate50,
                  focusedFillColor: _C.indigoSubtle,
                  cursorColor: _C.indigo,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _C.slate200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: _C.indigo, width: 1.5),
                  ),
                ),
                onChanged: (country) {
                  setState(() {
                    _selectedCountry = country.name;
                    _selectedFlag = country.flagEmoji;
                  });
                },
              ),
              if (_selectedCountry != 'None') ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: _C.tealSubtle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle,
                          size: 16, color: _C.teal),
                      const SizedBox(width: 8),
                      Text(
                        '$_selectedFlag  $_selectedCountry',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _C.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 3: Address (Country → State → City)
// ═══════════════════════════════════════════════════════════════════════════

class AddressTab extends StatefulWidget {
  const AddressTab({super.key});

  @override
  State<AddressTab> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  CountryStateCitySelection? _selection;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      children: [
        const _SectionHeader(
          icon: Icons.location_city_outlined,
          title: 'Cascading Address',
          subtitle:
              'Country, state, and city pickers that cascade automatically.',
        ),
        _ShowcaseCard(
          child: CountryStateCityField(
            initialCountryCode: CountryCode.us,
            spacing: 14,
            fieldStyle: CountrifyFieldStyle.defaultStyle().copyWith(
              fillColor: _C.slate50,
              focusedFillColor: _C.indigoSubtle,
              cursorColor: _C.indigo,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _C.slate200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: _C.indigo, width: 1.5),
              ),
            ),
            onChanged: (sel) => setState(() => _selection = sel),
          ),
        ),
        if (_selection != null) ...[
          const SizedBox(height: 16),
          _ShowcaseCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.pin_drop_outlined,
                        size: 14, color: _C.slate400),
                    SizedBox(width: 6),
                    Text(
                      'Selection',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _C.slate400,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildSelectionRow(
                  'Country',
                  _selection!.country?.name,
                  _selection!.country?.flagEmoji,
                ),
                const SizedBox(height: 6),
                _buildSelectionRow(
                    'State', _selection!.state?.name, null),
                const SizedBox(height: 6),
                _buildSelectionRow(
                    'City', _selection!.city?.name, null),
                if (_selection!.isComplete) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: _C.tealSubtle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle,
                            size: 14, color: _C.teal),
                        SizedBox(width: 6),
                        Text(
                          'Address complete',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _C.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSelectionRow(
      String label, String? value, String? flag) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: _C.slate400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (flag != null) ...[
          Text(flag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            value ?? '--',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: value != null ? _C.slate900 : _C.slate400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 4: Theming
// ═══════════════════════════════════════════════════════════════════════════

class ThemingTab extends StatefulWidget {
  const ThemingTab({super.key});

  @override
  State<ThemingTab> createState() => _ThemingTabState();
}

class _ThemingTabState extends State<ThemingTab> {
  int _selectedTheme = 0;

  static const _themes = [
    _ThemeOption(
      label: 'Default',
      icon: Icons.light_mode_outlined,
      desc: 'Clean light theme',
      color: Color(0xFF2196F3),
      bgColor: Colors.white,
    ),
    _ThemeOption(
      label: 'Dark',
      icon: Icons.dark_mode_outlined,
      desc: 'For dark interfaces',
      color: Color(0xFF64B5F6),
      bgColor: Color(0xFF1E1E1E),
    ),
    _ThemeOption(
      label: 'Material 3',
      icon: Icons.auto_awesome_outlined,
      desc: 'Google M3 tokens',
      color: Color(0xFF6750A4),
      bgColor: Color(0xFFFFFBFE),
    ),
    _ThemeOption(
      label: 'Custom',
      icon: Icons.tune_outlined,
      desc: 'Teal accent',
      color: _C.teal,
      bgColor: Colors.white,
    ),
  ];

  CountryPickerTheme get _currentTheme {
    switch (_selectedTheme) {
      case 1:
        return CountryPickerTheme.darkTheme();
      case 2:
        return CountryPickerTheme.material3Theme();
      case 3:
        return CountryPickerTheme.custom(primaryColor: _C.teal);
      default:
        return CountryPickerTheme.defaultTheme();
    }
  }

  CountrifyFieldStyle get _currentFieldStyle {
    if (_selectedTheme == 1) {
      return CountrifyFieldStyle.darkStyle()
          .copyWith(hintText: 'Themed phone field');
    }
    return CountrifyFieldStyle.defaultStyle().copyWith(
      hintText: 'Themed phone field',
      fillColor: _themes[_selectedTheme].bgColor,
      focusedFillColor: _themes[_selectedTheme]
          .color
          .withValues(alpha: 0.08),
      cursorColor: _themes[_selectedTheme].color,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: _themes[_selectedTheme].color, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = _themes[_selectedTheme];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      children: [
        const _SectionHeader(
          icon: Icons.palette_outlined,
          title: 'Theme Gallery',
          subtitle:
              'Pre-built themes and custom theme support. Tap to preview.',
        ),
        // Theme cards grid
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.55,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(_themes.length, (i) {
            final t = _themes[i];
            final isSelected = _selectedTheme == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedTheme = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _C.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? t.color : _C.slate200,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: t.color.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: t.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(t.icon,
                              size: 16, color: t.color),
                        ),
                        const Spacer(),
                        if (isSelected)
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: t.color,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check,
                                size: 12, color: Colors.white),
                          ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      t.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _C.slate900,
                      ),
                    ),
                    Text(
                      t.desc,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _C.slate400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        // Preview
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _selectedTheme == 1
                ? const Color(0xFF1A1A2E)
                : _C.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _selectedTheme == 1
                  ? const Color(0xFF2D2D4A)
                  : _C.slate200.withValues(alpha: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.color.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Preview',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _selectedTheme == 1
                          ? Colors.white60
                          : _C.slate400,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PhoneNumberField(
                key: ValueKey(_selectedTheme),
                initialCountryCode: CountryCode.us,
                theme: _currentTheme,
                style: _currentFieldStyle,
                onChanged: (phone, country) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeOption {
  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.desc,
    required this.color,
    required this.bgColor,
  });
  final String label;
  final IconData icon;
  final String desc;
  final Color color;
  final Color bgColor;
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 5: Localization
// ═══════════════════════════════════════════════════════════════════════════

class LocalizationTab extends StatefulWidget {
  const LocalizationTab({super.key});

  @override
  State<LocalizationTab> createState() => _LocalizationTabState();
}

class _LocalizationTabState extends State<LocalizationTab> {
  String _selectedLocale = 'en';

  static const _locales = <String, (String, String)>{
    'en': ('English', 'EN'),
    'ar': ('Arabic', 'AR'),
    'fr': ('French', 'FR'),
    'es': ('Spanish', 'ES'),
    'de': ('German', 'DE'),
    'zh': ('Chinese', 'ZH'),
    'ja': ('Japanese', 'JA'),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                icon: Icons.translate_outlined,
                title: 'Localization',
                subtitle:
                    'Country names translated into 7 languages.',
              ),
              // Language chips
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _locales.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final entry =
                        _locales.entries.elementAt(i);
                    final isSelected =
                        _selectedLocale == entry.key;
                    return GestureDetector(
                      onTap: () => setState(
                          () => _selectedLocale = entry.key),
                      child: AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _C.indigo
                              : _C.white,
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? _C.indigo
                                : _C.slate200,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: _C.indigo
                                        .withValues(alpha: 0.2),
                                    blurRadius: 6,
                                    offset:
                                        const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              entry.value.$2,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? _C.white
                                        .withValues(alpha: 0.7)
                                    : _C.slate400,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              entry.value.$1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? _C.white
                                    : _C.slate700,
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
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: _C.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: _C.slate200.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: _C.slate900.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CountryPicker(
                key: ValueKey(_selectedLocale),
                pickerType: CountryPickerType.inline,
                config: CountryPickerConfig(
                  locale: _selectedLocale,
                ),
                onCountrySelected: (country) {
                  debugPrint('Selected: ${country.name}');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Tab 6: Building Blocks
// ═══════════════════════════════════════════════════════════════════════════

class BuildingBlocksTab extends StatefulWidget {
  const BuildingBlocksTab({super.key});

  @override
  State<BuildingBlocksTab> createState() => _BuildingBlocksTabState();
}

class _BuildingBlocksTabState extends State<BuildingBlocksTab> {
  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryUtils.getCountryByCode(CountryCode.us)!;
  }

  @override
  Widget build(BuildContext context) {
    final us = CountryUtils.getCountryByCode(CountryCode.us)!;
    final gb = CountryUtils.getCountryByCode(CountryCode.gb)!;
    final jp = CountryUtils.getCountryByCode(CountryCode.jp)!;
    final br = CountryUtils.getCountryByCode(CountryCode.br)!;
    final de = CountryUtils.getCountryByCode(CountryCode.de)!;
    final fr = CountryUtils.getCountryByCode(CountryCode.fr)!;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
      children: [
        const _SectionHeader(
          icon: Icons.widgets_outlined,
          title: 'Building Blocks',
          subtitle:
              'Individual components you can use independently.',
        ),

        // Flags
        _buildBlockLabel('CountryFlag'),
        const SizedBox(height: 10),
        _ShowcaseCard(
          child: Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [us, gb, jp, br, de, fr].map((c) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CountryFlag(
                        country: c,
                        size: const Size(48, 34),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.alpha2Code,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _C.slate400,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 28),

        // Search bar
        _buildBlockLabel('CountrySearchBar'),
        const SizedBox(height: 10),
        _ShowcaseCard(
          child: CountrySearchBar(
            hintText: 'Search countries...',
            onChanged: (query) => debugPrint('Search: $query'),
          ),
        ),

        const SizedBox(height: 28),

        // List tiles
        _buildBlockLabel('CountryListTile'),
        const SizedBox(height: 10),
        _ShowcaseCard(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 8),
          child: Column(
            children: [us, gb, jp, br].map((c) {
              return CountryListTile(
                country: c,
                isSelected:
                    _selectedCountry.alpha2Code == c.alpha2Code,
                onTap: (country) =>
                    setState(() => _selectedCountry = country),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 28),

        // Phone Code Picker
        _buildBlockLabel('PhoneCodePicker'),
        const SizedBox(height: 10),
        _ShowcaseCard(
          child: PhoneCodePicker(
            initialCountryCode: CountryCode.us,
            onChanged: (country) {
              debugPrint(
                  'Code: +${country.callingCodes.first}');
            },
          ),
        ),
      ],
    );
  }

  static Widget _buildBlockLabel(String text) {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _C.indigoSubtle,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _C.indigo,
              letterSpacing: 0.3,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}
