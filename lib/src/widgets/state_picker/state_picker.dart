// ignore_for_file: avoid_positional_boolean_parameters, the `selected` flag matches Flutter's own builder-callback conventions.

import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/geo_picker/geo_item_picker.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_sort_by.dart';
import 'package:flutter/material.dart';

/// Signature for a custom state item row. [selected] reflects whether the
/// row corresponds to the currently-selected state and can be used to alter
/// the appearance of the returned widget.
typedef StateItemBuilder = Widget Function(
  BuildContext context,
  CountryState state,
  bool selected,
);

/// Signature for a custom matcher that decides whether [state] matches the
/// normalized [query] (already trimmed, lower-cased, and — when the config
/// allows — accent-folded).
typedef StateMatcher = bool Function(CountryState state, String query);

/// {@template state_picker}
/// A picker that lets users choose a [CountryState] from the provided
/// [countryIso2].
///
/// Supports five display modes, theming via [GeoPickerTheme], behavior via
/// [GeoPickerConfig], sort orders, search, and full row / header / search /
/// empty-state customization.
///
/// ```dart
/// StatePicker(
///   countryIso2: 'US',
///   initialStateId: 1416,
///   pickerMode: CountryPickerMode.bottomSheet,
///   onStateSelected: (state) => print(state.name),
/// )
/// ```
/// {@endtemplate}
class StatePicker extends StatelessWidget {
  /// {@macro state_picker}
  const StatePicker({
    required this.countryIso2,
    super.key,
    this.initialStateId,
    this.onStateSelected,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.theme,
    this.config,
    this.sortBy = StateSortBy.name,
    this.showType = true,
    this.title,
    this.searchHintText,
    this.emptyStateText,
    this.customStateBuilder,
    this.customHeaderBuilder,
    this.customSearchBuilder,
    this.customEmptyStateBuilder,
    this.customMatcher,
    this.onSearchChanged,
    this.onResultsChanged,
    this.repository,
  });

  /// ISO 3166-1 alpha-2 code of the country to list states for.
  final String countryIso2;

  /// Id of the initially selected state.
  final int? initialStateId;

  /// Called when the user taps a state.
  final ValueChanged<CountryState>? onStateSelected;

  /// How the picker is presented.
  final CountryPickerMode pickerMode;

  /// Visual theme.
  final GeoPickerTheme? theme;

  /// Behavior + text configuration.
  final GeoPickerConfig? config;

  /// Sort order.
  final StateSortBy sortBy;

  /// Whether to show the subdivision type (e.g. "province") as a subtitle
  /// when the default row builder is used.
  final bool showType;

  /// Header title override. Defaults to `"Select state"`.
  final String? title;

  /// Search hint override. Defaults to `"Search states"`.
  final String? searchHintText;

  /// Empty-state text override.
  final String? emptyStateText;

  /// Custom row builder. When provided, takes full control of the row.
  final StateItemBuilder? customStateBuilder;

  /// Custom header builder.
  final GeoHeaderBuilder? customHeaderBuilder;

  /// Custom search field builder.
  final GeoSearchBuilder? customSearchBuilder;

  /// Custom empty-state builder.
  final GeoEmptyStateBuilder? customEmptyStateBuilder;

  /// Override the matching function. Defaults to a case- and
  /// accent-insensitive match against [CountryState.name] and
  /// [CountryState.iso2].
  final StateMatcher? customMatcher;

  /// Called with the raw query text on every debounced search change.
  final ValueChanged<String>? onSearchChanged;

  /// Called whenever the filtered state list changes (including on initial
  /// load). Useful for rendering "N states" counters outside the picker.
  final ValueChanged<List<CountryState>>? onResultsChanged;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  Widget build(BuildContext context) {
    final repo = repository ?? GeoRepository.instance;
    final cfg = config ?? const GeoPickerConfig();
    return GeoItemPicker<CountryState>(
      loader: () async {
        final states = await repo.statesOf(countryIso2);
        return _sort(states, sortBy);
      },
      matcher: customMatcher ?? _defaultMatcher(cfg.accentInsensitiveSearch),
      itemBuilder: _buildRow,
      selected: initialStateId == null
          ? null
          : _selectedStub(initialStateId!, countryIso2),
      onSelected: onStateSelected,
      onSearchChanged: onSearchChanged,
      onResultsChanged: onResultsChanged,
      pickerMode: pickerMode,
      theme: theme,
      config: cfg,
      title: title ?? cfg.title ?? 'Select state',
      searchHintText: searchHintText ?? cfg.searchHintText ?? 'Search states',
      emptyStateText: emptyStateText ?? cfg.emptyStateText ?? 'No states found',
      headerBuilder: customHeaderBuilder,
      searchBuilder: customSearchBuilder,
      emptyStateBuilder: customEmptyStateBuilder,
      semanticLabelOf: (s) => s.name,
    );
  }

  /// Default matcher used when [customMatcher] is null. Query is already
  /// normalized by the picker; here we only normalize the target fields to
  /// match, honoring the accent-insensitive flag.
  static StateMatcher _defaultMatcher(bool accentFold) {
    String prep(String s) =>
        accentFold ? SearchNormalizer.foldAccents(s) : SearchNormalizer.basic(s);
    return (state, q) {
      if (prep(state.name).contains(q)) return true;
      final iso2 = state.iso2;
      return iso2 != null && prep(iso2).contains(q);
    };
  }

  Widget _buildRow(BuildContext context, CountryState state, bool selected) {
    if (customStateBuilder != null) return customStateBuilder!(context, state, selected);
    final t = theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          state.name,
          style: t?.itemNameTextStyle ?? const TextStyle(fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showType && state.type != null)
          Text(
            state.type!,
            style: t?.itemSubtitleTextStyle ??
                TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  /// Returns a [CountryState] stub used purely for equality comparison against
  /// loaded states. The picker only checks `id`, so the other fields are
  /// placeholders.
  static CountryState _selectedStub(int id, String countryIso2) => CountryState(
        id: id,
        name: '',
        countryIso2: countryIso2,
      );

  static List<CountryState> _sort(List<CountryState> src, StateSortBy sort) {
    if (sort == StateSortBy.id || src.isEmpty) return src;
    final copy = List<CountryState>.of(src);
    switch (sort) {
      case StateSortBy.name:
        copy.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      case StateSortBy.type:
        copy.sort((a, b) {
          final t = (a.type ?? '').compareTo(b.type ?? '');
          return t != 0 ? t : a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
      case StateSortBy.id:
        break;
    }
    return copy;
  }
}
