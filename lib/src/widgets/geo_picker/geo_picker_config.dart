import 'package:flutter/widgets.dart';

/// {@template geo_picker_config}
/// Non-visual configuration for `StatePicker` and `CityPicker`.
///
/// Visual styling lives in `GeoPickerTheme`; this class carries behavior and
/// text overrides (sizing, haptic feedback, localized labels, debounce, etc).
/// {@endtemplate}
@immutable
class GeoPickerConfig {
  /// {@macro geo_picker_config}
  const GeoPickerConfig({
    this.title,
    this.searchHintText,
    this.emptyStateText,
    this.emptyStateSubtitle,
    this.cancelText = 'Cancel',
    this.selectText = 'Select',
    this.searchEnabled = true,
    this.searchDebounce = const Duration(milliseconds: 250),
    this.hapticFeedback = true,
    this.enableScrollbar = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxHeight,
    this.minHeight = 240,
    this.dropdownMaxHeight,
    this.contentPadding,
    this.itemExtent,
    this.showSelectedIcon = true,
    this.initialSearchText,
    this.autofocusSearch = false,
    this.accentInsensitiveSearch = true,
  });

  /// Header title shown at the top of the picker. When null, a sensible
  /// default is chosen per picker type (e.g. `"Select state"`).
  final String? title;

  /// Hint text shown inside the search field.
  final String? searchHintText;

  /// Primary text shown when the filtered list is empty.
  final String? emptyStateText;

  /// Subtitle shown beneath [emptyStateText].
  final String? emptyStateSubtitle;

  /// Label on the cancel / dismiss action (dialog mode).
  final String cancelText;

  /// Label used when confirming a selection (dialog mode).
  final String selectText;

  /// Whether the search field is rendered.
  final bool searchEnabled;

  /// Debounce applied to search field changes.
  final Duration searchDebounce;

  /// Whether selecting an item fires a light haptic tick.
  final bool hapticFeedback;

  /// Whether the list shows a scrollbar.
  final bool enableScrollbar;

  /// Duration of surface animations (open / close transitions).
  final Duration animationDuration;

  /// Maximum height for bottom sheet / dialog variants.
  final double? maxHeight;

  /// Minimum height for bottom sheet / dialog variants.
  final double minHeight;

  /// Maximum height for the dropdown variant.
  final double? dropdownMaxHeight;

  /// Outer padding of the scrollable content.
  final EdgeInsetsGeometry? contentPadding;

  /// Fixed row height. When null, rows size to their content.
  final double? itemExtent;

  /// Whether to show the trailing check icon on the selected row.
  final bool showSelectedIcon;

  /// Pre-populates the search field when the picker first opens.
  final String? initialSearchText;

  /// Requests keyboard focus on the search field as soon as the picker is
  /// mounted. Handy for `fullScreen` mode.
  final bool autofocusSearch;

  /// When true (default), queries like `sao paulo` match `São Paulo` and
  /// `karlovy vary` matches `Karlový Vary` by folding Latin-extended
  /// diacritics to ASCII before comparison.
  final bool accentInsensitiveSearch;

  /// Returns a copy of this config with the given fields replaced.
  GeoPickerConfig copyWith({
    String? title,
    String? searchHintText,
    String? emptyStateText,
    String? emptyStateSubtitle,
    String? cancelText,
    String? selectText,
    bool? searchEnabled,
    Duration? searchDebounce,
    bool? hapticFeedback,
    bool? enableScrollbar,
    Duration? animationDuration,
    double? maxHeight,
    double? minHeight,
    double? dropdownMaxHeight,
    EdgeInsetsGeometry? contentPadding,
    double? itemExtent,
    bool? showSelectedIcon,
    String? initialSearchText,
    bool? autofocusSearch,
    bool? accentInsensitiveSearch,
  }) {
    return GeoPickerConfig(
      title: title ?? this.title,
      searchHintText: searchHintText ?? this.searchHintText,
      emptyStateText: emptyStateText ?? this.emptyStateText,
      emptyStateSubtitle: emptyStateSubtitle ?? this.emptyStateSubtitle,
      cancelText: cancelText ?? this.cancelText,
      selectText: selectText ?? this.selectText,
      searchEnabled: searchEnabled ?? this.searchEnabled,
      searchDebounce: searchDebounce ?? this.searchDebounce,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      enableScrollbar: enableScrollbar ?? this.enableScrollbar,
      animationDuration: animationDuration ?? this.animationDuration,
      maxHeight: maxHeight ?? this.maxHeight,
      minHeight: minHeight ?? this.minHeight,
      dropdownMaxHeight: dropdownMaxHeight ?? this.dropdownMaxHeight,
      contentPadding: contentPadding ?? this.contentPadding,
      itemExtent: itemExtent ?? this.itemExtent,
      showSelectedIcon: showSelectedIcon ?? this.showSelectedIcon,
      initialSearchText: initialSearchText ?? this.initialSearchText,
      autofocusSearch: autofocusSearch ?? this.autofocusSearch,
      accentInsensitiveSearch: accentInsensitiveSearch ?? this.accentInsensitiveSearch,
    );
  }
}
