import 'package:flutter/material.dart';
import '../models/country.dart';

/// {@template country_picker_config}
/// Comprehensive configuration for the country picker
/// {@endtemplate}
class CountryPickerConfig {
  /// {@macro country_picker_config}
  const CountryPickerConfig({
    this.showDialCode = true,
    this.showCapital = false,
    this.showRegion = false,
    this.showPopulation = false,
    this.showFlag = true,
    this.showCountryName = true,
    this.itemHeight = 60.0,
    this.flagSize = const Size(32, 24),
    this.flagShape = FlagShape.rectangular,
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.flagBorderColor,
    this.flagBorderWidth = 1.0,
    this.flagShadowColor,
    this.flagShadowBlur = 2.0,
    this.flagShadowOffset = const Offset(0, 1),
    this.enableScrollbar = true,
    this.enableHapticFeedback = true,
    this.enableSearch = true,
    this.enableFilter = false,
    this.searchDebounceMs = 300,
    this.animationDuration = const Duration(milliseconds: 300),
    this.includeRegions = const [],
    this.excludeRegions = const [],
    this.includeCountries = const [],
    this.excludeCountries = const [],
    this.sortBy = CountrySortBy.name,
    this.includeIndependent = true,
    this.includeUnMembers = true,
    this.maxHeight,
    this.minHeight = 200.0,
    this.allowMultipleSelection = false,
    this.showSelectedCount = false,
    this.enableCountryGrouping = false,
    this.groupBy = CountryGroupBy.region,
    this.showGroupHeaders = true,
    this.stickyHeaders = true,
    this.enablePullToRefresh = false,
    this.enableInfiniteScroll = false,
    this.itemsPerPage = 50,
    this.showLoadingIndicator = true,
    this.loadingIndicatorColor,
    this.emptyStateWidget,
    this.errorStateWidget,
    this.customCountryBuilder,
    this.customHeaderBuilder,
    this.customSearchBuilder,
    this.customFilterBuilder,
  });

  /// Whether to show dial code
  final bool showDialCode;

  /// Whether to show capital city
  final bool showCapital;

  /// Whether to show region
  final bool showRegion;

  /// Whether to show population
  final bool showPopulation;

  /// Whether to show flag
  final bool showFlag;

  /// Whether to show country name
  final bool showCountryName;

  /// Height of each country item
  final double itemHeight;

  /// Size of the flag
  final Size flagSize;

  /// Shape of the flag
  final FlagShape flagShape;

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

  /// Whether to enable scrollbar
  final bool enableScrollbar;

  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;

  /// Whether to enable search
  final bool enableSearch;

  /// Whether to enable filter
  final bool enableFilter;

  /// Search debounce in milliseconds
  final int searchDebounceMs;

  /// Animation duration
  final Duration animationDuration;

  /// Regions to include
  final List<String> includeRegions;

  /// Regions to exclude
  final List<String> excludeRegions;

  /// Countries to include (by alpha-2 code)
  final List<String> includeCountries;

  /// Countries to exclude (by alpha-2 code)
  final List<String> excludeCountries;

  /// Sort countries by
  final CountrySortBy sortBy;

  /// Include independent countries
  final bool includeIndependent;

  /// Include UN member countries
  final bool includeUnMembers;

  /// Maximum height of the picker
  final double? maxHeight;

  /// Minimum height of the picker
  final double minHeight;

  /// Allow multiple country selection
  final bool allowMultipleSelection;

  /// Show selected count
  final bool showSelectedCount;

  /// Enable country grouping
  final bool enableCountryGrouping;

  /// Group countries by
  final CountryGroupBy groupBy;

  /// Show group headers
  final bool showGroupHeaders;

  /// Sticky headers
  final bool stickyHeaders;

  /// Enable pull to refresh
  final bool enablePullToRefresh;

  /// Enable infinite scroll
  final bool enableInfiniteScroll;

  /// Items per page for pagination
  final int itemsPerPage;

  /// Show loading indicator
  final bool showLoadingIndicator;

  /// Loading indicator color
  final Color? loadingIndicatorColor;

  /// Custom empty state widget
  final Widget? emptyStateWidget;

  /// Custom error state widget
  final Widget? errorStateWidget;

  /// Custom country item builder
  final Widget Function(BuildContext context, Country country, bool isSelected)? customCountryBuilder;

  /// Custom header builder
  final Widget Function(BuildContext context)? customHeaderBuilder;

  /// Custom search builder
  final Widget Function(BuildContext context, TextEditingController controller, ValueChanged<String> onChanged)? customSearchBuilder;

  /// Custom filter builder
  final Widget Function(BuildContext context, CountryFilter filter, ValueChanged<CountryFilter> onChanged)? customFilterBuilder;

