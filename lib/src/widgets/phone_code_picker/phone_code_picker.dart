import 'dart:async';
import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/country_picker_config.dart'
    as picker_config;
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/shared/country_list_tile.dart';

/// {@template phone_code_picker}
/// A specialized country picker for phone code selection with modern UI
/// {@endtemplate}
class PhoneCodePicker extends StatefulWidget {
  /// {@macro phone_code_picker}
  const PhoneCodePicker({
    super.key,
    this.initialCountryCode,
    this.onChanged,
    this.onCountryChanged,
    this.theme,
    this.config,
    this.showFlag = true,
    this.showCountryName = true,
    this.showDialCode = true,
    this.flagSize = const Size(24, 18),
    this.flagShape = picker_config.FlagShape.rectangular,
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.flagBorderColor,
    this.flagBorderWidth = 1.0,
    this.flagShadowColor,
    this.flagShadowBlur = 2.0,
    this.flagShadowOffset = const Offset(0, 1),
    this.hapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.debounceDuration = const Duration(milliseconds: 300),
    this.searchEnabled = true,
    this.filterEnabled = false,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.isDismissible = true,
    this.enableDrag = true,
    this.isScrollControlled = true,
    this.useRootNavigator = false,
    this.useSafeArea = true,
    this.barrierColor,
    this.barrierLabel,
    this.barrierDismissible = true,
    this.routeSettings,
  });

  /// Initial selected country by enum code.
  final CountryCode? initialCountryCode;

  /// Callback when a country is selected
  final ValueChanged<Country>? onChanged;

  /// Callback when country selection changes during browsing
  final ValueChanged<Country>? onCountryChanged;

  /// Theme configuration
  final CountryPickerTheme? theme;

  /// Configuration options
  final picker_config.CountryPickerConfig? config;

  /// Whether to show flag
  final bool showFlag;

  /// Whether to show country name
  final bool showCountryName;

  /// Whether to show dial code
  final bool showDialCode;

  /// Size of the flag
  final Size flagSize;

  /// Shape of the flag
  final picker_config.FlagShape flagShape;

  /// Border radius of the flag
  final BorderRadius flagBorderRadius;

  /// Border color of the flag
  final Color? flagBorderColor;

  /// Border width of the flag
  final double flagBorderWidth;

  /// Shadow color of the flag
  final Color? flagShadowColor;

  /// Shadow blur radius of the flag
  final double flagShadowBlur;

  /// Shadow offset of the flag
  final Offset flagShadowOffset;

  /// Whether to provide haptic feedback
  final bool hapticFeedback;

  /// Animation duration
  final Duration animationDuration;

  /// Debounce duration for search
  final Duration debounceDuration;

  /// Whether search is enabled
  final bool searchEnabled;

  /// Whether filtering is enabled
  final bool filterEnabled;

  /// Mode of picker to display
  final CountryPickerMode pickerMode;

  /// Whether the picker is dismissible
  final bool isDismissible;

  /// Whether drag is enabled
  final bool enableDrag;

  /// Whether scroll is controlled
  final bool isScrollControlled;

  /// Whether to use root navigator
  final bool useRootNavigator;

  /// Whether to use safe area
  final bool useSafeArea;

  /// Barrier color
  final Color? barrierColor;

  /// Barrier label
  final String? barrierLabel;

  /// Whether barrier is dismissible
  final bool barrierDismissible;

  /// Route settings
  final RouteSettings? routeSettings;

  @override
  State<PhoneCodePicker> createState() => _PhoneCodePickerState();
}

