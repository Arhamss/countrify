import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';

/// {@template country_picker_theme}
/// Comprehensive theme configuration for the country picker
/// {@endtemplate}
class CountryPickerTheme {
  /// {@macro country_picker_theme}
  const CountryPickerTheme({
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
    this.searchHintText,
    this.searchCursorColor,
    this.searchFocusedBorderColor,
    this.searchContentPadding,
    this.searchInputDecoration,
    this.filterBackgroundColor,
    this.filterSelectedColor,
    this.filterTextColor,
    this.filterSelectedTextColor,
    this.filterCheckmarkColor,
    this.filterIconColor,
    this.filterTextStyle,
    this.countryItemBackgroundColor,
    this.countryItemSelectedColor,
    this.countryItemSelectedBorderColor,
    this.countryItemSelectedIconColor,
    this.countryItemBorderRadius,
    this.countryNameTextStyle,
    this.countrySubtitleTextStyle,
    this.borderColor,
    this.borderRadius,
    this.scrollbarThickness,
    this.scrollbarRadius,
    this.shadowColor,
    this.elevation,
    this.animationDuration,
    this.hapticFeedback,
    this.dropdownMenuBackgroundColor,
    this.dropdownMenuElevation,
    this.dropdownMenuBorderRadius,
    this.dropdownMenuBorderColor,
    this.dropdownMenuBorderWidth,
    this.closeIcon,
    this.searchIcon,
    this.clearIcon,
    this.selectedIcon,
    this.filterIcon,
    this.dropdownIcon,
    this.emptyStateIcon,
    this.defaultCountryIcon,
  });

  /// Background color of the picker
  final Color? backgroundColor;

  /// Header background color
  final Color? headerColor;

  /// Header text style
  final TextStyle? headerTextStyle;

  /// Header icon color
  final Color? headerIconColor;

  /// Search bar background color
  final Color? searchBarColor;

  /// Search text style
  final TextStyle? searchTextStyle;

  /// Search hint text style
  final TextStyle? searchHintStyle;

  /// Search icon color
  final Color? searchIconColor;

  /// Search bar border color
  final Color? searchBarBorderColor;

  /// Search bar border radius
  final BorderRadius? searchBarBorderRadius;

  /// Search bar hint text (defaults to 'Search countries...')
  final String? searchHintText;

  /// Search bar cursor color
  final Color? searchCursorColor;

  /// Search bar focused border color (defaults to searchBarBorderColor or blue)
  final Color? searchFocusedBorderColor;

  /// Search bar content padding
  final EdgeInsets? searchContentPadding;

  /// Full custom InputDecoration for the search field.
  /// When provided, this overrides all other search styling properties.
  final InputDecoration? searchInputDecoration;

  /// Filter background color
  final Color? filterBackgroundColor;

  /// Filter selected color
  final Color? filterSelectedColor;

  /// Filter text color
  final Color? filterTextColor;

  /// Filter selected text color
  final Color? filterSelectedTextColor;

  /// Filter checkmark color
  final Color? filterCheckmarkColor;

  /// Filter icon color
  final Color? filterIconColor;

  /// Filter text style
  final TextStyle? filterTextStyle;

  /// Country item background color
  final Color? countryItemBackgroundColor;

  /// Country item selected background color
  final Color? countryItemSelectedColor;

  /// Country item selected border color
  final Color? countryItemSelectedBorderColor;

  /// Country item selected icon color
  final Color? countryItemSelectedIconColor;

  /// Country item border radius
  final BorderRadius? countryItemBorderRadius;

  /// Country name text style
  final TextStyle? countryNameTextStyle;

  /// Country subtitle text style
  final TextStyle? countrySubtitleTextStyle;

  /// General border color
  final Color? borderColor;

  /// General border radius
  final BorderRadius? borderRadius;

  /// Scrollbar thickness
  final double? scrollbarThickness;

  /// Scrollbar radius
  final BorderRadius? scrollbarRadius;

  /// Shadow color
  final Color? shadowColor;

  /// Elevation
  final double? elevation;

  /// Animation duration
  final Duration? animationDuration;

  /// Haptic feedback enabled
  final bool? hapticFeedback;

  /// Dropdown menu background color
  final Color? dropdownMenuBackgroundColor;

  /// Dropdown menu elevation
  final double? dropdownMenuElevation;

  /// Dropdown menu border radius
  final BorderRadius? dropdownMenuBorderRadius;

  /// Dropdown menu border color
  final Color? dropdownMenuBorderColor;

  /// Dropdown menu border width
  final double? dropdownMenuBorderWidth;

  // ─── Customizable Icons ─────────────────────────────────────────────

