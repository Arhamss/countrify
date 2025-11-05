import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/country.dart';
import '../utils/country_utils.dart';
import 'country_picker_theme.dart';
import 'country_picker_config.dart';

/// {@template comprehensive_country_picker}
/// A highly customizable and modern country picker with extensive styling options
/// {@endtemplate}
class ComprehensiveCountryPicker extends StatefulWidget {
  /// {@macro comprehensive_country_picker}
  const ComprehensiveCountryPicker({
    super.key,
    this.initialCountry,
    this.onCountrySelected,
    this.onCountryChanged,
    this.onSearchChanged,
    this.onFilterChanged,
    this.theme,
    this.config,
    this.pickerType = CountryPickerType.bottomSheet,
    this.showPhoneCode = true,
    this.showFlag = true,
    this.showCountryName = true,
    this.showCapital = false,
    this.showRegion = false,
    this.showPopulation = false,
    this.searchEnabled = true,
    this.filterEnabled = false,
    this.hapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  /// Initial selected country
  final Country? initialCountry;

  /// Callback when a country is selected
  final ValueChanged<Country>? onCountrySelected;

  /// Callback when country selection changes
  final ValueChanged<Country>? onCountryChanged;

  /// Callback when search query changes
  final ValueChanged<String>? onSearchChanged;

  /// Callback when filter changes
  final ValueChanged<CountryFilter>? onFilterChanged;

  /// Theme configuration
  final CountryPickerTheme? theme;

  /// Configuration options
  final CountryPickerConfig? config;

  /// Type of picker to display
  final CountryPickerType pickerType;

  /// Whether to show phone code
  final bool showPhoneCode;

  /// Whether to show country flag
  final bool showFlag;

  /// Whether to show country name
  final bool showCountryName;

  /// Whether to show capital city
  final bool showCapital;

  /// Whether to show region
  final bool showRegion;

  /// Whether to show population
  final bool showPopulation;

  /// Whether search is enabled
  final bool searchEnabled;

  /// Whether filtering is enabled
  final bool filterEnabled;

  /// Whether to provide haptic feedback
  final bool hapticFeedback;

  /// Animation duration
  final Duration animationDuration;

  /// Debounce duration for search
  final Duration debounceDuration;

  @override
  State<ComprehensiveCountryPicker> createState() => _ComprehensiveCountryPickerState();
}

class _ComprehensiveCountryPickerState extends State<ComprehensiveCountryPicker>
    with TickerProviderStateMixin {
  Country? _selectedCountry;
  String _searchQuery = '';
  CountryFilter _currentFilter = const CountryFilter();
  List<Country> _filteredCountries = [];
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
    _searchController = TextEditingController();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadCountries();
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _loadCountries() {
    setState(() {
      _filteredCountries = _getFilteredCountries();
    });
  }

  List<Country> _getFilteredCountries() {
    List<Country> countries = CountryUtils.getAllCountries();

    // Apply region filter
    if (_currentFilter.regions.isNotEmpty) {
      countries = countries.where((country) => 
          _currentFilter.regions.contains(country.region)).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      countries = countries.where((country) {
        final query = _searchQuery.toLowerCase();
        return country.name.toLowerCase().contains(query) ||
            country.alpha2Code.toLowerCase().contains(query) ||
            country.alpha3Code.toLowerCase().contains(query) ||
            country.capital.toLowerCase().contains(query) ||
            country.region.toLowerCase().contains(query) ||
            country.callingCodes.any((code) => code.contains(query));
      }).toList();
    }

    // Apply sorting - create a new list to avoid modifying unmodifiable list
    List<Country> sortedCountries = List.from(countries);
    switch (_currentFilter.sortBy) {
      case CountrySortBy.name:
        sortedCountries.sort((a, b) => a.name.compareTo(b.name));
        break;
      case CountrySortBy.population:
        sortedCountries.sort((a, b) => b.population.compareTo(a.population));
        break;
      case CountrySortBy.area:
        sortedCountries.sort((a, b) => b.area.compareTo(a.area));
        break;
      case CountrySortBy.region:
        sortedCountries.sort((a, b) => a.region.compareTo(b.region));
        break;
    }

    return sortedCountries;
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      setState(() {
        _searchQuery = query;
        _loadCountries();
      });
      widget.onSearchChanged?.call(query);
    });
  }

  void _onCountrySelected(Country country) {
    if (widget.hapticFeedback) {
      HapticFeedback.lightImpact();
    }
    
    setState(() {
      _selectedCountry = country;
    });

    widget.onCountrySelected?.call(country);
    widget.onCountryChanged?.call(country);
  }

  void _onFilterChanged(CountryFilter filter) {
    setState(() {
      _currentFilter = filter;
      _loadCountries();
    });
    widget.onFilterChanged?.call(filter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? CountryPickerTheme.defaultTheme();
    final config = widget.config ?? const CountryPickerConfig();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildPickerContent(theme, config),
    );
  }