class _PhoneCodePickerState extends State<PhoneCodePicker>
    with TickerProviderStateMixin {
  Country? _selectedCountry;
  String _searchQuery = '';
  List<Country> _filteredCountries = [];
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _debounceTimer;

  late String _effectiveLocale;

  bool get _effectiveSearchEnabled =>
      widget.searchEnabled && (widget.config?.enableSearch ?? true);

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryUtils.resolveInitialCountry(
      initialCountryCode: widget.initialCountryCode,
    );
    _effectiveLocale =
        (widget.config ?? const picker_config.CountryPickerConfig()).locale ??
            'en';
    _searchController = TextEditingController();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadCountries();
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =
        (widget.config ?? const picker_config.CountryPickerConfig()).locale ??
            Localizations.localeOf(context).languageCode;
    if (locale != _effectiveLocale) {
      _effectiveLocale = locale;
      _loadCountries();
    }
  }

  @override
  void didUpdateWidget(PhoneCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountryCode != oldWidget.initialCountryCode) {
      setState(() {
        _selectedCountry = CountryUtils.resolveInitialCountry(
          initialCountryCode: widget.initialCountryCode,
        );
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  String _displayName(Country country) {
    if (_effectiveLocale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, _effectiveLocale);
  }

  void _loadCountries() {
    setState(() {
      _filteredCountries = _getFilteredCountries();
    });
  }

  List<Country> _getFilteredCountries() {
    var countries = CountryUtils.getAllCountries();

    // Filter countries with calling codes
    countries =
        countries.where((country) => country.callingCodes.isNotEmpty).toList();

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      countries = countries.where((country) {
        final query = _searchQuery.toLowerCase();
        return _displayName(country).toLowerCase().contains(query) ||
            country.name.toLowerCase().contains(query) ||
            country.alpha2Code.toLowerCase().contains(query) ||
            country.alpha3Code.toLowerCase().contains(query) ||
            country.callingCodes.any((code) => code.contains(query));
      }).toList();
    }

    // Sort by display name
    countries.sort((a, b) => _displayName(a).compareTo(_displayName(b)));

    return countries;
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      setState(() {
        _searchQuery = query;
        _loadCountries();
      });
    });
  }

  void _onCountrySelected(Country country) {
    if (widget.pickerMode == CountryPickerMode.none) return;

    if (widget.hapticFeedback) {
      HapticFeedback.lightImpact();
    }

    setState(() {
      _selectedCountry = country;
    });

    widget.onChanged?.call(country);
    widget.onCountryChanged?.call(country);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? CountryPickerTheme.defaultTheme();
    final config = widget.config ?? const picker_config.CountryPickerConfig();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildPickerContent(theme, config),
    );
  }

  Widget _buildPickerContent(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    switch (widget.pickerMode) {
      case CountryPickerMode.bottomSheet:
        return _buildBottomSheetPicker(theme, config);
      case CountryPickerMode.dialog:
        return _buildDialogPicker(theme, config);
      case CountryPickerMode.fullScreen:
        return _buildFullScreenPicker(theme, config);
      case CountryPickerMode.dropdown:
        return _buildDropdownPicker(theme, config);
      case CountryPickerMode.none:
        return _buildReadOnlyPicker(theme, config);
    }
  }

  Widget _buildBottomSheetPicker(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(theme, config),
          if (_effectiveSearchEnabled) _buildSearchBar(theme, config),
          Expanded(child: _buildCountryList(theme, config)),
        ],
      ),
    );
  }

  Widget _buildDialogPicker(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Dialog(
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            theme.borderRadius ?? const BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            _buildHeader(theme, config),
            if (_effectiveSearchEnabled) _buildSearchBar(theme, config),
            Expanded(child: _buildCountryList(theme, config)),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenPicker(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.headerColor,
        title: Text(
          config.titleText,
          style: theme.appBarTitleTextStyle ?? theme.headerTextStyle,
        ),
        leading: IconButton(
          icon: Icon(theme.closeIcon ?? CountrifyIcons.x,
              color: theme.headerIconColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          if (_effectiveSearchEnabled) _buildSearchBar(theme, config),
          Expanded(child: _buildCountryList(theme, config)),
        ],
      ),
    );
  }

  Widget _buildDropdownPicker(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius:
            theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: theme.borderColor ?? Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Country>(
          value: _selectedCountry,
          isExpanded: true,
          items: _filteredCountries.map((country) {
            return DropdownMenuItem<Country>(
              value: country,
              child: _buildCountryItem(country, theme, config),
            );
          }).toList(),
          onChanged: widget.pickerMode == CountryPickerMode.none
              ? null
              : (country) {
                  if (country != null) {
                    _onCountrySelected(country);
                  }
                },
        ),
      ),
    );
  }

  Widget _buildHeader(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.headerColor,
        borderRadius: theme.borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Text(
            config.titleText,
            style: theme.headerTextStyle,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(theme.closeIcon ?? CountrifyIcons.x,
                color: theme.headerIconColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    final effectiveBorderRadius = theme.searchBarBorderRadius ??
        const BorderRadius.all(Radius.circular(12));
    final effectiveDecoration = theme.searchInputDecoration ??
        InputDecoration(
          hintText: theme.searchHintText ?? config.searchHintText,
          hintStyle: theme.searchHintStyle,
          prefixIcon: Icon(theme.searchIcon ?? CountrifyIcons.search,
              color: theme.searchIconColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(theme.clearIcon ?? CountrifyIcons.circleX,
                      color: theme.searchIconColor),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: theme.searchBarColor,
          contentPadding: theme.searchContentPadding,
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchFocusedBorderColor ??
                    theme.searchBarBorderColor ??
                    Colors.blue),
          ),
        );

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: theme.searchTextStyle,
        cursorColor: theme.searchCursorColor,
        decoration: effectiveDecoration,
      ),
    );
  }

  Widget _buildCountryList(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    if (_filteredCountries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(theme.emptyStateIcon ?? CountrifyIcons.searchX,
                size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              config.emptyStateText,
              style:
                  theme.readOnlyHintTextStyle ?? theme.countrySubtitleTextStyle,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return _buildCountryItem(country, theme, config);
      },
    );
  }

  Widget _buildCountryItem(Country country, CountryPickerTheme theme,
      picker_config.CountryPickerConfig config) {
    final isSelected = _selectedCountry?.alpha2Code == country.alpha2Code;

    return CountryListTile(
      country: country,
      onTap: widget.pickerMode == CountryPickerMode.none
          ? (_) {}
          : _onCountrySelected,
      isSelected: isSelected,
      showFlag: widget.showFlag,
      showCountryName: widget.showCountryName,
      showDialCode: widget.showDialCode,
      flagSize: widget.flagSize,
      flagBorderRadius: widget.flagBorderRadius,
      countryNameStyle: theme.countryNameTextStyle,
      dialCodeStyle: theme.countrySubtitleTextStyle,
      selectedColor: theme.countryItemSelectedColor,
      selectedIconColor: theme.countryItemSelectedIconColor,
      selectedIcon: theme.selectedIcon ?? CountrifyIcons.circleCheckBig,
      displayName: _displayName(country),
    );
  }

  Widget _buildReadOnlyPicker(
      CountryPickerTheme theme, picker_config.CountryPickerConfig config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius:
            theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: theme.borderColor ?? Colors.grey.shade300),
      ),
      child: _selectedCountry == null
          ? Text(
              config.selectCountryHintText,
              style: theme.readOnlyHintTextStyle ?? theme.countryNameTextStyle,
            )
          : _buildCountryItem(_selectedCountry!, theme, config),
    );
  }
}