  /// Icon for close buttons (header close, fullscreen close).
  /// Defaults to [CountrifyIcons.x].
  final IconData? closeIcon;

  /// Icon for the search field prefix.
  /// Defaults to [CountrifyIcons.search].
  final IconData? searchIcon;

  /// Icon for the search field clear button.
  /// Defaults to [CountrifyIcons.circleX].
  final IconData? clearIcon;

  /// Icon shown on the selected country item.
  /// Defaults to [CountrifyIcons.circleCheckBig].
  final IconData? selectedIcon;

  /// Icon for filter buttons.
  /// Defaults to [CountrifyIcons.listFilter].
  final IconData? filterIcon;

  /// Icon for dropdown arrows.
  /// Defaults to [CountrifyIcons.chevronDown].
  final IconData? dropdownIcon;

  /// Icon shown in the empty search state.
  /// Defaults to [CountrifyIcons.searchX].
  final IconData? emptyStateIcon;

  /// Default icon when no country flag is available.
  /// Defaults to [CountrifyIcons.globe].
  final IconData? defaultCountryIcon;

  /// Default theme
  static CountryPickerTheme defaultTheme() {
    return const CountryPickerTheme(
      backgroundColor: Colors.white,
      headerColor: Color(0xFFF5F5F5),
      headerTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      headerIconColor: Colors.black54,
      searchBarColor: Color(0xFFF8F9FA),
      searchTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      searchHintStyle: TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
      searchIconColor: Colors.black54,
      searchBarBorderColor: Color(0xFFE0E0E0),
      searchBarBorderRadius: BorderRadius.all(Radius.circular(12)),
      filterBackgroundColor: Color(0xFFF0F0F0),
      filterSelectedColor: Color(0xFF2196F3),
      filterTextColor: Colors.black87,
      filterSelectedTextColor: Colors.white,
      filterCheckmarkColor: Colors.white,
      filterIconColor: Colors.black54,
      filterTextStyle: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      countryItemBackgroundColor: Colors.white,
      countryItemSelectedColor: Color(0xFFE3F2FD),
      countryItemSelectedBorderColor: Color(0xFF2196F3),
      countryItemSelectedIconColor: Color(0xFF2196F3),
      countryItemBorderRadius: BorderRadius.all(Radius.circular(8)),
      countryNameTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      countrySubtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
      borderColor: Color(0xFFE0E0E0),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      scrollbarThickness: 6,
      scrollbarRadius: BorderRadius.all(Radius.circular(3)),
      shadowColor: Color(0x1A000000),
      elevation: 8,
      animationDuration: Duration(milliseconds: 300),
      hapticFeedback: true,
    );
  }

  /// Dark theme
  static CountryPickerTheme darkTheme() {
    return const CountryPickerTheme(
      backgroundColor: Color(0xFF1E1E1E),
      headerColor: Color(0xFF2D2D2D),
      headerTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headerIconColor: Colors.white70,
      searchBarColor: Color(0xFF2D2D2D),
      searchTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      searchHintStyle: TextStyle(
        fontSize: 16,
        color: Colors.white60,
      ),
      searchIconColor: Colors.white60,
      searchBarBorderColor: Color(0xFF404040),
      searchBarBorderRadius: BorderRadius.all(Radius.circular(12)),
      filterBackgroundColor: Color(0xFF2D2D2D),
      filterSelectedColor: Color(0xFF64B5F6),
      filterTextColor: Colors.white,
      filterSelectedTextColor: Colors.black,
      filterCheckmarkColor: Colors.black,
      filterIconColor: Colors.white60,
      filterTextStyle: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      countryItemBackgroundColor: Color(0xFF2D2D2D),
      countryItemSelectedColor: Color(0xFF1A237E),
      countryItemSelectedBorderColor: Color(0xFF64B5F6),
      countryItemSelectedIconColor: Color(0xFF64B5F6),
      countryItemBorderRadius: BorderRadius.all(Radius.circular(8)),
      countryNameTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      countrySubtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      borderColor: Color(0xFF404040),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      scrollbarThickness: 6,
      scrollbarRadius: BorderRadius.all(Radius.circular(3)),
      shadowColor: Color(0x1A000000),
      elevation: 8,
      animationDuration: Duration(milliseconds: 300),
      hapticFeedback: true,
    );
  }

