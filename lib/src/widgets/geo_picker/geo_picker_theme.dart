import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';

/// {@template geo_picker_theme}
/// Comprehensive theme configuration shared by `StatePicker` and
/// `CityPicker`.
///
/// Every visual aspect (colors, borders, radii, typography, icons) can be
/// overridden. Omitted fields fall back to sensible defaults pulled from the
/// ambient [ThemeData].
///
/// ```dart
/// StatePicker(
///   countryIso2: 'US',
///   theme: GeoPickerTheme(
///     backgroundColor: Colors.white,
///     headerTextStyle: TextStyle(fontWeight: FontWeight.w700),
///     itemSelectedColor: Colors.blue.shade50,
///   ),
/// )
/// ```
/// {@endtemplate}
@immutable
class GeoPickerTheme {
  /// {@macro geo_picker_theme}
  const GeoPickerTheme({
    this.backgroundColor,
    this.headerColor,
    this.headerTextStyle,
    this.headerIconColor,
    this.searchBarColor,
    this.searchTextStyle,
    this.searchHintStyle,
    this.searchIconColor,
    this.searchBarBorderColor,
    this.searchBarBorderRadius,
    this.searchCursorColor,
    this.searchFocusedBorderColor,
    this.searchContentPadding,
    this.searchInputDecoration,
    this.itemBackgroundColor,
    this.itemSelectedColor,
    this.itemSelectedBorderColor,
    this.itemSelectedIconColor,
    this.itemBorderRadius,
    this.itemContentPadding,
    this.itemNameTextStyle,
    this.itemSubtitleTextStyle,
    this.dialogOptionTextStyle,
    this.borderColor,
    this.borderRadius,
    this.scrollbarThickness,
    this.scrollbarRadius,
    this.shadowColor,
    this.elevation,
    this.closeIcon,
    this.searchIcon,
    this.clearIcon,
    this.selectedIcon,
    this.emptyStateIcon,
    this.emptyStateTextStyle,
  });

  /// A light-theme default that matches Material 3 surface colors.
  factory GeoPickerTheme.light() => const GeoPickerTheme(
        backgroundColor: Colors.white,
        headerColor: Colors.white,
        itemBackgroundColor: Colors.transparent,
        itemSelectedColor: Color(0xFFE3F2FD),
        itemSelectedBorderColor: Color(0xFF2196F3),
      );

  /// A dark-theme default.
  factory GeoPickerTheme.dark() => const GeoPickerTheme(
        backgroundColor: Color(0xFF1E1E1E),
        headerColor: Color(0xFF1E1E1E),
        headerTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        headerIconColor: Colors.white70,
        searchBarColor: Color(0xFF2C2C2C),
        searchTextStyle: TextStyle(color: Colors.white),
        searchHintStyle: TextStyle(color: Colors.white54),
        searchIconColor: Colors.white70,
        itemBackgroundColor: Colors.transparent,
        itemSelectedColor: Color(0xFF263B4D),
        itemSelectedBorderColor: Color(0xFF64B5F6),
        itemNameTextStyle: TextStyle(color: Colors.white),
        itemSubtitleTextStyle: TextStyle(color: Colors.white70),
      );

  /// Background color of the picker surface.
  final Color? backgroundColor;

  /// Background color of the title / header row.
  final Color? headerColor;

  /// Text style of the header title.
  final TextStyle? headerTextStyle;

  /// Color applied to the close / dismiss icon in the header.
  final Color? headerIconColor;

  /// Fill color of the search field.
  final Color? searchBarColor;

  /// Text style of the search field input.
  final TextStyle? searchTextStyle;

  /// Hint text style of the search field.
  final TextStyle? searchHintStyle;

  /// Color of the leading search icon / trailing clear icon.
  final Color? searchIconColor;

  /// Border color of the search field when idle.
  final Color? searchBarBorderColor;

  /// Border radius of the search field.
  final BorderRadius? searchBarBorderRadius;

  /// Cursor color of the search field.
  final Color? searchCursorColor;

  /// Border color of the search field when focused.
  final Color? searchFocusedBorderColor;

  /// Content padding inside the search field.
  final EdgeInsetsGeometry? searchContentPadding;

  /// Fully-custom [InputDecoration] override for the search field. When
  /// provided, takes precedence over the other `search*` properties.
  final InputDecoration? searchInputDecoration;

  /// Background color of an individual item row.
  final Color? itemBackgroundColor;

  /// Background color of the currently selected row.
  final Color? itemSelectedColor;

  /// Border color drawn around the currently selected row.
  final Color? itemSelectedBorderColor;

  /// Color of the trailing check icon shown on the selected row.
  final Color? itemSelectedIconColor;

  /// Border radius applied to item rows.
  final BorderRadius? itemBorderRadius;

  /// Content padding inside an item row.
  final EdgeInsetsGeometry? itemContentPadding;

  /// Text style of the primary label inside an item row.
  final TextStyle? itemNameTextStyle;

  /// Text style of the secondary label (subtitle) inside an item row.
  final TextStyle? itemSubtitleTextStyle;

  /// Text style applied to option labels inside the dialog variant.
  final TextStyle? dialogOptionTextStyle;

