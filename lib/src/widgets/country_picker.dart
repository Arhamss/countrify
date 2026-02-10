import 'dart:async';
import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/data/all_countries.dart';

/// {@template country_picker_theme}
/// Theme configuration for the country picker
/// {@endtemplate}
class CountryPickerTheme {
  /// {@macro country_picker_theme}
  const CountryPickerTheme({
    this.backgroundColor,
    this.searchBarColor,
    this.searchBarBorderColor,
    this.searchBarBorderRadius,
    this.searchBarPadding,
    this.searchBarTextStyle,
    this.searchBarHintStyle,
    this.searchBarIconColor,
    this.searchHintText,
    this.searchCursorColor,
    this.searchFocusedBorderColor,
    this.searchInputDecoration,
    this.countryItemBackgroundColor,
    this.countryItemSelectedColor,
    this.countryItemBorderRadius,
    this.countryItemPadding,
    this.countryNameStyle,
    this.countryCodeStyle,
    this.flagSize,
    this.flagBorderRadius,
    this.dividerColor,
    this.dividerHeight,
    this.emptyStateTextStyle,
    this.emptyStateIconColor,
    this.loadingIndicatorColor,
    this.scrollbarColor,
    this.scrollbarThickness,
    this.scrollbarRadius,
    this.closeIcon,
    this.searchIcon,
    this.clearIcon,
    this.selectedIcon,
    this.emptyStateIcon,
  });

  /// Background color of the picker
  final Color? backgroundColor;

  /// Search bar background color
  final Color? searchBarColor;

  /// Search bar border color
  final Color? searchBarBorderColor;

  /// Search bar border radius
  final BorderRadius? searchBarBorderRadius;

  /// Search bar padding
  final EdgeInsets? searchBarPadding;

  /// Search bar text style
  final TextStyle? searchBarTextStyle;

  /// Search bar hint text style
  final TextStyle? searchBarHintStyle;

  /// Search bar icon color
  final Color? searchBarIconColor;

  /// Country item background color
  final Color? countryItemBackgroundColor;

  /// Country item selected background color
  final Color? countryItemSelectedColor;

  /// Country item border radius
  final BorderRadius? countryItemBorderRadius;

  /// Country item padding
  final EdgeInsets? countryItemPadding;

  /// Country name text style
  final TextStyle? countryNameStyle;

  /// Country code text style
  final TextStyle? countryCodeStyle;

  /// Flag size
  final Size? flagSize;

  /// Flag border radius
  final BorderRadius? flagBorderRadius;

  /// Divider color
  final Color? dividerColor;

  /// Divider height
  final double? dividerHeight;

  /// Empty state text style
  final TextStyle? emptyStateTextStyle;

  /// Empty state icon color
  final Color? emptyStateIconColor;

  /// Loading indicator color
  final Color? loadingIndicatorColor;

  /// Scrollbar color
  final Color? scrollbarColor;

  /// Scrollbar thickness
  final double? scrollbarThickness;

  /// Scrollbar radius
  final BorderRadius? scrollbarRadius;

  /// Icon for close buttons. Defaults to [CountrifyIcons.x].
  final IconData? closeIcon;

  /// Icon for the search field prefix. Defaults to [CountrifyIcons.search].
  final IconData? searchIcon;

  /// Icon for the search field clear button. Defaults to [CountrifyIcons.circleX].
  final IconData? clearIcon;

  /// Icon shown on the selected country item. Defaults to [CountrifyIcons.circleCheckBig].
  final IconData? selectedIcon;

  /// Icon shown in the empty search state. Defaults to [CountrifyIcons.searchX].
  final IconData? emptyStateIcon;

  /// Search bar hint text (defaults to 'Search countries...')
  final String? searchHintText;

  /// Search bar cursor color
  final Color? searchCursorColor;

  /// Search bar focused border color
  final Color? searchFocusedBorderColor;

  /// Full custom InputDecoration for the search field.
  /// When provided, this overrides all other search styling properties.
  final InputDecoration? searchInputDecoration;
}

