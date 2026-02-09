import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/widgets/comprehensive_country_picker.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:flutter/material.dart';

/// {@template country_dropdown_field}
/// A text field-style dropdown for selecting countries with consistent styling
/// {@endtemplate}
class CountryDropdownField extends StatefulWidget {
  /// {@macro country_dropdown_field}
  const CountryDropdownField({
    super.key,
    this.initialCountry,
    this.onCountrySelected,
    this.onCountryChanged,
    this.theme,
    this.config,
    this.decoration,
    this.labelText,
    this.hintText,
    this.enabled = true,
    this.showPhoneCode = true,
    this.showFlag = true,
    this.searchEnabled = true,
    this.filterEnabled = false,
    this.pickerType = PickerDisplayType.bottomSheet,
  });

  /// Initial selected country
  final Country? initialCountry;

  /// Callback when a country is selected
  final ValueChanged<Country>? onCountrySelected;

  /// Callback when country selection changes
  final ValueChanged<Country>? onCountryChanged;

  /// Theme configuration
  final CountryPickerTheme? theme;

  /// Configuration options
  final CountryPickerConfig? config;

  /// Input decoration for the field
  final InputDecoration? decoration;

  /// Label text for the field
  final String? labelText;

  /// Hint text for the field
  final String? hintText;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to show phone code in the field
  final bool showPhoneCode;

  /// Whether to show country flag in the field
  final bool showFlag;

  /// Whether search is enabled in the picker
  final bool searchEnabled;

  /// Whether filtering is enabled in the picker
  final bool filterEnabled;

  /// Type of picker to display
  final PickerDisplayType pickerType;

  @override
  State<CountryDropdownField> createState() => _CountryDropdownFieldState();
}

class _CountryDropdownFieldState extends State<CountryDropdownField> {
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
  }

  @override
  void didUpdateWidget(CountryDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountry != oldWidget.initialCountry) {
      setState(() {
        _selectedCountry = widget.initialCountry;
      });
    }
  }

  Future<void> _showPicker() async {
    if (!widget.enabled) return;

    Country? selectedCountry;

    switch (widget.pickerType) {
      case PickerDisplayType.bottomSheet:
        selectedCountry = await _showBottomSheetPicker();
      case PickerDisplayType.dialog:
        selectedCountry = await _showDialogPicker();
      case PickerDisplayType.fullScreen:
        selectedCountry = await _showFullScreenPicker();
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
          initialCountry: _selectedCountry,
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
            initialCountry: _selectedCountry,
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
          initialCountry: _selectedCountry,
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

  String _getDisplayText() {
    if (_selectedCountry == null) {
      return widget.hintText ?? 'Select a country';
    }

    final parts = <String>[_selectedCountry!.name];

    if (widget.showPhoneCode && _selectedCountry!.callingCodes.isNotEmpty) {
      parts.add('(+${_selectedCountry!.callingCodes.first})');
    }

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? CountryPickerTheme.defaultTheme();

    final defaultDecoration = InputDecoration(
      labelText: widget.labelText,
      hintText: widget.hintText ?? 'Select a country',
      prefixIcon: _selectedCountry != null && widget.showFlag
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: _buildFlagWidget(_selectedCountry!),
            )
          : Icon(theme.defaultCountryIcon ?? CountrifyIcons.globe),
      suffixIcon: Icon(
        theme.dropdownIcon ?? CountrifyIcons.chevronDown,
        color: widget.enabled ? null : Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: theme.borderColor ?? Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: theme.countryItemSelectedBorderColor ?? Colors.blue,
            width: 2),
      ),
      filled: true,
      fillColor: widget.enabled ? theme.backgroundColor : Colors.grey.shade100,
    );

    return InkWell(
      onTap: _showPicker,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: widget.decoration ?? defaultDecoration,
        isEmpty: _selectedCountry == null,
        child: _selectedCountry != null
            ? Text(
                _getDisplayText(),
                style: theme.countryNameTextStyle,
              )
            : null,
      ),
    );
  }

  Widget _buildFlagWidget(Country country) {
    final config = widget.config ?? const CountryPickerConfig();

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
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Types of picker display
enum PickerDisplayType {
  /// Show picker as a bottom sheet
  bottomSheet,

  /// Show picker as a dialog
  dialog,

  /// Show picker as a full screen page
  fullScreen,
}
