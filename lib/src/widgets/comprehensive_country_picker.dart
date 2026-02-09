import 'dart:async';
import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';

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
  }) : assert(
          pickerType != CountryPickerType.dropdown ||
              showPhoneCode ||
              showFlag ||
              showCountryName,
          'For dropdown picker, at least one of showPhoneCode, showFlag, or showCountryName must be true',
        );

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
  State<ComprehensiveCountryPicker> createState() =>
      _ComprehensiveCountryPickerState();
}

class _ComprehensiveCountryPickerState extends State<ComprehensiveCountryPicker>
    with TickerProviderStateMixin {
  Country? _selectedCountry;
  String _searchQuery = '';
  late CountryFilter _currentFilter;
  List<Country> _filteredCountries = [];
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _debounceTimer;
  final ScrollController _scrollController = ScrollController();
  final LayerLink _dropdownLayerLink = LayerLink();
  OverlayEntry? _dropdownOverlay;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
    final config = widget.config ?? const CountryPickerConfig();
    _currentFilter = CountryFilter(
      regions: config.includeRegions,
      sortBy: config.sortBy,
      includeIndependent: config.includeIndependent,
      includeUnMembers: config.includeUnMembers,
    );
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
  void didUpdateWidget(ComprehensiveCountryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update internal state when parent's initialCountry changes
    if (widget.initialCountry != oldWidget.initialCountry) {
      setState(() {
        _selectedCountry = widget.initialCountry;
        // Rebuild the list to put selected country at top
        _filteredCountries = _getFilteredCountries();
      });
    }
  }

  @override
  void dispose() {
    _removeDropdownOverlay();
    _searchController.dispose();
    _animationController.dispose();
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _removeDropdownOverlay() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    if (_isDropdownOpen && mounted) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _loadCountries() {
    setState(() {
      _filteredCountries = _getFilteredCountries();
      // Scroll to top to show selected country at the top
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  List<Country> _getFilteredCountries() {
    final config = widget.config ?? const CountryPickerConfig();
    var countries = CountryUtils.getAllCountries();

    // Apply include/exclude country filters
    if (config.includeCountries.isNotEmpty) {
      final includeSet =
          config.includeCountries.map((c) => c.toUpperCase()).toSet();
      countries = countries
          .where((country) =>
              includeSet.contains(country.alpha2Code.toUpperCase()))
          .toList();
    }

    if (config.excludeCountries.isNotEmpty) {
      final excludeSet =
          config.excludeCountries.map((c) => c.toUpperCase()).toSet();
      countries = countries
          .where((country) =>
              !excludeSet.contains(country.alpha2Code.toUpperCase()))
          .toList();
    }

    // Apply region filters (config + runtime filter)
    final effectiveRegions = {
      ...config.includeRegions,
      ..._currentFilter.regions,
    }.where((r) => r.isNotEmpty).toList();

    if (effectiveRegions.isNotEmpty) {
      countries = countries
          .where((country) => effectiveRegions.contains(country.region))
          .toList();
    } else if (config.excludeRegions.isNotEmpty) {
      countries = countries
          .where((country) => !config.excludeRegions.contains(country.region))
          .toList();
    }

    // Apply independence / UN membership filters
    if (!config.includeIndependent || !_currentFilter.includeIndependent) {
      countries = countries.where((country) => !country.isIndependent).toList();
    }

    if (!config.includeUnMembers || !_currentFilter.includeUnMembers) {
      countries = countries.where((country) => !country.isUnMember).toList();
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
    final sortedCountries = List<Country>.from(countries);
    switch (_currentFilter.sortBy) {
      case CountrySortBy.name:
        sortedCountries.sort((a, b) => a.name.compareTo(b.name));
      case CountrySortBy.population:
        sortedCountries.sort((a, b) => b.population.compareTo(a.population));
      case CountrySortBy.area:
        sortedCountries.sort((a, b) => b.area.compareTo(a.area));
      case CountrySortBy.region:
        sortedCountries.sort((a, b) => a.region.compareTo(b.region));
      case CountrySortBy.capital:
        sortedCountries.sort((a, b) => a.capital.compareTo(b.capital));
    }

    // Put selected country at the top if it exists and is in the filtered list
    if (_selectedCountry != null) {
      final selectedIndex = sortedCountries.indexWhere(
        (country) => country.alpha2Code == _selectedCountry!.alpha2Code,
      );
      if (selectedIndex != -1) {
        // Remove from current position and add to the beginning
        final selected = sortedCountries.removeAt(selectedIndex);
        sortedCountries.insert(0, selected);
      }
    }

    return sortedCountries;
  }

  void _onSearchChanged(String query) {
    final config = widget.config ?? const CountryPickerConfig();
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: config.searchDebounceMs), () {
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
      // Rebuild the list to put selected country at top
      _filteredCountries = _getFilteredCountries();
    });

    widget.onCountrySelected?.call(country);
    widget.onCountryChanged?.call(country);

    // Close modal pickers and return the selected country
    if (widget.pickerType == CountryPickerType.bottomSheet ||
        widget.pickerType == CountryPickerType.dialog ||
        widget.pickerType == CountryPickerType.fullScreen) {
      Navigator.of(context).pop(country);
    }
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

  Widget _buildPickerContent(
      CountryPickerTheme theme, CountryPickerConfig config) {
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

  Widget _buildBottomSheetPicker(
      CountryPickerTheme theme, CountryPickerConfig config) {
    final screenHeight = MediaQuery.of(context).size.height;
    final targetHeight = (config.maxHeight ?? screenHeight * 0.8)
        .clamp(config.minHeight, screenHeight);

    return Container(
      height: targetHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: theme.borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(20)),
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

  Widget _buildDialogPicker(
      CountryPickerTheme theme, CountryPickerConfig config) {
    final screenHeight = MediaQuery.of(context).size.height;
    final targetHeight = (config.maxHeight ?? screenHeight * 0.8)
        .clamp(config.minHeight, screenHeight);

    return Dialog(
      backgroundColor: theme.backgroundColor,
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius:
            theme.borderRadius ?? const BorderRadius.all(Radius.circular(20)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: targetHeight,
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

  Widget _buildFullScreenPicker(
      CountryPickerTheme theme, CountryPickerConfig config) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.headerColor,
        title: Text(
          'Select Country',
          style: theme.headerTextStyle,
        ),
        leading: IconButton(
          icon: Icon(theme.closeIcon ?? CountrifyIcons.x,
              color: theme.headerIconColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (widget.filterEnabled)
            IconButton(
              icon: Icon(theme.filterIcon ?? CountrifyIcons.listFilter,
                  color: theme.headerIconColor),
              onPressed: () => _showFilterDialog(theme, config),
            ),
        ],
      ),
      body: Column(
        children: [
          if (widget.searchEnabled && config.enableSearch)
            _buildSearchBar(theme, config),
          Expanded(child: _buildCountryList(theme, config)),
        ],
      ),
    );
  }

  Widget _buildDropdownPicker(
      CountryPickerTheme theme, CountryPickerConfig config) {
    return CompositedTransformTarget(
      link: _dropdownLayerLink,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: _selectedCountry != null ? 0 : 12,
        ),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius:
              theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: theme.borderColor ?? Colors.grey.shade300),
        ),
        child: InkWell(
          onTap: () => _toggleDropdownOverlay(theme, config),
          child: Row(
            children: [
              Expanded(
                child: _selectedCountry != null
                    ? _buildSimpleCountryItem(_selectedCountry!, theme, config,
                        showBackground: false)
                    : Text(
                        'Select a country',
                        style: theme.countryNameTextStyle ??
                            const TextStyle(fontSize: 14),
                      ),
              ),
              AnimatedRotation(
                turns: _isDropdownOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  theme.dropdownIcon ?? CountrifyIcons.chevronDown,
                  color: theme.borderColor ?? Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdownOverlay(
      CountryPickerTheme theme, CountryPickerConfig config) {
    if (_dropdownOverlay != null) {
      _removeDropdownOverlay();
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final buttonWidth = renderBox.size.width;

    // Reorder list to show selected country first
    final orderedCountries = _selectedCountry != null
        ? [
            _selectedCountry!,
            ..._filteredCountries
                .where((c) => c.alpha2Code != _selectedCountry!.alpha2Code),
          ]
        : _filteredCountries;

    _dropdownOverlay = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // Dismiss backdrop
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _removeDropdownOverlay,
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            // The dropdown menu, positioned below the field
            CompositedTransformFollower(
              link: _dropdownLayerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              child: Container(
                width: buttonWidth,
                constraints: BoxConstraints(
                  maxHeight: config.dropdownMaxHeight ?? 400,
                ),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: theme.dropdownMenuBackgroundColor ?? Colors.white,
                  borderRadius: theme.dropdownMenuBorderRadius ??
                      BorderRadius.circular(12),
                  border: theme.dropdownMenuBorderColor != null
                      ? Border.all(
                          color: theme.dropdownMenuBorderColor!,
                          width: theme.dropdownMenuBorderWidth ?? 1,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor ?? Colors.black26,
                      blurRadius: theme.dropdownMenuElevation ?? 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: theme.dropdownMenuBorderRadius ??
                      BorderRadius.circular(12),
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: orderedCountries.length,
                      itemBuilder: (context, index) {
                        final country = orderedCountries[index];
                        return InkWell(
                          onTap: () {
                            _removeDropdownOverlay();
                            _onCountrySelected(country);
                          },
                          child:
                              _buildSimpleCountryItem(country, theme, config),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_dropdownOverlay!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  Widget _buildSimpleCountryItem(
      Country country, CountryPickerTheme theme, CountryPickerConfig config,
      {bool showBackground = true}) {
    final isSelected = _selectedCountry?.alpha2Code == country.alpha2Code;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: (isSelected && showBackground)
            ? const Color(0xFFE3F2FD)
            : null, // Light blue background only in menu
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          if (widget.showFlag) ...[
            SizedBox(
              width: 32,
              height: 24,
              child: _buildFlag(country, theme, config),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showCountryName)
                  Text(
                    country.name,
                    style: (theme.countryNameTextStyle ?? const TextStyle())
                        .copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                if (widget.showPhoneCode && country.callingCodes.isNotEmpty)
                  Text(
                    '+${country.callingCodes.first}',
                    style: (theme.countrySubtitleTextStyle ?? const TextStyle())
                        .copyWith(
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (isSelected && showBackground) ...[
            const SizedBox(width: 8),
            Icon(
              theme.selectedIcon ?? CountrifyIcons.circleCheckBig,
              color: theme.countryItemSelectedIconColor ?? Colors.blue,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInlinePicker(
      CountryPickerTheme theme, CountryPickerConfig config) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius:
            theme.borderRadius ?? const BorderRadius.all(Radius.circular(12)),
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
    if (config.customHeaderBuilder != null) {
      return config.customHeaderBuilder!(context);
    }

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
            'Select Country',
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

  Widget _buildSearchBar(CountryPickerTheme theme, CountryPickerConfig config) {
    if (!config.enableSearch) {
      return const SizedBox.shrink();
    }

    if (config.customSearchBuilder != null) {
      return config.customSearchBuilder!(
          context, _searchController, _onSearchChanged);
    }

    final effectiveBorderRadius = theme.searchBarBorderRadius ??
        const BorderRadius.all(Radius.circular(12));
    final effectiveDecoration = theme.searchInputDecoration ??
        InputDecoration(
          hintText: theme.searchHintText ?? 'Search countries...',
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

  Widget _buildFilterBar(CountryPickerTheme theme, CountryPickerConfig config) {
    if (!config.enableFilter) {
      return const SizedBox.shrink();
    }

    if (config.customFilterBuilder != null) {
      return config.customFilterBuilder!(
          context, _currentFilter, _onFilterChanged);
    }

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
            icon: Icon(theme.filterIcon ?? CountrifyIcons.listFilter,
                color: theme.filterIconColor),
            onPressed: () => _showFilterDialog(theme, config),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      String label, String? region, CountryPickerTheme theme) {
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
          color: isSelected
              ? theme.filterSelectedTextColor
              : theme.filterTextColor,
        ),
      ),
    );
  }

  Widget _buildCountryList(
      CountryPickerTheme theme, CountryPickerConfig config) {
    final listView = ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        return _buildCountryItem(country, theme, config);
      },
    );

    if (!config.enableScrollbar) {
      return listView;
    }

    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: listView,
    );
  }

  Widget _buildCountryItem(
      Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    final isSelected = _selectedCountry?.alpha2Code == country.alpha2Code;

    if (config.customCountryBuilder != null) {
      return config.customCountryBuilder!(context, country, isSelected);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.countryItemSelectedColor
            : theme.countryItemBackgroundColor,
        borderRadius: theme.countryItemBorderRadius ??
            const BorderRadius.all(Radius.circular(8)),
        border: isSelected
            ? Border.all(
                color: theme.countryItemSelectedBorderColor ?? Colors.blue)
            : null,
      ),
      child: ListTile(
        onTap: () => _onCountrySelected(country),
        leading: widget.showFlag ? _buildFlag(country, theme, config) : null,
        title:
            widget.showCountryName ? _buildCountryName(country, theme) : null,
        subtitle: _buildCountrySubtitle(country, theme, config),
        trailing: isSelected
            ? Icon(theme.selectedIcon ?? CountrifyIcons.circleCheckBig,
                color: theme.countryItemSelectedIconColor)
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }

  Widget _buildFlag(
      Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    final flagWidth = config.flagSize.width;
    final flagHeight = config.flagSize.height;
    final baseRadius = config.flagBorderRadius;

    final borderRadius = config.flagShape == FlagShape.circular
        ? BorderRadius.circular(flagWidth / 2)
        : baseRadius;

    return Container(
      width: flagWidth,
      height: flagHeight,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: config.flagBorderColor != null
            ? Border.all(
                color: config.flagBorderColor!,
                width: config.flagBorderWidth,
              )
            : null,
        boxShadow: config.flagShadowColor != null
            ? [
                BoxShadow(
                  color: config.flagShadowColor!,
                  blurRadius: config.flagShadowBlur,
                  offset: config.flagShadowOffset,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  country.flagEmoji,
                  style: TextStyle(fontSize: flagWidth * 0.6),
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

  Widget _buildCountrySubtitle(
      Country country, CountryPickerTheme theme, CountryPickerConfig config) {
    final subtitleParts = <String>[];

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
          RadioGroup<CountrySortBy>(
            groupValue: _filter.sortBy,
            onChanged: (CountrySortBy? value) {
              setState(() {
                _filter = _filter.copyWith(sortBy: value);
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: CountrySortBy.values.map((sortBy) {
                return RadioListTile<CountrySortBy>(
                  title: Text(sortBy.name.toUpperCase()),
                  value: sortBy,
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // Region filters
          Text('Regions:', style: widget.theme.filterTextStyle),
          ...['Europe', 'Asia', 'Africa', 'Americas', 'Oceania'].map((region) {
            return CheckboxListTile(
              title: Text(region),
              value: _filter.regions.contains(region),
              onChanged: (value) {
                setState(() {
                  final newRegions = value ?? false
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