  /// Material Design 3 theme
  static CountryPickerTheme material3Theme() {
    return const CountryPickerTheme(
      backgroundColor: Color(0xFFFFFBFE),
      headerColor: Color(0xFFF3EDF7),
      headerTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1C1B1F),
      ),
      headerIconColor: Color(0xFF49454F),
      searchBarColor: Color(0xFFF3EDF7),
      searchTextStyle: TextStyle(
        fontSize: 16,
        color: Color(0xFF1C1B1F),
      ),
      searchHintStyle: TextStyle(
        fontSize: 16,
        color: Color(0xFF49454F),
      ),
      searchIconColor: Color(0xFF49454F),
      searchBarBorderColor: Color(0xFF79747E),
      searchBarBorderRadius: BorderRadius.all(Radius.circular(16)),
      filterBackgroundColor: Color(0xFFE8DEF8),
      filterSelectedColor: Color(0xFF6750A4),
      filterTextColor: Color(0xFF1C1B1F),
      filterSelectedTextColor: Color(0xFFFFFBFE),
      filterCheckmarkColor: Color(0xFFFFFBFE),
      filterIconColor: Color(0xFF49454F),
      countryItemBackgroundColor: Color(0xFFFFFBFE),
      countryItemSelectedColor: Color(0xFFE8DEF8),
      countryItemSelectedBorderColor: Color(0xFF6750A4),
      countryItemSelectedIconColor: Color(0xFF6750A4),
      countryItemBorderRadius: BorderRadius.all(Radius.circular(12)),
      countryNameTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1C1B1F),
      ),
      countrySubtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF49454F),
      ),
      borderColor: Color(0xFF79747E),
      borderRadius: BorderRadius.all(Radius.circular(28)),
      scrollbarThickness: 6,
      scrollbarRadius: BorderRadius.all(Radius.circular(3)),
      shadowColor: Color(0x1A6750A4),
      elevation: 8,
      animationDuration: Duration(milliseconds: 300),
      hapticFeedback: true,
    );
  }

  /// Custom theme builder
  static CountryPickerTheme custom({
    Color? primaryColor,
    Color? backgroundColor,
    Color? surfaceColor,
    Color? onSurfaceColor,
    Color? onBackgroundColor,
    bool isDark = false,
  }) {
    final baseColor = primaryColor ??
        (isDark ? const Color(0xFF64B5F6) : const Color(0xFF2196F3));
    final bgColor =
        backgroundColor ?? (isDark ? const Color(0xFF1E1E1E) : Colors.white);
    final surface = surfaceColor ??
        (isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF5F5F5));
    final onSurface =
        onSurfaceColor ?? (isDark ? Colors.white : Colors.black87);

    return CountryPickerTheme(
      backgroundColor: bgColor,
      headerColor: surface,
      headerTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      headerIconColor: onSurface.withValues(alpha: 0.7),
      searchBarColor: surface,
      searchTextStyle: TextStyle(
        fontSize: 16,
        color: onSurface,
      ),
      searchHintStyle: TextStyle(
        fontSize: 16,
        color: onSurface.withValues(alpha: 0.6),
      ),
      searchIconColor: onSurface.withValues(alpha: 0.6),
      searchBarBorderColor: onSurface.withValues(alpha: 0.2),
      searchBarBorderRadius: const BorderRadius.all(Radius.circular(12)),
      filterBackgroundColor: surface,
      filterSelectedColor: baseColor,
      filterTextColor: onSurface,
      filterSelectedTextColor: isDark ? Colors.black : Colors.white,
      filterCheckmarkColor: isDark ? Colors.black : Colors.white,
      filterIconColor: onSurface.withValues(alpha: 0.6),
      countryItemBackgroundColor: bgColor,
      countryItemSelectedColor: baseColor.withValues(alpha: 0.1),
      countryItemSelectedBorderColor: baseColor,
      countryItemSelectedIconColor: baseColor,
      countryItemBorderRadius: const BorderRadius.all(Radius.circular(8)),
      countryNameTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: onSurface,
      ),
      countrySubtitleTextStyle: TextStyle(
        fontSize: 14,
        color: onSurface.withValues(alpha: 0.7),
      ),
      borderColor: onSurface.withValues(alpha: 0.2),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      scrollbarThickness: 6,
      scrollbarRadius: const BorderRadius.all(Radius.circular(3)),
      shadowColor: baseColor.withValues(alpha: 0.1),
      elevation: 8,
      animationDuration: const Duration(milliseconds: 300),
      hapticFeedback: true,
    );
  }

  /// Copy with method
  CountryPickerTheme copyWith({
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
    String? searchHintText,
    Color? searchCursorColor,
    Color? searchFocusedBorderColor,
    EdgeInsets? searchContentPadding,
    InputDecoration? searchInputDecoration,
    Color? filterBackgroundColor,
    Color? filterSelectedColor,
    Color? filterTextColor,
    Color? filterSelectedTextColor,
    Color? filterCheckmarkColor,
    Color? filterIconColor,
    TextStyle? filterTextStyle,
    Color? countryItemBackgroundColor,
    Color? countryItemSelectedColor,
    Color? countryItemSelectedBorderColor,
    Color? countryItemSelectedIconColor,
    BorderRadius? countryItemBorderRadius,
    TextStyle? countryNameTextStyle,
    TextStyle? countrySubtitleTextStyle,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? scrollbarThickness,
    BorderRadius? scrollbarRadius,
    Color? shadowColor,
    double? elevation,
    Duration? animationDuration,
    bool? hapticFeedback,
    Color? dropdownMenuBackgroundColor,
    double? dropdownMenuElevation,
    BorderRadius? dropdownMenuBorderRadius,
    Color? dropdownMenuBorderColor,
    double? dropdownMenuBorderWidth,
    IconData? closeIcon,
    IconData? searchIcon,
    IconData? clearIcon,
    IconData? selectedIcon,
    IconData? filterIcon,
    IconData? dropdownIcon,
    IconData? emptyStateIcon,
    IconData? defaultCountryIcon,
  }) {
    return CountryPickerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerColor: headerColor ?? this.headerColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerIconColor: headerIconColor ?? this.headerIconColor,
      searchBarColor: searchBarColor ?? this.searchBarColor,
      searchTextStyle: searchTextStyle ?? this.searchTextStyle,
      searchHintStyle: searchHintStyle ?? this.searchHintStyle,
      searchIconColor: searchIconColor ?? this.searchIconColor,
      searchBarBorderColor: searchBarBorderColor ?? this.searchBarBorderColor,
      searchBarBorderRadius:
          searchBarBorderRadius ?? this.searchBarBorderRadius,
      searchHintText: searchHintText ?? this.searchHintText,
      searchCursorColor: searchCursorColor ?? this.searchCursorColor,
      searchFocusedBorderColor:
          searchFocusedBorderColor ?? this.searchFocusedBorderColor,
      searchContentPadding: searchContentPadding ?? this.searchContentPadding,
      searchInputDecoration:
          searchInputDecoration ?? this.searchInputDecoration,
      filterBackgroundColor:
          filterBackgroundColor ?? this.filterBackgroundColor,
      filterSelectedColor: filterSelectedColor ?? this.filterSelectedColor,
      filterTextColor: filterTextColor ?? this.filterTextColor,
      filterSelectedTextColor:
          filterSelectedTextColor ?? this.filterSelectedTextColor,
      filterCheckmarkColor: filterCheckmarkColor ?? this.filterCheckmarkColor,
      filterIconColor: filterIconColor ?? this.filterIconColor,
      filterTextStyle: filterTextStyle ?? this.filterTextStyle,
      countryItemBackgroundColor:
          countryItemBackgroundColor ?? this.countryItemBackgroundColor,
      countryItemSelectedColor:
          countryItemSelectedColor ?? this.countryItemSelectedColor,
      countryItemSelectedBorderColor:
          countryItemSelectedBorderColor ?? this.countryItemSelectedBorderColor,
      countryItemSelectedIconColor:
          countryItemSelectedIconColor ?? this.countryItemSelectedIconColor,
      countryItemBorderRadius:
          countryItemBorderRadius ?? this.countryItemBorderRadius,
      countryNameTextStyle: countryNameTextStyle ?? this.countryNameTextStyle,
      countrySubtitleTextStyle:
          countrySubtitleTextStyle ?? this.countrySubtitleTextStyle,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      scrollbarThickness: scrollbarThickness ?? this.scrollbarThickness,
      scrollbarRadius: scrollbarRadius ?? this.scrollbarRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      animationDuration: animationDuration ?? this.animationDuration,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      dropdownMenuBackgroundColor:
          dropdownMenuBackgroundColor ?? this.dropdownMenuBackgroundColor,
      dropdownMenuElevation:
          dropdownMenuElevation ?? this.dropdownMenuElevation,
      dropdownMenuBorderRadius:
          dropdownMenuBorderRadius ?? this.dropdownMenuBorderRadius,
      dropdownMenuBorderColor:
          dropdownMenuBorderColor ?? this.dropdownMenuBorderColor,
      dropdownMenuBorderWidth:
          dropdownMenuBorderWidth ?? this.dropdownMenuBorderWidth,
      closeIcon: closeIcon ?? this.closeIcon,
      searchIcon: searchIcon ?? this.searchIcon,
      clearIcon: clearIcon ?? this.clearIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      filterIcon: filterIcon ?? this.filterIcon,
      dropdownIcon: dropdownIcon ?? this.dropdownIcon,
      emptyStateIcon: emptyStateIcon ?? this.emptyStateIcon,
      defaultCountryIcon: defaultCountryIcon ?? this.defaultCountryIcon,
    );
  }
}
