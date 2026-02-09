import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:flutter/material.dart';
import '../models/country.dart';
import 'comprehensive_country_picker.dart';
import 'country_picker_theme.dart';
import 'country_picker_config.dart' as config;

/// {@template modal_comprehensive_picker}
/// Modal display methods for the comprehensive country picker
/// {@endtemplate}
class ModalComprehensivePicker {
  /// Show country picker as bottom sheet
  static Future<Country?> showBottomSheet({
    required BuildContext context,
    Country? initialCountry,
    ValueChanged<Country>? onCountrySelected,
    ValueChanged<Country>? onCountryChanged,
    ValueChanged<String>? onSearchChanged,
    ValueChanged<CountryFilter>? onFilterChanged,
    CountryPickerTheme? theme,
    config.CountryPickerConfig? config,
    bool showPhoneCode = true,
    bool showFlag = true,
    bool showCountryName = true,
    bool showCapital = false,
    bool showRegion = false,
    bool showPopulation = false,
    bool searchEnabled = true,
    bool filterEnabled = false,
    bool hapticFeedback = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration debounceDuration = const Duration(milliseconds: 300),
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool useSafeArea = true,
    Color? barrierColor,
    String? barrierLabel,
    bool barrierDismissible = true,
    RouteSettings? routeSettings,
  }) async {
    final result = await showModalBottomSheet<Country>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      useSafeArea: useSafeArea,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel ?? 'Close dialog',
      routeSettings: routeSettings,
      backgroundColor: Colors.transparent,
      builder: (context) => ComprehensiveCountryPicker(
        initialCountry: initialCountry,
        onCountrySelected: onCountrySelected,
        onCountryChanged: onCountryChanged,
        onSearchChanged: onSearchChanged,
        onFilterChanged: onFilterChanged,
        theme: theme,
        config: config,
        pickerType: CountryPickerType.bottomSheet,
        showPhoneCode: showPhoneCode,
        showFlag: showFlag,
        showCountryName: showCountryName,
        showCapital: showCapital,
        showRegion: showRegion,
        showPopulation: showPopulation,
        searchEnabled: searchEnabled,
        filterEnabled: filterEnabled,
        hapticFeedback: hapticFeedback,
        animationDuration: animationDuration,
        debounceDuration: debounceDuration,
      ),
    );
    return result;
  }

  /// Show country picker as dialog
  static Future<Country?> showDialog({
    required BuildContext context,
    Country? initialCountry,
    ValueChanged<Country>? onCountrySelected,
    ValueChanged<Country>? onCountryChanged,
    ValueChanged<String>? onSearchChanged,
    ValueChanged<CountryFilter>? onFilterChanged,
    CountryPickerTheme? theme,
    config.CountryPickerConfig? config,
    bool showPhoneCode = true,
    bool showFlag = true,
    bool showCountryName = true,
    bool showCapital = false,
    bool showRegion = false,
    bool showPopulation = false,
    bool searchEnabled = true,
    bool filterEnabled = false,
    bool hapticFeedback = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration debounceDuration = const Duration(milliseconds: 300),
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) async {
    final result = await showGeneralDialog<Country>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel ?? 'Close dialog',
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      pageBuilder: (context, animation, secondaryAnimation) => ComprehensiveCountryPicker(
        initialCountry: initialCountry,
        onCountrySelected: onCountrySelected,
        onCountryChanged: onCountryChanged,
        onSearchChanged: onSearchChanged,
        onFilterChanged: onFilterChanged,
        theme: theme,
        config: config,
        pickerType: CountryPickerType.dialog,
        showPhoneCode: showPhoneCode,
        showFlag: showFlag,
        showCountryName: showCountryName,
        showCapital: showCapital,
        showRegion: showRegion,
        showPopulation: showPopulation,
        searchEnabled: searchEnabled,
        filterEnabled: filterEnabled,
        hapticFeedback: hapticFeedback,
        animationDuration: animationDuration,
        debounceDuration: debounceDuration,
      ),
    );
    return result;
  }

  /// Show country picker as full screen
  static Future<Country?> showFullScreen({
    required BuildContext context,
    Country? initialCountry,
    ValueChanged<Country>? onCountrySelected,
    ValueChanged<Country>? onCountryChanged,
    ValueChanged<String>? onSearchChanged,
    ValueChanged<CountryFilter>? onFilterChanged,
    CountryPickerTheme? theme,
    config.CountryPickerConfig? config,
    bool showPhoneCode = true,
    bool showFlag = true,
    bool showCountryName = true,
    bool showCapital = false,
    bool showRegion = false,
    bool showPopulation = false,
    bool searchEnabled = true,
    bool filterEnabled = false,
    bool hapticFeedback = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration debounceDuration = const Duration(milliseconds: 300),
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) async {
    final result = await Navigator.of(context, rootNavigator: useRootNavigator).push<Country>(
      MaterialPageRoute<Country>(
        settings: routeSettings,
        builder: (context) => ComprehensiveCountryPicker(
          initialCountry: initialCountry,
          onCountrySelected: onCountrySelected,
          onCountryChanged: onCountryChanged,
          onSearchChanged: onSearchChanged,
          onFilterChanged: onFilterChanged,
          theme: theme,
          config: config,
          pickerType: CountryPickerType.fullScreen,
          showPhoneCode: showPhoneCode,
          showFlag: showFlag,
          showCountryName: showCountryName,
          showCapital: showCapital,
          showRegion: showRegion,
          showPopulation: showPopulation,
          searchEnabled: searchEnabled,
          filterEnabled: filterEnabled,
          hapticFeedback: hapticFeedback,
          animationDuration: animationDuration,
          debounceDuration: debounceDuration,
        ),
      ),
    );
    return result;
  }

  /// Create country picker as dropdown widget (for embedding in forms/UI)
  ///
  /// This returns a Widget that can be embedded directly in your UI.
  /// The dropdown shows the selected country and opens a menu below when tapped.
  ///
  /// Example:
  /// ```dart
  /// ModalComprehensivePicker.dropdown(
  ///   initialCountry: selectedCountry,
  ///   onCountrySelected: (country) {
  ///     setState(() => selectedCountry = country);
  ///   },
  /// )
  /// ```
  static Widget dropdown({
    Country? initialCountry,
    ValueChanged<Country>? onCountrySelected,
    ValueChanged<Country>? onCountryChanged,
    CountryPickerTheme? theme,
    config.CountryPickerConfig? config,
    bool showPhoneCode = true,
    bool showFlag = true,
    bool showCountryName = true,
    bool hapticFeedback = true,
  }) {
    return ComprehensiveCountryPicker(
      initialCountry: initialCountry,
      onCountrySelected: onCountrySelected,
      onCountryChanged: onCountryChanged,
      theme: theme,
      config: config,
      pickerType: CountryPickerType.dropdown,
      showPhoneCode: showPhoneCode,
      showFlag: showFlag,
      showCountryName: showCountryName,
      searchEnabled: false,
      filterEnabled: false,
      hapticFeedback: hapticFeedback,
    );
  }

  /// Show country picker inline
  static Widget showInline({
    Country? initialCountry,
    ValueChanged<Country>? onCountrySelected,
    ValueChanged<Country>? onCountryChanged,
    ValueChanged<String>? onSearchChanged,
    ValueChanged<CountryFilter>? onFilterChanged,
    CountryPickerTheme? theme,
    config.CountryPickerConfig? config,
    bool showPhoneCode = true,
    bool showFlag = true,
    bool showCountryName = true,
    bool showCapital = false,
    bool showRegion = false,
    bool showPopulation = false,
    bool searchEnabled = true,
    bool filterEnabled = false,
    bool hapticFeedback = true,
    Duration animationDuration = const Duration(milliseconds: 300),
    Duration debounceDuration = const Duration(milliseconds: 300),
  }) {
    return ComprehensiveCountryPicker(
      initialCountry: initialCountry,
      onCountrySelected: onCountrySelected,
      onCountryChanged: onCountryChanged,
      onSearchChanged: onSearchChanged,
      onFilterChanged: onFilterChanged,
      theme: theme,
      config: config,
      pickerType: CountryPickerType.inline,
      showPhoneCode: showPhoneCode,
      showFlag: showFlag,
      showCountryName: showCountryName,
      showCapital: showCapital,
      showRegion: showRegion,
      showPopulation: showPopulation,
      searchEnabled: searchEnabled,
      filterEnabled: filterEnabled,
      hapticFeedback: hapticFeedback,
      animationDuration: animationDuration,
      debounceDuration: debounceDuration,
    );
  }
}
