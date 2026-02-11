import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/comprehensive_country_picker.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:flutter/material.dart';

/// {@template country_dropdown_field}
/// A text field-style dropdown for selecting countries with consistent styling.
///
/// Use [CountrifyFieldStyle] to customise every aspect of the field
/// decoration in one place:
///
/// ```dart
/// CountryDropdownField(
///   style: CountrifyFieldStyle.defaultStyle().copyWith(
///     labelText: 'Country',
///     fillColor: Colors.grey.shade50,
///   ),
///   onCountrySelected: (country) => print(country.name),
/// )
/// ```
/// {@endtemplate}
class CountryDropdownField extends StatefulWidget {
  /// {@macro country_dropdown_field}
  const CountryDropdownField({
    super.key,
    this.initialCountryCode,
    this.onCountrySelected,
    this.onCountryChanged,
    this.theme,
    this.config,
    this.style,
    this.enabled = true,
    this.showPhoneCode = true,
    this.showFlag = true,
    this.searchEnabled = true,
    this.filterEnabled = false,
    this.pickerType = PickerDisplayType.bottomSheet,
  });

  /// Initial selected country by enum code.
  final CountryCode? initialCountryCode;

  /// Callback when a country is selected.
  final ValueChanged<Country>? onCountrySelected;

  /// Callback when country selection changes.
  final ValueChanged<Country>? onCountryChanged;

  /// Theme configuration for the picker.
  final CountryPickerTheme? theme;

  /// Configuration options for the picker.
  final CountryPickerConfig? config;

  /// Modular style for the field. Controls every aspect of the
  /// [InputDecoration] plus extras like [selectedCountryTextStyle].
  ///
  /// When null, a default style is built from the [theme].
  final CountrifyFieldStyle? style;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether to show phone code in the field.
  final bool showPhoneCode;

  /// Whether to show country flag in the field.
  final bool showFlag;

  /// Whether search is enabled in the picker.
  final bool searchEnabled;

  /// Whether filtering is enabled in the picker.
  final bool filterEnabled;

  /// Type of picker to display.
  final PickerDisplayType pickerType;

  @override
  State<CountryDropdownField> createState() => _CountryDropdownFieldState();
}