  Widget _buildPickerContent(CountryPickerTheme theme, CountryPickerConfig config) {
    switch (widget.pickerType) {
      case CountryPickerType.bottomSheet:
        return _buildBottomSheetPicker(theme, config);
      case CountryPickerType.dialog:
        return _buildDialogPicker(theme, config);
      case CountryPickerType.fullScreen:
        return _buildFullScreenPicker(theme, config);
      case CountryPickerType.dropdown:
        return _buildDropdownPicker(theme, config);
      case CountryPickerType.inline:
        return _buildInlinePicker(theme, config);
    }
  }

  Widget _buildBottomSheetPicker(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius ?? const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(theme, config),
          if (widget.searchEnabled) _buildSearchBar(theme, config),
          if (widget.filterEnabled) _buildFilterBar(theme, config),
          Expanded(child: _buildCountryList(theme, config)),
        ],
      ),
    );
  }

  Widget _buildDialogPicker(CountryPickerTheme theme, CountryPickerConfig config) {
    return Dialog(
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: theme.borderRadius ?? const BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            _buildHeader(theme, config),
            if (widget.searchEnabled) _buildSearchBar(theme, config),
            if (widget.filterEnabled) _buildFilterBar(theme, config),
            Expanded(child: _buildCountryList(theme, config)),
          ],
        ),
      ),
    );
  }

  Widget _buildFullScreenPicker(CountryPickerTheme theme, CountryPickerConfig config) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.headerColor,
        title: Text(
          'Select Country',
          style: theme.headerTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.headerIconColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (widget.filterEnabled)
            IconButton(
              icon: Icon(Icons.filter_list, color: theme.headerIconColor),
              onPressed: () => _showFilterDialog(theme, config),
            ),
        ],
      ),
      body: Column(
        children: [
          if (widget.searchEnabled) _buildSearchBar(theme, config),
          Expanded(child: _buildCountryList(theme, config)),
        ],
      ),
    );
  }

  Widget _buildDropdownPicker(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
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
          onChanged: (country) {
            if (country != null) {
              _onCountrySelected(country);
            }
          },
        ),
      ),
    );
  }

  Widget _buildInlinePicker(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: theme.borderColor ?? Colors.grey.shade300),
      ),
      child: Column(
        children: [
          if (widget.searchEnabled) _buildSearchBar(theme, config),
          if (widget.filterEnabled) _buildFilterBar(theme, config),
          SizedBox(
            height: 200,
            child: _buildCountryList(theme, config),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.headerColor,
        borderRadius: theme.borderRadius ?? const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Text(
            'Select Country',
            style: theme.headerTextStyle,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: theme.headerIconColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: theme.searchTextStyle,
        decoration: InputDecoration(
          hintText: 'Search countries...',
          hintStyle: theme.searchHintStyle,
          prefixIcon: Icon(Icons.search, color: theme.searchIconColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: theme.searchIconColor),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: theme.searchBarColor,
          border: OutlineInputBorder(
            borderRadius: theme.searchBarBorderRadius ?? const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: theme.searchBarBorderRadius ?? const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: theme.searchBarBorderRadius ?? const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: theme.searchBarBorderColor ?? Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar(CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', null, theme),
                  _buildFilterChip('Europe', 'Europe', theme),
                  _buildFilterChip('Asia', 'Asia', theme),
                  _buildFilterChip('Africa', 'Africa', theme),
                  _buildFilterChip('Americas', 'Americas', theme),
                  _buildFilterChip('Oceania', 'Oceania', theme),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.filterIconColor),
            onPressed: () => _showFilterDialog(theme, config),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String? region, CountryPickerTheme theme) {
    final isSelected = region == null 
        ? _currentFilter.regions.isEmpty
        : _currentFilter.regions.contains(region);
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (region == null) {
            _onFilterChanged(const CountryFilter());
          } else {
            final newRegions = selected
                ? [..._currentFilter.regions, region]
                : _currentFilter.regions.where((r) => r != region).toList();
            _onFilterChanged(_currentFilter.copyWith(regions: newRegions));
          }
        },
        selectedColor: theme.filterSelectedColor,
        checkmarkColor: theme.filterCheckmarkColor,
        backgroundColor: theme.filterBackgroundColor,
        labelStyle: TextStyle(
          color: isSelected ? theme.filterSelectedTextColor : theme.filterTextColor,
        ),
      ),
    );
  }

  Widget _buildCountryList(CountryPickerTheme theme, CountryPickerConfig config) {
    return ListView.builder(
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return _buildCountryItem(country, theme, config);
      },
    );
  }

  Widget _buildCountryItem(Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    final isSelected = _selectedCountry?.alpha2Code == country.alpha2Code;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? theme.countryItemSelectedColor : theme.countryItemBackgroundColor,
        borderRadius: theme.countryItemBorderRadius ?? const BorderRadius.all(Radius.circular(8)),
        border: isSelected ? Border.all(color: theme.countryItemSelectedBorderColor ?? Colors.blue) : null,
      ),
      child: ListTile(
        onTap: () => _onCountrySelected(country),
        leading: widget.showFlag ? _buildFlag(country, theme, config) : null,
        title: widget.showCountryName ? _buildCountryName(country, theme) : null,
        subtitle: _buildCountrySubtitle(country, theme, config),
        trailing: isSelected ? Icon(Icons.check_circle, color: theme.countryItemSelectedIconColor) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildFlag(Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      width: config.flagSize?.width ?? 32,
      height: config.flagSize?.height ?? 24,
      decoration: BoxDecoration(
        borderRadius: config.flagShape == FlagShape.circular
            ? BorderRadius.circular((config.flagSize?.width ?? 32) / 2)
            : config.flagBorderRadius ?? const BorderRadius.all(Radius.circular(4)),
        border: config.flagBorderColor != null
            ? Border.all(color: config.flagBorderColor!, width: config.flagBorderWidth ?? 1)
            : null,
        boxShadow: config.flagShadowColor != null
            ? [
                BoxShadow(
                  color: config.flagShadowColor!,
                  blurRadius: config.flagShadowBlur ?? 2,
                  offset: config.flagShadowOffset ?? const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: config.flagShape == FlagShape.circular
            ? BorderRadius.circular((config.flagSize?.width ?? 32) / 2)
            : config.flagBorderRadius ?? const BorderRadius.all(Radius.circular(4)),
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  country.flagEmoji,
                  style: TextStyle(fontSize: (config.flagSize?.width ?? 32) * 0.6),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCountryName(Country country, CountryPickerTheme theme) {
    return Text(
      country.name,
      style: theme.countryNameTextStyle,
    );
  }

  Widget _buildCountrySubtitle(Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    final List<String> subtitleParts = [];
    
    if (widget.showPhoneCode && country.callingCodes.isNotEmpty) {
      subtitleParts.add('+${country.callingCodes.first}');
    }
    
    if (widget.showCapital && country.capital.isNotEmpty) {
      subtitleParts.add(country.capital);
    }
    
    if (widget.showRegion && country.region.isNotEmpty) {
      subtitleParts.add(country.region);
    }
    
    if (widget.showPopulation && country.population > 0) {
      subtitleParts.add(CountryUtils.formatPopulation(country.population));
    }
    
    if (subtitleParts.isEmpty) return const SizedBox.shrink();
    
    return Text(
      subtitleParts.join(' • '),
      style: theme.countrySubtitleTextStyle,
    );
  }

  void _showFilterDialog(CountryPickerTheme theme, CountryPickerConfig config) {
    showDialog<void>(
      context: context,
      builder: (context) => _FilterDialog(
        currentFilter: _currentFilter,
        onFilterChanged: _onFilterChanged,
        theme: theme,
      ),
    );
  }
}

/// Types of country picker displays
enum CountryPickerType {
  bottomSheet,
  dialog,
  fullScreen,
  dropdown,
  inline,
}


/// Country filter configuration
class CountryFilter {
  const CountryFilter({
    this.regions = const [],
    this.sortBy = CountrySortBy.name,
    this.includeIndependent = true,
    this.includeUnMembers = true,
  });

  final List<String> regions;
  final CountrySortBy sortBy;
  final bool includeIndependent;
  final bool includeUnMembers;

  CountryFilter copyWith({
    List<String>? regions,
    CountrySortBy? sortBy,
    bool? includeIndependent,
    bool? includeUnMembers,
  }) {
    return CountryFilter(
      regions: regions ?? this.regions,
      sortBy: sortBy ?? this.sortBy,
      includeIndependent: includeIndependent ?? this.includeIndependent,
      includeUnMembers: includeUnMembers ?? this.includeUnMembers,
    );
  }
}

/// Country sorting options
enum CountrySortBy {
  name,
  population,
  area,
  region,
}

/// Filter dialog widget
class _FilterDialog extends StatefulWidget {
  const _FilterDialog({
    required this.currentFilter,
    required this.onFilterChanged,
    required this.theme,
  });

  final CountryFilter currentFilter;
  final ValueChanged<CountryFilter> onFilterChanged;
  final CountryPickerTheme theme;

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  late CountryFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.theme.backgroundColor,
      title: Text('Filter Countries', style: widget.theme.headerTextStyle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sort options
          Text('Sort by:', style: widget.theme.filterTextStyle),
          ...CountrySortBy.values.map((sortBy) {
            return RadioListTile<CountrySortBy>(
              title: Text(sortBy.name.toUpperCase()),
              value: sortBy,
              groupValue: _filter.sortBy,
              onChanged: (value) {
                setState(() {
                  _filter = _filter.copyWith(sortBy: value);
                });
              },
            );
          }),
          
          const Divider(),
          
          // Region filters
          Text('Regions:', style: widget.theme.filterTextStyle),
          ...['Europe', 'Asia', 'Africa', 'Americas', 'Oceania'].map((region) {
            return CheckboxListTile(
              title: Text(region),
              value: _filter.regions.contains(region),
              onChanged: (value) {
                setState(() {
                  final newRegions = value == true
                      ? [..._filter.regions, region]
                      : _filter.regions.where((r) => r != region).toList();
                  _filter = _filter.copyWith(regions: newRegions);
                });
              },
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onFilterChanged(_filter);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
