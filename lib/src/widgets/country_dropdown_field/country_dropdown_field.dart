import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker/country_picker.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
///   onChanged: (country) => print(country.name),
/// )
/// ```
/// {@endtemplate}
class CountryDropdownField extends StatefulWidget {
  /// {@macro country_dropdown_field}
  const CountryDropdownField({
    super.key,
    this.initialCountryCode,
    this.onChanged,
    this.theme,
    this.config,
    this.style,
    this.enabled = true,
    this.showPhoneCode = true,
    this.showFlag = true,
    this.searchEnabled = true,
    this.filterEnabled = false,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.focusNode,
  });

  /// Optional external focus node. Lets callers wire this field into form
  /// focus chains (e.g. `FocusScope.of(context).nextFocus()`).
  final FocusNode? focusNode;

  /// Initial selected country by enum code.
  final CountryCode? initialCountryCode;

  /// Callback when a country is selected.
  final ValueChanged<Country>? onChanged;

  /// Theme configuration for the picker.
  final CountryPickerTheme? theme;

  /// Configuration options for the picker.
  final CountryPickerConfig? config;

  /// Modular style for the field. Controls every aspect of the
  /// [InputDecoration] plus extras like [CountrifyFieldStyle.selectedCountryTextStyle].
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

  /// How the picker is displayed.
  final CountryPickerMode pickerMode;

  @override
  State<CountryDropdownField> createState() => _CountryDropdownFieldState();
}

class _CountryDropdownFieldState extends State<CountryDropdownField> {
  Country? _selectedCountry;
  FocusNode? _internalFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedCountry = CountryUtils.resolveInitialCountry(
      initialCountryCode: widget.initialCountryCode,
    );
    _focusNode.addListener(_onFocusChanged);
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

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  Future<void> _showPicker() async {
    if (!widget.enabled || widget.pickerMode == CountryPickerMode.none) return;

    // Dismiss any currently-focused keyboard (e.g. a sibling TextField)
    // before opening the picker so the modal is not partially covered.
    FocusScope.of(context).unfocus();

    Country? selectedCountry;

    switch (widget.pickerMode) {
      case CountryPickerMode.bottomSheet:
        selectedCountry = await _showBottomSheetPicker();
      case CountryPickerMode.dialog:
        selectedCountry = await _showDialogPicker();
      case CountryPickerMode.fullScreen:
        selectedCountry = await _showFullScreenPicker();
      case CountryPickerMode.dropdown:
      case CountryPickerMode.none:
        return;
    }

    if (selectedCountry != null) {
      setState(() {
        _selectedCountry = selectedCountry;
      });
      widget.onChanged?.call(selectedCountry);
    }
  }

  Future<Country?> _showBottomSheetPicker() async {
    return showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => CountryPicker(
        initialCountryCode: CountryCodeExtension.fromAlpha2Code(
            _selectedCountry?.alpha2Code ?? ''),
        theme: widget.theme,
        config: widget.config,
        showPhoneCode: widget.showPhoneCode,
        showFlag: widget.showFlag,
        searchEnabled: widget.searchEnabled,
        filterEnabled: widget.filterEnabled,
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
          child: CountryPicker(
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
        builder: (routeContext) => CountryPicker(
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
    final effectiveStyle = widget.style ?? CountrifyFieldStyle.defaultStyle();

    final prefixWidget = _selectedCountry != null && widget.showFlag
        ? Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: CountryFlag(
              country: _selectedCountry!,
              size: const Size(28, 20),
              borderRadius: (widget.config ?? const CountryPickerConfig())
                  .flagBorderRadius,
              borderColor: (widget.config ?? const CountryPickerConfig())
                  .flagBorderColor,
              borderWidth: (widget.config ?? const CountryPickerConfig())
                  .flagBorderWidth,
              emojiTextStyle: theme.flagEmojiTextStyle,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              theme.defaultCountryIcon ?? CountrifyIcons.globe,
              size: 20,
              color: theme.headerIconColor ?? Colors.grey.shade600,
            ),
          );

    final Widget suffixWidget = Padding(
      padding: const EdgeInsets.only(right: 12),
      child: theme.dropdownIcon != null
          ? Icon(
              theme.dropdownIcon,
              size: 18,
              color: widget.enabled ? null : Colors.grey,
            )
          : CountrifyDownArrowIcon(
              size: 20,
              color: widget.enabled
                  ? (theme.borderColor ?? Colors.grey.shade500)
                  : Colors.grey,
            ),
    );

    final borderRadius =
        effectiveStyle.fieldBorderRadius ?? BorderRadius.circular(12);

    final decoration = effectiveStyle.toInputDecoration(
      prefixIconOverride: prefixWidget,
      suffixIconOverride: suffixWidget,
    );

    final field = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: _isFocused && effectiveStyle.focusedBoxShadow != null
            ? effectiveStyle.focusedBoxShadow!
            : const [],
      ),
      child: Focus(
        focusNode: _focusNode,
        canRequestFocus: widget.enabled,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              (event.logicalKey == LogicalKeyboardKey.space ||
                  event.logicalKey == LogicalKeyboardKey.enter)) {
            _showPicker();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: InkWell(
          onTap: widget.enabled && widget.pickerMode != CountryPickerMode.none
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
        ),
      ),
    );

    return effectiveStyle.wrapWithExternalLabel(context, child: field);
  }
}