class _CountryDropdownFieldState extends State<CountryDropdownField> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryUtils.resolveInitialCountry(
      initialCountryCode: widget.initialCountryCode,
    );
  }

  @override
  void didUpdateWidget(CountryDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountryCode != oldWidget.initialCountryCode) {
      setState(() {
        _selectedCountry = CountryUtils.resolveInitialCountry(
          initialCountryCode: widget.initialCountryCode,
        );
      });
    }
  }

  Future<void> _showPicker() async {
    if (!widget.enabled || widget.pickerType == PickerDisplayType.none) return;

    Country? selectedCountry;

    switch (widget.pickerType) {
      case PickerDisplayType.bottomSheet:
        selectedCountry = await _showBottomSheetPicker();
      case PickerDisplayType.dialog:
        selectedCountry = await _showDialogPicker();
      case PickerDisplayType.fullScreen:
        selectedCountry = await _showFullScreenPicker();
      case PickerDisplayType.none:
        return;
    }

    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
      });
      widget.onCountrySelected?.call(selectedCountry);
      widget.onCountryChanged?.call(selectedCountry);
    }
  }

  Future<Country?> _showBottomSheetPicker() async {
    return showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        height: MediaQuery.of(sheetContext).size.height * 0.8,
        decoration: BoxDecoration(
          color: widget.theme?.backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ComprehensiveCountryPicker(
          initialCountryCode: CountryCodeExtension.fromAlpha2Code(
              _selectedCountry?.alpha2Code ?? ''),
          theme: widget.theme,
          config: widget.config,
          showPhoneCode: widget.showPhoneCode,
          showFlag: widget.showFlag,
          searchEnabled: widget.searchEnabled,
          filterEnabled: widget.filterEnabled,
        ),
      ),
    );
  }

  Future<Country?> _showDialogPicker() async {
    return showDialog<Country>(
      context: context,
      builder: (dialogContext) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(dialogContext).size.width * 0.9,
          height: MediaQuery.of(dialogContext).size.height * 0.8,
          child: ComprehensiveCountryPicker(
            initialCountryCode: CountryCodeExtension.fromAlpha2Code(
                _selectedCountry?.alpha2Code ?? ''),
            theme: widget.theme,
            config: widget.config,
            pickerType: CountryPickerType.dialog,
            showPhoneCode: widget.showPhoneCode,
            showFlag: widget.showFlag,
            searchEnabled: widget.searchEnabled,
            filterEnabled: widget.filterEnabled,
          ),
        ),
      ),
    );
  }

  Future<Country?> _showFullScreenPicker() async {
    return Navigator.of(context).push<Country>(
      MaterialPageRoute(
        builder: (routeContext) => ComprehensiveCountryPicker(
          initialCountryCode: CountryCodeExtension.fromAlpha2Code(
              _selectedCountry?.alpha2Code ?? ''),
          theme: widget.theme,
          config: widget.config,
          pickerType: CountryPickerType.fullScreen,
          showPhoneCode: widget.showPhoneCode,
          showFlag: widget.showFlag,
          searchEnabled: widget.searchEnabled,
          filterEnabled: widget.filterEnabled,
        ),
      ),
    );
  }

  String _displayName(Country country) {
    final locale = (widget.config ?? const CountryPickerConfig()).locale ??
        Localizations.localeOf(context).languageCode;
    if (locale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, locale);
  }

  String _getDisplayText() {
    final config = widget.config ?? const CountryPickerConfig();
    if (_selectedCountry == null) {
      return config.selectCountryHintText;
    }

    final parts = <String>[_displayName(_selectedCountry!)];

    if (widget.showPhoneCode && _selectedCountry!.callingCodes.isNotEmpty) {
      parts.add('(+${_selectedCountry!.callingCodes.first})');
    }

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? CountryPickerTheme.defaultTheme();
    final effectiveStyle =
        widget.style ?? CountrifyFieldStyle.defaultStyle();

    final prefixWidget = _selectedCountry != null && widget.showFlag
        ? Padding(
            padding: const EdgeInsets.all(12),
            child: _buildFlagWidget(_selectedCountry!),
          )
        : Icon(theme.defaultCountryIcon ?? CountrifyIcons.globe);

    final suffixWidget = Icon(
      theme.dropdownIcon ?? CountrifyIcons.chevronDown,
      color: widget.enabled ? null : Colors.grey,
    );

    final borderRadius =
        effectiveStyle.fieldBorderRadius ?? BorderRadius.circular(12);

    final decoration = effectiveStyle.toInputDecoration(
      prefixIconOverride: prefixWidget,
      suffixIconOverride: suffixWidget,
    );

    return InkWell(
      onTap: widget.enabled && widget.pickerType != PickerDisplayType.none
          ? _showPicker
          : null,
      borderRadius: borderRadius,
      child: InputDecorator(
        decoration: decoration,
        isEmpty: _selectedCountry == null,
        child: _selectedCountry != null
            ? Text(
                _getDisplayText(),
                style: effectiveStyle.selectedCountryTextStyle ??
                    theme.countryNameTextStyle,
              )
            : null,
      ),
    );
  }

  Widget _buildFlagWidget(Country country) {
    final config = widget.config ?? const CountryPickerConfig();
    final theme = widget.theme ?? CountryPickerTheme.defaultTheme();

    return Container(
      width: 32,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: config.flagBorderRadius,
        border: config.flagBorderColor != null
            ? Border.all(
                color: config.flagBorderColor!, width: config.flagBorderWidth)
            : null,
      ),
      child: ClipRRect(
        borderRadius: config.flagBorderRadius,
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ColoredBox(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  country.flagEmoji,
                  style:
                      theme.flagEmojiTextStyle ?? const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Types of picker display.
enum PickerDisplayType {
  /// Show picker as a bottom sheet.
  bottomSheet,

  /// Show picker as a dialog.
  dialog,

  /// Show picker as a full screen page.
  fullScreen,

  /// Keep current selection and disable opening a picker.
  none,
}