  /// Copy with method
  CountryPickerConfig copyWith({
    bool? showDialCode,
    bool? showCapital,
    bool? showRegion,
    bool? showPopulation,
    bool? showFlag,
    bool? showCountryName,
    double? itemHeight,
    Size? flagSize,
    FlagShape? flagShape,
    BorderRadius? flagBorderRadius,
    Color? flagBorderColor,
    double? flagBorderWidth,
    Color? flagShadowColor,
    double? flagShadowBlur,
    Offset? flagShadowOffset,
    bool? enableScrollbar,
    bool? enableHapticFeedback,
    bool? enableSearch,
    bool? enableFilter,
    int? searchDebounceMs,
    Duration? animationDuration,
    List<String>? includeRegions,
    List<String>? excludeRegions,
    List<String>? includeCountries,
    List<String>? excludeCountries,
    CountrySortBy? sortBy,
    bool? includeIndependent,
    bool? includeUnMembers,
    double? maxHeight,
    double? minHeight,
    bool? allowMultipleSelection,
    bool? showSelectedCount,
    bool? enableCountryGrouping,
    CountryGroupBy? groupBy,
    bool? showGroupHeaders,
    bool? stickyHeaders,
    bool? enablePullToRefresh,
    bool? enableInfiniteScroll,
    int? itemsPerPage,
    bool? showLoadingIndicator,
    Color? loadingIndicatorColor,
    Widget? emptyStateWidget,
    Widget? errorStateWidget,
    Widget Function(BuildContext context, Country country, bool isSelected)? customCountryBuilder,
    Widget Function(BuildContext context)? customHeaderBuilder,
    Widget Function(BuildContext context, TextEditingController controller, ValueChanged<String> onChanged)? customSearchBuilder,
    Widget Function(BuildContext context, CountryFilter filter, ValueChanged<CountryFilter> onChanged)? customFilterBuilder,
  }) {
    return CountryPickerConfig(
      showDialCode: showDialCode ?? this.showDialCode,
      showCapital: showCapital ?? this.showCapital,
      showRegion: showRegion ?? this.showRegion,
      showPopulation: showPopulation ?? this.showPopulation,
      showFlag: showFlag ?? this.showFlag,
      showCountryName: showCountryName ?? this.showCountryName,
      itemHeight: itemHeight ?? this.itemHeight,
      flagSize: flagSize ?? this.flagSize,
      flagShape: flagShape ?? this.flagShape,
      flagBorderRadius: flagBorderRadius ?? this.flagBorderRadius,
      flagBorderColor: flagBorderColor ?? this.flagBorderColor,
      flagBorderWidth: flagBorderWidth ?? this.flagBorderWidth,
      flagShadowColor: flagShadowColor ?? this.flagShadowColor,
      flagShadowBlur: flagShadowBlur ?? this.flagShadowBlur,
      flagShadowOffset: flagShadowOffset ?? this.flagShadowOffset,
      enableScrollbar: enableScrollbar ?? this.enableScrollbar,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      enableSearch: enableSearch ?? this.enableSearch,
      enableFilter: enableFilter ?? this.enableFilter,
      searchDebounceMs: searchDebounceMs ?? this.searchDebounceMs,
      animationDuration: animationDuration ?? this.animationDuration,
      includeRegions: includeRegions ?? this.includeRegions,
      excludeRegions: excludeRegions ?? this.excludeRegions,
      includeCountries: includeCountries ?? this.includeCountries,
      excludeCountries: excludeCountries ?? this.excludeCountries,
      sortBy: sortBy ?? this.sortBy,
      includeIndependent: includeIndependent ?? this.includeIndependent,
      includeUnMembers: includeUnMembers ?? this.includeUnMembers,
      maxHeight: maxHeight ?? this.maxHeight,
      minHeight: minHeight ?? this.minHeight,
      allowMultipleSelection: allowMultipleSelection ?? this.allowMultipleSelection,
      showSelectedCount: showSelectedCount ?? this.showSelectedCount,
      enableCountryGrouping: enableCountryGrouping ?? this.enableCountryGrouping,
      groupBy: groupBy ?? this.groupBy,
      showGroupHeaders: showGroupHeaders ?? this.showGroupHeaders,
      stickyHeaders: stickyHeaders ?? this.stickyHeaders,
      enablePullToRefresh: enablePullToRefresh ?? this.enablePullToRefresh,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
      loadingIndicatorColor: loadingIndicatorColor ?? this.loadingIndicatorColor,
      emptyStateWidget: emptyStateWidget ?? this.emptyStateWidget,
      errorStateWidget: errorStateWidget ?? this.errorStateWidget,
      customCountryBuilder: customCountryBuilder ?? this.customCountryBuilder,
      customHeaderBuilder: customHeaderBuilder ?? this.customHeaderBuilder,
      customSearchBuilder: customSearchBuilder ?? this.customSearchBuilder,
      customFilterBuilder: customFilterBuilder ?? this.customFilterBuilder,
    );
  }
}

/// Flag shape options
enum FlagShape {
  rectangular,
  circular,
  rounded,
}

/// Country sorting options
enum CountrySortBy {
  name,
  population,
  area,
  region,
  capital,
}

/// Country grouping options
enum CountryGroupBy {
  region,
  subregion,
  firstLetter,
  population,
}

/// Country filter configuration
class CountryFilter {
  const CountryFilter({
    this.regions = const [],
    this.subregions = const [],
    this.sortBy = CountrySortBy.name,
    this.includeIndependent = true,
    this.includeUnMembers = true,
    this.minPopulation = 0,
    this.maxPopulation = double.infinity,
    this.minArea = 0,
    this.maxArea = double.infinity,
    this.searchQuery = '',
  });

  final List<String> regions;
  final List<String> subregions;
  final CountrySortBy sortBy;
  final bool includeIndependent;
  final bool includeUnMembers;
  final int minPopulation;
  final double maxPopulation;
  final double minArea;
  final double maxArea;
  final String searchQuery;

  CountryFilter copyWith({
    List<String>? regions,
    List<String>? subregions,
    CountrySortBy? sortBy,
    bool? includeIndependent,
    bool? includeUnMembers,
    int? minPopulation,
    double? maxPopulation,
    double? minArea,
    double? maxArea,
    String? searchQuery,
  }) {
    return CountryFilter(
      regions: regions ?? this.regions,
      subregions: subregions ?? this.subregions,
      sortBy: sortBy ?? this.sortBy,
      includeIndependent: includeIndependent ?? this.includeIndependent,
      includeUnMembers: includeUnMembers ?? this.includeUnMembers,
      minPopulation: minPopulation ?? this.minPopulation,
      maxPopulation: maxPopulation ?? this.maxPopulation,
      minArea: minArea ?? this.minArea,
      maxArea: maxArea ?? this.maxArea,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