/// {@template country_picker_config}
/// Configuration for the country picker behavior
/// {@endtemplate}
class CountryPickerConfig {
  /// {@macro country_picker_config}
  const CountryPickerConfig({
    this.locale,
    this.showSearchBar = true,
    this.showCountryCode = true,
    this.showFlag = true,
    this.showDialCode = false,
    this.showCapital = false,
    this.showRegion = false,
    this.showSubregion = false,
    this.showPopulation = false,
    this.showArea = false,
    this.showCurrencies = false,
    this.showLanguages = false,
    this.showTimezones = false,
    this.showBorders = false,
    this.showIndependenceStatus = false,
    this.showUnMemberStatus = false,
    this.titleText = 'Select Country',
    this.searchHint = 'Search countries...',
    this.emptyStateMessage = 'No countries found',
    this.selectCountryHintText = 'Select a country',
    this.groupByRegion = false,
    this.groupBySubregion = false,
    this.sortByName = true,
    this.sortByPopulation = false,
    this.sortByArea = false,
    this.filterIndependentOnly = false,
    this.filterUnMembersOnly = false,
    this.excludeRegions = const [],
    this.excludeSubregions = const [],
    this.includeRegions = const [],
    this.includeSubregions = const [],
    this.customCountries = const [],
    this.maxHeight,
    this.itemHeight = 60.0,
    this.searchDebounceMs = 300,
    this.enableScrollbar = true,
    this.enableDivider = true,
    this.enableRipple = true,
    this.enableHapticFeedback = true,
  });

  /// Locale code for displaying country names in a specific language.
  ///
  /// When set, all country names are displayed in the specified language.
  /// When `null` (default), English names are used.
  final String? locale;

  /// Whether to show the search bar
  final bool showSearchBar;

  /// Whether to show country codes
  final bool showCountryCode;

  /// Whether to show flags
  final bool showFlag;

  /// Whether to show dial codes
  final bool showDialCode;

  /// Whether to show capital
  final bool showCapital;

  /// Whether to show region
  final bool showRegion;

  /// Whether to show subregion
  final bool showSubregion;

  /// Whether to show population
  final bool showPopulation;

  /// Whether to show area
  final bool showArea;

  /// Whether to show currencies
  final bool showCurrencies;

  /// Whether to show languages
  final bool showLanguages;

  /// Whether to show timezones
  final bool showTimezones;

  /// Whether to show borders
  final bool showBorders;

  /// Whether to show independence status
  final bool showIndependenceStatus;

  /// Whether to show UN member status
  final bool showUnMemberStatus;

  /// Title text shown in the picker header (e.g. "Select Country").
  final String titleText;

  /// Search bar hint text
  final String searchHint;

  /// Empty state message
  final String emptyStateMessage;

  /// Hint text shown when no country is selected (e.g. "Select a country").
  final String selectCountryHintText;

  /// Whether to group countries by region
  final bool groupByRegion;

  /// Whether to group countries by subregion
  final bool groupBySubregion;

  /// Whether to sort by name
  final bool sortByName;

  /// Whether to sort by population
  final bool sortByPopulation;

  /// Whether to sort by area
  final bool sortByArea;

  /// Whether to filter independent countries only
  final bool filterIndependentOnly;

  /// Whether to filter UN members only
  final bool filterUnMembersOnly;

  /// Regions to exclude
  final List<String> excludeRegions;

  /// Subregions to exclude
  final List<String> excludeSubregions;

  /// Regions to include (if empty, all regions are included)
  final List<String> includeRegions;

  /// Subregions to include (if empty, all subregions are included)
  final List<String> includeSubregions;

  /// Custom list of countries to show
  final List<Country> customCountries;

  /// Maximum height of the picker
  final double? maxHeight;

  /// Height of each country item
  final double itemHeight;

  /// Search debounce time in milliseconds
  final int searchDebounceMs;

  /// Whether to enable scrollbar
  final bool enableScrollbar;

  /// Whether to enable divider between items
  final bool enableDivider;

  /// Whether to enable ripple effect
  final bool enableRipple;

  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;
}

/// {@template country_picker}
/// A beautiful and customizable country picker widget
/// {@endtemplate}
class CountryPicker extends StatefulWidget {
  /// {@macro country_picker}
  const CountryPicker({
    required this.onCountrySelected,
    super.key,
    this.theme,
    this.config = const CountryPickerConfig(),
    this.initialCountry,
    this.title,
    this.showTitle = true,
    this.titleStyle,
    this.closeButton,
    this.showCloseButton = true,
    this.onClose,
  });

  /// Callback when a country is selected
  final ValueChanged<Country> onCountrySelected;

  /// Theme configuration
  final CountryPickerTheme? theme;

  /// Configuration for behavior
  final CountryPickerConfig config;

  /// Initially selected country
  final Country? initialCountry;

  /// Title of the picker
  final String? title;

  /// Whether to show the title
  final bool showTitle;

  /// Title text style
  final TextStyle? titleStyle;

  /// Custom close button
  final Widget? closeButton;

  /// Whether to show close button
  final bool showCloseButton;

