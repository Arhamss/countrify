import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:countrify/src/widgets/shared/empty_state.dart';
import 'package:flutter/material.dart';

/// Internal modal country list used by bottom sheet, dialog, and full-screen
/// pickers.
///
/// This widget is not publicly exported.
class PhoneModalCountryList extends StatefulWidget {
  const PhoneModalCountryList({
    required this.theme,
    required this.searchEnabled,
    required this.onSelected,
    super.key,
    this.config,
    this.selectedCountry,
    this.showFlag = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.isBottomSheet = false,
    this.showHeader = true,
  });

  final CountryPickerTheme theme;
  final bool searchEnabled;
  final CountryPickerConfig? config;
  final Country? selectedCountry;
  final bool showFlag;
  final Size flagSize;
  final BorderRadius flagBorderRadius;
  final ValueChanged<Country> onSelected;
  final bool isBottomSheet;
  final bool showHeader;

  @override
  State<PhoneModalCountryList> createState() => _PhoneModalCountryListState();
}

class _PhoneModalCountryListState extends State<PhoneModalCountryList> {
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

    final body = Column(
      children: [
        if (widget.showHeader) _buildHeader(theme),
        if (widget.searchEnabled) _buildSearchBar(theme),
        Expanded(child: _buildList(theme)),
      ],
    );

    if (widget.isBottomSheet) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: theme.backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: body,
      );
    }

    return body;
  }

  Widget _buildHeader(CountryPickerTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.headerColor,
        borderRadius: widget.isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : null,
      ),
      child: Row(
        children: [
          Text((widget.config ?? const CountryPickerConfig()).titleText,
              style: theme.headerTextStyle),
          const Spacer(),
          Tooltip(
            message: 'Close',
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(theme.closeIcon ?? CountrifyIcons.x,
                  color: theme.headerIconColor, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(CountryPickerTheme theme) {
    final effectiveBorderRadius = theme.searchBarBorderRadius ??
        const BorderRadius.all(Radius.circular(12));
    final effectiveDecoration = theme.searchInputDecoration ??
        InputDecoration(
          hintText: theme.searchHintText ??
              (widget.config ?? const CountryPickerConfig()).searchHintText,
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

    return Container(
      padding: const EdgeInsets.all(16),
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
      return CountryEmptyState(
        text: config.emptyStateText,
        icon: theme.emptyStateIcon ?? CountrifyIcons.searchX,
        iconSize: 40,
        textStyle:
            theme.readOnlyHintTextStyle ?? theme.countrySubtitleTextStyle,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: _filtered.length,
      itemBuilder: (_, index) {
        final country = _filtered[index];
        final isSelected =
            widget.selectedCountry?.alpha2Code == country.alpha2Code;

        return ListTile(
          onTap: () => widget.onSelected(country),
          dense: true,
          selected: isSelected,
          selectedTileColor: theme.countryItemSelectedColor,
          leading: widget.showFlag
              ? CountryFlag(
                  country: country,
                  size: widget.flagSize,
                  borderRadius: widget.flagBorderRadius,
                )
              : null,
          title: Text(_displayName(country),
              style: theme.countryNameTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          trailing: Text(
            '+${country.callingCodes.first}',
            style: theme.compactDialCodeTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                ) ??
                theme.countrySubtitleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      },
    );
  }
}
