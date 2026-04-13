import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:countrify/src/widgets/shared/empty_state.dart';
import 'package:flutter/material.dart';

/// Internal dropdown overlay anchored below the phone number field.
///
/// This widget is not publicly exported.
class PhoneDropdownOverlay extends StatefulWidget {
  const PhoneDropdownOverlay({
    required this.link,
    required this.fieldWidth,
    required this.maxHeight,
    required this.theme,
    required this.searchEnabled,
    required this.onSelected,
    required this.onDismiss,
    super.key,
    this.config,
    this.selectedCountry,
    this.showFlag = true,
    this.showCountryName = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final LayerLink link;
  final double fieldWidth;
  final double maxHeight;
  final CountryPickerTheme theme;
  final bool searchEnabled;
  final CountryPickerConfig? config;
  final Country? selectedCountry;
  final bool showFlag;
  final bool showCountryName;
  final Size flagSize;
  final BorderRadius flagBorderRadius;
  final ValueChanged<Country> onSelected;
  final VoidCallback onDismiss;

  @override
  State<PhoneDropdownOverlay> createState() => _PhoneDropdownOverlayState();
}

class _PhoneDropdownOverlayState extends State<PhoneDropdownOverlay> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Country> _countries = [];
  List<Country> _filtered = [];
  Timer? _debounce;
  late String _effectiveLocale;

  @override
  void initState() {
    super.initState();
    _effectiveLocale = widget.config?.locale ?? 'en';
    _loadCountries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =
        widget.config?.locale ?? Localizations.localeOf(context).languageCode;
    if (locale != _effectiveLocale) {
      _effectiveLocale = locale;
      _loadCountries();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String _displayName(Country country) {
    if (_effectiveLocale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, _effectiveLocale);
  }

  void _loadCountries() {
    var list = CountryUtils.getAllCountries()
        .where((c) => c.callingCodes.isNotEmpty)
        .toList()
      ..sort((a, b) => _displayName(a).compareTo(_displayName(b)));

    final config = widget.config;
    if (config != null) {
      if (config.includeCountries.isNotEmpty) {
        list = list
            .where((c) => config.includeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.excludeCountries.isNotEmpty) {
        list = list
            .where((c) => !config.excludeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.includeRegions.isNotEmpty) {
        list = list
            .where((c) => config.includeRegions.contains(c.region))
            .toList();
      }
      if (config.excludeRegions.isNotEmpty) {
        list = list
            .where((c) => !config.excludeRegions.contains(c.region))
            .toList();
      }
    }

    _countries = list;
    _filtered = list;
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _applyFilter(query);
    });
  }

  void _applyFilter(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filtered = _countries;
      } else {
        final q = query.toLowerCase();
        _filtered = _countries.where((c) {
          return _displayName(c).toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q) ||
              c.alpha2Code.toLowerCase().contains(q) ||
              c.callingCodes.any((code) => code.contains(q));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Stack(
      children: [
        // Dismiss layer
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        // Dropdown card
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: const Offset(0, 4),
          targetAnchor: Alignment.bottomLeft,
          child: Material(
            elevation: theme.elevation ?? 8,
            shadowColor: theme.shadowColor ?? Colors.black26,
            borderRadius: theme.dropdownMenuBorderRadius ??
                const BorderRadius.all(Radius.circular(12)),
            color: theme.dropdownMenuBackgroundColor ??
                theme.backgroundColor ??
                Colors.white,
            child: Container(
              width: widget.fieldWidth,
              constraints: BoxConstraints(maxHeight: widget.maxHeight),
              decoration: BoxDecoration(
                borderRadius: theme.dropdownMenuBorderRadius ??
                    const BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: theme.dropdownMenuBorderColor ??
                      theme.borderColor ??
                      Colors.grey.shade300,
                  width: theme.dropdownMenuBorderWidth ?? 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: theme.dropdownMenuBorderRadius ??
                    const BorderRadius.all(Radius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.searchEnabled) _buildSearch(theme),
                    Flexible(child: _buildList(theme)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearch(CountryPickerTheme theme) {
    final config = widget.config ?? const CountryPickerConfig();
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
                  tooltip: 'Clear search',
                  icon: Icon(theme.clearIcon ?? CountrifyIcons.circleX,
                      color: theme.searchIconColor),
                  onPressed: () {
                    _searchController.clear();
                    _applyFilter('');
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: Semantics(
        label: 'Search countries',
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: theme.searchTextStyle,
          cursorColor: theme.searchCursorColor,
          decoration: effectiveDecoration,
        ),
      ),
    );
  }

  Widget _buildList(CountryPickerTheme theme) {
    if (_filtered.isEmpty) {
      final config = widget.config ?? const CountryPickerConfig();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: CountryEmptyState(
          text: config.emptyStateText,
          icon: theme.emptyStateIcon ?? CountrifyIcons.searchX,
          textStyle:
              theme.readOnlyHintTextStyle ?? theme.countrySubtitleTextStyle,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      itemCount: _filtered.length,
      itemExtent: 44,
      itemBuilder: (_, index) {
        final country = _filtered[index];
        final isSelected =
            widget.selectedCountry?.alpha2Code == country.alpha2Code;

        return InkWell(
          onTap: () => widget.onSelected(country),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: isSelected
                ? theme.countryItemSelectedColor ??
                    Colors.blue.withValues(alpha: 0.08)
                : null,
            child: Row(
              children: [
                if (widget.showFlag) ...[
                  CountryFlag(
                    country: country,
                    size: widget.flagSize,
                    borderRadius: widget.flagBorderRadius,
                  ),
                  const SizedBox(width: 10),
                ],
                SizedBox(
                  width: 48,
                  child: Text(
                    '+${country.callingCodes.first}',
                    style: theme.compactDialCodeTextStyle?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ) ??
                        theme.countryNameTextStyle?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (widget.showCountryName) ...[
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _displayName(country),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.countrySubtitleTextStyle?.copyWith(
                            fontSize: 13,
                          ) ??
                          theme.compactCountryNameTextStyle,
                    ),
                  ),
                ],
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      theme.selectedIcon ?? CountrifyIcons.circleCheckBig,
                      size: 16,
                      color: theme.countryItemSelectedIconColor ?? Colors.blue,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