  /// Callback when close button is pressed
  final VoidCallback? onClose;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late TextEditingController _searchController;
  late List<Country> _filteredCountries;
  late List<Country> _allCountries;
  String _searchQuery = '';
  Timer? _debounceTimer;
  late String _effectiveLocale;

  /// Returns the display name for a country, respecting the locale.
  String _displayName(Country country) {
    if (_effectiveLocale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, _effectiveLocale);
  }

  @override
  void initState() {
    super.initState();
    _effectiveLocale = widget.config.locale ?? 'en';
    _searchController = TextEditingController();
    _initializeCountries();
    _filteredCountries = _allCountries;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =
        widget.config.locale ?? Localizations.localeOf(context).languageCode;
    if (locale != _effectiveLocale) {
      _effectiveLocale = locale;
      _initializeCountries();
      setState(() {
        _filteredCountries = _searchCountries(_searchQuery);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _initializeCountries() {
    if (widget.config.customCountries.isNotEmpty) {
      _allCountries = widget.config.customCountries;
    } else {
      _allCountries = AllCountries.all;
    }

    // Apply filters
    _allCountries = _applyFilters(_allCountries);

    // Apply sorting
    _allCountries = _applySorting(_allCountries);
  }

  List<Country> _applyFilters(List<Country> countries) {
    var filtered = countries;

    // Filter by independence status
    if (widget.config.filterIndependentOnly) {
      filtered = filtered.where((country) => country.isIndependent).toList();
    }

    // Filter by UN membership
    if (widget.config.filterUnMembersOnly) {
      filtered = filtered.where((country) => country.isUnMember).toList();
    }

    // Filter by regions
    if (widget.config.includeRegions.isNotEmpty) {
      filtered = filtered
          .where((country) =>
              widget.config.includeRegions.contains(country.region))
          .toList();
    } else if (widget.config.excludeRegions.isNotEmpty) {
      filtered = filtered
          .where((country) =>
              !widget.config.excludeRegions.contains(country.region))
          .toList();
    }

    // Filter by subregions
    if (widget.config.includeSubregions.isNotEmpty) {
      filtered = filtered
          .where((country) =>
              widget.config.includeSubregions.contains(country.subregion))
          .toList();
    } else if (widget.config.excludeSubregions.isNotEmpty) {
      filtered = filtered
          .where((country) =>
              !widget.config.excludeSubregions.contains(country.subregion))
          .toList();
    }

    return filtered;
  }

  List<Country> _applySorting(List<Country> countries) {
    final sorted = List<Country>.from(countries);

    if (widget.config.sortByPopulation) {
      sorted.sort((a, b) => b.population.compareTo(a.population));
    } else if (widget.config.sortByArea) {
      sorted.sort((a, b) => b.area.compareTo(a.area));
    } else if (widget.config.sortByName) {
      sorted.sort((a, b) => _displayName(a).compareTo(_displayName(b)));
    }

    return sorted;
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer =
        Timer(Duration(milliseconds: widget.config.searchDebounceMs), () {
      setState(() {
        _searchQuery = query;
        _filteredCountries = _searchCountries(query);
      });
    });
  }

  List<Country> _searchCountries(String query) {
    if (query.isEmpty) {
      return _allCountries;
    }

    final lowercaseQuery = query.toLowerCase();
    return _allCountries.where((country) {
      return _displayName(country).toLowerCase().contains(lowercaseQuery) ||
          country.name.toLowerCase().contains(lowercaseQuery) ||
          country.alpha2Code.toLowerCase().contains(lowercaseQuery) ||
          country.alpha3Code.toLowerCase().contains(lowercaseQuery) ||
          country.numericCode.contains(query) ||
          country.capital.toLowerCase().contains(lowercaseQuery) ||
          country.region.toLowerCase().contains(lowercaseQuery) ||
          country.subregion.toLowerCase().contains(lowercaseQuery) ||
          country.callingCodes.any((code) => code.contains(query)) ||
          country.nameTranslations.values.any((translation) =>
              translation.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  void _onCountrySelected(Country country) {
    if (widget.config.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    widget.onCountrySelected(country);
  }

  Widget _buildSearchBar() {
    if (!widget.config.showSearchBar) return const SizedBox.shrink();

    final theme = widget.theme;
    final config = widget.config;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme?.searchBarColor ?? Colors.grey[100],
        borderRadius: theme?.searchBarBorderRadius ?? BorderRadius.circular(12),
        border: Border.all(
          color: theme?.searchBarBorderColor ?? Colors.grey[300]!,
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        cursorColor: theme?.searchCursorColor,
        decoration: theme?.searchInputDecoration ??
            InputDecoration(
              hintText: theme?.searchHintText ?? config.searchHint,
              hintStyle: theme?.searchBarHintStyle ??
                  TextStyle(color: Colors.grey[600]),
              prefixIcon: Icon(
                theme?.searchIcon ?? CountrifyIcons.search,
                color: theme?.searchBarIconColor ?? Colors.grey[600],
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        theme?.clearIcon ?? CountrifyIcons.circleX,
                        color: theme?.searchBarIconColor ?? Colors.grey[600],
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: theme?.searchBarPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
            ),
        style: theme?.searchBarTextStyle ?? const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildCountryItem(Country country) {
    final theme = widget.theme;
    final config = widget.config;
    final isSelected = widget.initialCountry?.alpha2Code == country.alpha2Code;

    return Container(
      height: config.itemHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? (theme?.countryItemSelectedColor ?? Colors.blue[50])
            : (theme?.countryItemBackgroundColor ?? Colors.transparent),
        borderRadius:
            theme?.countryItemBorderRadius ?? BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onCountrySelected(country),
          borderRadius:
              theme?.countryItemBorderRadius ?? BorderRadius.circular(8),
          splashColor:
              config.enableRipple ? Colors.blue[100] : Colors.transparent,
          highlightColor:
              config.enableRipple ? Colors.blue[50] : Colors.transparent,
          child: Padding(
            padding: theme?.countryItemPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
            child: Row(
              children: [
                if (config.showFlag) ...[
                  _buildFlag(country),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _displayName(country),
                        style: theme?.countryNameStyle ??
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (config.showCountryCode ||
                          config.showDialCode ||
                          config.showCapital ||
                          config.showRegion) ...[
                        const SizedBox(height: 2),
                        _buildCountryDetails(country),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    theme?.selectedIcon ?? CountrifyIcons.circleCheckBig,
                    color: Colors.blue[600],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlag(Country country) {
    final theme = widget.theme;
    final flagSize = theme?.flagSize ?? const Size(32, 24);

    return Container(
      width: flagSize.width,
      height: flagSize.height,
      decoration: BoxDecoration(
        borderRadius: theme?.flagBorderRadius ?? BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: theme?.flagBorderRadius ?? BorderRadius.circular(4),
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  country.flagEmoji,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCountryDetails(Country country) {
    final config = widget.config;
    final details = <String>[];

    if (config.showCountryCode) {
      details.add(country.alpha2Code);
    }
    if (config.showDialCode && country.callingCodes.isNotEmpty) {
      details.add('+${country.callingCodes.first}');
    }
    if (config.showCapital) {
      details.add(country.capital);
    }
    if (config.showRegion) {
      details.add(country.region);
    }

    return Text(
      details.join(' • '),
      style: widget.theme?.countryCodeStyle ??
          TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEmptyState() {
    final theme = widget.theme;
    final config = widget.config;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            theme?.emptyStateIcon ?? CountrifyIcons.searchX,
            size: 64,
            color: theme?.emptyStateIconColor ?? Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            config.emptyStateMessage,
            style: theme?.emptyStateTextStyle ??
                TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesList() {
    if (_filteredCountries.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      itemCount: _filteredCountries.length,
      separatorBuilder: (context, index) {
        if (!widget.config.enableDivider) return const SizedBox.shrink();
        return Divider(
          height: widget.theme?.dividerHeight ?? 1.0,
          color: widget.theme?.dividerColor ?? Colors.grey[200],
          indent: 16,
          endIndent: 16,
        );
      },
      itemBuilder: (context, index) {
        return _buildCountryItem(_filteredCountries[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final config = widget.config;

    return Container(
      height: config.maxHeight ?? MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme?.backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          if (widget.showTitle || widget.showCloseButton) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (widget.showTitle) ...[
                    Expanded(
                      child: Text(
                        widget.title ?? widget.config.titleText,
                        style: widget.titleStyle ??
                            const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                  if (widget.showCloseButton) ...[
                    if (widget.closeButton != null)
                      widget.closeButton!
                    else
                      IconButton(
                        icon: Icon(widget.theme?.closeIcon ?? CountrifyIcons.x),
                        onPressed:
                            widget.onClose ?? () => Navigator.of(context).pop(),
                      ),
                  ],
                ],
              ),
            ),
            const Divider(height: 1),
          ],

          // Search bar
          _buildSearchBar(),

          // Countries list
          Expanded(
            child: config.enableScrollbar
                ? Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: theme?.scrollbarThickness ?? 6.0,
                    radius: theme?.scrollbarRadius?.topLeft ??
                        const Radius.circular(3),
                    child: _buildCountriesList(),
                  )
                : _buildCountriesList(),
          ),
        ],
      ),
    );
  }
}
