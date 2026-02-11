import 'package:flutter/material.dart';

/// {@template country_picker_config}
/// Shared configuration for country picker widgets.
///
/// Keep this class limited to options used across multiple picker widgets.
/// {@endtemplate}
class CountryPickerConfig {
  /// {@macro country_picker_config}
  const CountryPickerConfig({
    this.locale,
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.flagBorderColor,
    this.flagBorderWidth = 1.0,
    this.enableSearch = true,
    this.includeRegions = const [],
    this.excludeRegions = const [],
    this.includeCountries = const [],
    this.excludeCountries = const [],
    this.titleText = 'Select Country',
    this.searchHintText = 'Search countries...',
    this.emptyStateText = 'No countries found',
    this.selectCountryHintText = 'Select a country',
  });

  /// Locale code for displaying country names in a specific language.
  ///
  /// When `null`, locale is auto-detected from `Localizations.localeOf`.
  final String? locale;

  /// Border radius of the flag.
  final BorderRadius flagBorderRadius;

  /// Border color of the flag.
  final Color? flagBorderColor;

  /// Border width of the flag.
  final double flagBorderWidth;

  /// Whether to enable search.
  final bool enableSearch;

  /// Regions to include.
  final List<String> includeRegions;

  /// Regions to exclude.
  final List<String> excludeRegions;

  /// Countries to include (by alpha-2 code).
  final List<String> includeCountries;

  /// Countries to exclude (by alpha-2 code).
  final List<String> excludeCountries;

  /// Title text shown in the picker header (e.g. "Select Country").
  final String titleText;

  /// Hint text for the search field.
  final String searchHintText;

  /// Message shown when no countries match the search query.
  final String emptyStateText;

  /// Hint text shown when no country is selected.
  final String selectCountryHintText;

  /// Copy with method.
  CountryPickerConfig copyWith({
    String? locale,
    BorderRadius? flagBorderRadius,
    Color? flagBorderColor,
    double? flagBorderWidth,
    bool? enableSearch,
    List<String>? includeRegions,
    List<String>? excludeRegions,
    List<String>? includeCountries,
    List<String>? excludeCountries,
    String? titleText,
    String? searchHintText,
    String? emptyStateText,
    String? selectCountryHintText,
  }) {
    return CountryPickerConfig(
      locale: locale ?? this.locale,
      flagBorderRadius: flagBorderRadius ?? this.flagBorderRadius,
      flagBorderColor: flagBorderColor ?? this.flagBorderColor,
      flagBorderWidth: flagBorderWidth ?? this.flagBorderWidth,
      enableSearch: enableSearch ?? this.enableSearch,
      includeRegions: includeRegions ?? this.includeRegions,
      excludeRegions: excludeRegions ?? this.excludeRegions,
      includeCountries: includeCountries ?? this.includeCountries,
      excludeCountries: excludeCountries ?? this.excludeCountries,
      titleText: titleText ?? this.titleText,
      searchHintText: searchHintText ?? this.searchHintText,
      emptyStateText: emptyStateText ?? this.emptyStateText,
      selectCountryHintText:
          selectCountryHintText ?? this.selectCountryHintText,
    );
  }
}

/// Flag shape options.
enum FlagShape {
  rectangular,
  circular,
  rounded,
}

/// Country sorting options.
enum CountrySortBy {
  name,
  population,
  area,
  region,
  capital,
}

/// Country filter configuration.
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