  /// Border color of the picker surface.
  final Color? borderColor;

  /// Border radius of the picker surface.
  final BorderRadius? borderRadius;

  /// Thickness of the list scrollbar.
  final double? scrollbarThickness;

  /// Corner radius of the list scrollbar.
  final Radius? scrollbarRadius;

  /// Shadow color beneath the picker surface.
  final Color? shadowColor;

  /// Shadow elevation of the picker surface.
  final double? elevation;

  /// Icon shown in the top-right of the header to dismiss the picker.
  final IconData? closeIcon;

  /// Leading icon inside the search field.
  final IconData? searchIcon;

  /// Trailing icon shown when the search field has content.
  final IconData? clearIcon;

  /// Icon shown next to the currently selected row.
  final IconData? selectedIcon;

  /// Icon shown on the empty-results state.
  final IconData? emptyStateIcon;

  /// Text style used by the empty-results state.
  final TextStyle? emptyStateTextStyle;

  /// Returns the close icon with a sensible default.
  IconData get resolvedCloseIcon => closeIcon ?? CountrifyIcons.x;

  /// Returns the search icon with a sensible default.
  IconData get resolvedSearchIcon => searchIcon ?? CountrifyIcons.search;

  /// Returns the clear icon with a sensible default.
  IconData get resolvedClearIcon => clearIcon ?? CountrifyIcons.circleX;

  /// Returns the selected icon with a sensible default.
  IconData get resolvedSelectedIcon => selectedIcon ?? CountrifyIcons.circleCheckBig;

  /// Returns the empty-state icon with a sensible default.
  IconData get resolvedEmptyStateIcon => emptyStateIcon ?? CountrifyIcons.searchX;

  /// Returns a copy of this theme with the given fields replaced.
  GeoPickerTheme copyWith({
    Color? backgroundColor,
    Color? headerColor,
    TextStyle? headerTextStyle,
    Color? headerIconColor,
    Color? searchBarColor,
    TextStyle? searchTextStyle,
    TextStyle? searchHintStyle,
    Color? searchIconColor,
    Color? searchBarBorderColor,
    BorderRadius? searchBarBorderRadius,
    Color? searchCursorColor,
    Color? searchFocusedBorderColor,
    EdgeInsetsGeometry? searchContentPadding,
    InputDecoration? searchInputDecoration,
    Color? itemBackgroundColor,
    Color? itemSelectedColor,
    Color? itemSelectedBorderColor,
    Color? itemSelectedIconColor,
    BorderRadius? itemBorderRadius,
    EdgeInsetsGeometry? itemContentPadding,
    TextStyle? itemNameTextStyle,
    TextStyle? itemSubtitleTextStyle,
    TextStyle? dialogOptionTextStyle,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? scrollbarThickness,
    Radius? scrollbarRadius,
    Color? shadowColor,
    double? elevation,
    IconData? closeIcon,
    IconData? searchIcon,
    IconData? clearIcon,
    IconData? selectedIcon,
    IconData? emptyStateIcon,
    TextStyle? emptyStateTextStyle,
  }) {
    return GeoPickerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerColor: headerColor ?? this.headerColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      searchBarColor: searchBarColor ?? this.searchBarColor,
      searchTextStyle: searchTextStyle ?? this.searchTextStyle,
      searchHintStyle: searchHintStyle ?? this.searchHintStyle,
      searchIconColor: searchIconColor ?? this.searchIconColor,
      searchBarBorderColor: searchBarBorderColor ?? this.searchBarBorderColor,
      searchBarBorderRadius: searchBarBorderRadius ?? this.searchBarBorderRadius,
      searchCursorColor: searchCursorColor ?? this.searchCursorColor,
      searchFocusedBorderColor: searchFocusedBorderColor ?? this.searchFocusedBorderColor,
      searchContentPadding: searchContentPadding ?? this.searchContentPadding,
      searchInputDecoration: searchInputDecoration ?? this.searchInputDecoration,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemSelectedColor: itemSelectedColor ?? this.itemSelectedColor,
      itemSelectedBorderColor: itemSelectedBorderColor ?? this.itemSelectedBorderColor,
      itemSelectedIconColor: itemSelectedIconColor ?? this.itemSelectedIconColor,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemContentPadding: itemContentPadding ?? this.itemContentPadding,
      itemNameTextStyle: itemNameTextStyle ?? this.itemNameTextStyle,
      itemSubtitleTextStyle: itemSubtitleTextStyle ?? this.itemSubtitleTextStyle,
      dialogOptionTextStyle: dialogOptionTextStyle ?? this.dialogOptionTextStyle,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      scrollbarThickness: scrollbarThickness ?? this.scrollbarThickness,
      scrollbarRadius: scrollbarRadius ?? this.scrollbarRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      closeIcon: closeIcon ?? this.closeIcon,
      searchIcon: searchIcon ?? this.searchIcon,
      clearIcon: clearIcon ?? this.clearIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      emptyStateIcon: emptyStateIcon ?? this.emptyStateIcon,
      emptyStateTextStyle: emptyStateTextStyle ?? this.emptyStateTextStyle,
    );
  }
}
