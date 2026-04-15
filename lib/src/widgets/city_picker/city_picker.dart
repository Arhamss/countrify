// ignore_for_file: avoid_positional_boolean_parameters, the `selected` flag matches Flutter's own builder-callback conventions.

import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/geo_picker/geo_item_picker.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_sort_by.dart';
import 'package:flutter/material.dart';

/// Signature for a custom city item row. [selected] reflects whether the
/// row corresponds to the currently-selected city.
typedef CityItemBuilder = Widget Function(
  BuildContext context,
  City city,
  bool selected,
);

/// Signature for a custom matcher that decides whether [city] matches the
/// already-normalized [query].
typedef CityMatcher = bool Function(City city, String query);

/// {@template city_picker}
/// A picker that lets users choose a [City] from the provided [stateId].
///
/// Mirrors `StatePicker`'s API surface: five display modes, theming via
/// [GeoPickerTheme], behavior via [GeoPickerConfig], sort orders, debounced
/// search, and full row / header / search / empty-state customization.
///
/// ```dart
/// CityPicker(
///   stateId: 1416,
///   initialCityId: 111825,
///   pickerMode: CountryPickerMode.dialog,
///   onCitySelected: (city) => print(city.name),
/// )
/// ```
/// {@endtemplate}
class CityPicker extends StatelessWidget {
  /// {@macro city_picker}
  const CityPicker({
    required this.stateId,
    super.key,
    this.initialCityId,
    this.onCitySelected,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.theme,
    this.config,
    this.sortBy = CitySortBy.name,
    this.showCoordinates = false,
    this.title,
    this.searchHintText,
    this.emptyStateText,
    this.customCityBuilder,
    this.customHeaderBuilder,
    this.customSearchBuilder,
    this.customEmptyStateBuilder,
    this.customMatcher,
    this.onSearchChanged,
    this.onResultsChanged,
    this.repository,
  });

  /// Id of the parent state to list cities for.
  final int stateId;

  /// Id of the initially selected city.
  final int? initialCityId;

  /// Called when the user taps a city.
  final ValueChanged<City>? onCitySelected;

  /// How the picker is presented.
  final CountryPickerMode pickerMode;

  /// Visual theme.
  final GeoPickerTheme? theme;

  /// Behavior + text configuration.
  final GeoPickerConfig? config;

  /// Sort order.
  final CitySortBy sortBy;

  /// Whether to display lat/lng as a subtitle when the default row builder
  /// is used.
  final bool showCoordinates;

  /// Header title override. Defaults to `"Select city"`.
  final String? title;

  /// Search hint override. Defaults to `"Search cities"`.
  final String? searchHintText;

  /// Empty-state text override.
  final String? emptyStateText;

  /// Custom row builder. When provided, takes full control of the row.
  final CityItemBuilder? customCityBuilder;

  /// Custom header builder.
  final GeoHeaderBuilder? customHeaderBuilder;

  /// Custom search field builder.
  final GeoSearchBuilder? customSearchBuilder;

  /// Custom empty-state builder.
  final GeoEmptyStateBuilder? customEmptyStateBuilder;

  /// Override the matching function. Defaults to a case- and
  /// accent-insensitive `contains` match on [City.name].
  final CityMatcher? customMatcher;

  /// Called with the raw query text on every debounced search change.
  final ValueChanged<String>? onSearchChanged;

  /// Called whenever the filtered city list changes (including on initial
  /// load). Useful for rendering "N cities" counters outside the picker.
  final ValueChanged<List<City>>? onResultsChanged;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? GeoRepository.instance;
    final cfg = config ?? const GeoPickerConfig();
    return GeoItemPicker<City>(
      loader: () async {
        final cities = await repo.citiesOf(stateId);
        return _sort(cities, sortBy);
      },
      matcher: customMatcher ?? _defaultMatcher(cfg.accentInsensitiveSearch),
      itemBuilder: _buildRow,
      selected: initialCityId == null ? null : _selectedStub(initialCityId!, stateId),
      onSelected: onCitySelected,
      onSearchChanged: onSearchChanged,
      onResultsChanged: onResultsChanged,
      pickerMode: pickerMode,
      theme: theme,
      config: cfg,
      title: title ?? cfg.title ?? 'Select city',
      searchHintText: searchHintText ?? cfg.searchHintText ?? 'Search cities',
      emptyStateText: emptyStateText ?? cfg.emptyStateText ?? 'No cities found',
      headerBuilder: customHeaderBuilder,
      searchBuilder: customSearchBuilder,
      emptyStateBuilder: customEmptyStateBuilder,
      semanticLabelOf: (c) => c.name,
    );
  }

  /// Default matcher used when [customMatcher] is null.
  static CityMatcher _defaultMatcher(bool accentFold) {
    String prep(String s) =>
        accentFold ? SearchNormalizer.foldAccents(s) : SearchNormalizer.basic(s);
    return (city, q) => prep(city.name).contains(q);
  }

  Widget _buildRow(BuildContext context, City city, bool selected) {
    if (customCityBuilder != null) return customCityBuilder!(context, city, selected);
    final t = theme;
    final subtitle = showCoordinates && city.latitude != null && city.longitude != null
        ? '${city.latitude!.toStringAsFixed(3)}, ${city.longitude!.toStringAsFixed(3)}'
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          city.name,
          style: t?.itemNameTextStyle ?? const TextStyle(fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: t?.itemSubtitleTextStyle ??
                TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  static City _selectedStub(int id, int stateId) => City(id: id, name: '', stateId: stateId);

  static List<City> _sort(List<City> src, CitySortBy sort) {
    if (sort == CitySortBy.id || src.isEmpty) return src;
    return List<City>.of(src)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
}
