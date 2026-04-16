import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/phone_number_field/dropdown_overlay.dart';
import 'package:countrify/src/widgets/phone_number_field/modal_country_list.dart';
import 'package:countrify/src/widgets/phone_number_field/phone_prefix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template phone_number_field}
/// A text field for phone number input with an integrated country code picker
/// as a prefix.
///
/// The prefix displays the selected country flag and dial code. Tapping it
/// opens a compact, scrollable dropdown anchored directly below the field
/// (default), or optionally a bottom sheet / dialog / full-screen picker.
///
/// Use [CountrifyFieldStyle] to customise every aspect of the field
/// decoration in one place:
///
/// ```dart
/// PhoneNumberField(
///   style: CountrifyFieldStyle.defaultStyle().copyWith(
///     hintText: 'Enter phone number',
///     fillColor: Colors.grey.shade50,
///   ),
///   onChanged: (phoneNumber, country) {
///     print('Full number: +${country.callingCodes.first}$phoneNumber');
///   },
/// )
/// ```
/// {@endtemplate}
class PhoneNumberField extends StatefulWidget {
  /// {@macro phone_number_field}
  const PhoneNumberField({
    super.key,
    this.initialCountryCode,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCountryChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.inputFormatters,
    this.style,
    this.validator,
    this.theme,
    this.config,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.showFlag = true,
    this.showDialCode = true,
    this.showDropdownIcon = true,
    this.showCountryNameInDropdown = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.keyboardType = TextInputType.phone,
    this.textInputAction,
    this.maxLength,
    this.pickerMode = CountryPickerMode.dropdown,
    this.dropdownMaxHeight = 350,
  });

  /// Initial country selection by enum code.
  final CountryCode? initialCountryCode;

  /// Controller for the phone number text field.
  /// If not provided, an internal controller is used.
  final TextEditingController? controller;

  /// Focus node for the phone number text field.
  final FocusNode? focusNode;

  /// Called when the phone number text or country changes.
  /// Provides the raw phone number string and the selected [Country].
  final void Function(String phoneNumber, Country country)? onChanged;

  /// Called when the selected country changes via the picker.
  final ValueChanged<Country>? onCountryChanged;

  /// Called when the user submits the text field (e.g. pressing done).
  final ValueChanged<String>? onSubmitted;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Optional list of [TextInputFormatter]s applied to the phone number field.
  /// Use this for validation, e.g. `FilteringTextInputFormatter.digitsOnly`.
  final List<TextInputFormatter>? inputFormatters;

  /// Modular style for the field. Controls every aspect of the
  /// `InputDecoration` plus field-specific extras like `phoneTextStyle`,
  /// `dialCodeTextStyle`, `dividerColor`, `prefixPadding`, `cursorColor`,
  /// and `fieldBorderRadius`.
  ///
  /// When null, a default style matching [CountrifyFieldStyle.defaultStyle]
  /// is used.
  final CountrifyFieldStyle? style;

  /// Optional validator for form integration.
  final String? Function(String?)? validator;

  /// Theme configuration for the country picker.
  final CountryPickerTheme? theme;

  /// Configuration options for the country picker.
  final CountryPickerConfig? config;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field should autofocus.
  final bool autofocus;

  /// Whether to show the country flag in the prefix.
  final bool showFlag;

  /// Whether to show the dial code in the prefix.
  final bool showDialCode;

  /// Whether to show a dropdown arrow icon in the prefix.
  final bool showDropdownIcon;

  /// Whether to show the country name alongside the dial code in the dropdown
  /// list items. Defaults to true.
  final bool showCountryNameInDropdown;

  /// Size of the flag in the prefix.
  final Size flagSize;

  /// Border radius of the flag.
  final BorderRadius flagBorderRadius;

  /// Keyboard type for the phone number field.
  final TextInputType keyboardType;

  /// Text input action for the keyboard.
  final TextInputAction? textInputAction;

  /// Maximum length of the phone number.
  final int? maxLength;

  /// How the country picker is opened. Defaults to
  /// [CountryPickerMode.dropdown].
  final CountryPickerMode pickerMode;

  /// Maximum height of the dropdown overlay. Only used when
  /// [pickerMode] is [CountryPickerMode.dropdown]. Defaults to 350.
  final double dropdownMaxHeight;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isInternalFocusNode = false;
  Country? _selectedCountry;
  bool _isInternalController = false;
  bool _isFocused = false;

  // Overlay dropdown state
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  bool get _effectiveSearchEnabled => widget.config?.enableSearch ?? true;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _isInternalController = true;
    }
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _isInternalFocusNode = true;
    }
    _focusNode.addListener(_onFocusChanged);
    _initCountry();
    _controller.addListener(_onPhoneChanged);
  }

  void _initCountry() {
    final resolvedCountry = CountryUtils.resolveInitialCountry(
      initialCountryCode: widget.initialCountryCode,
    );
    if (resolvedCountry != null) {
      _selectedCountry = resolvedCountry;
    } else {
      final countries = CountryUtils.getAllCountries()
          .where((c) => c.callingCodes.isNotEmpty)
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      if (countries.isNotEmpty) {
        _selectedCountry = countries.first;
      }
    }
  }

  @override
  void didUpdateWidget(PhoneNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != _controller) {
      if (_isInternalController) {
        _controller
          ..removeListener(_onPhoneChanged)
          ..dispose();
        _isInternalController = false;
      }
      _controller = widget.controller!;
      _controller.addListener(_onPhoneChanged);
    }
    if (widget.focusNode != null && widget.focusNode != _focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      if (_isInternalFocusNode) {
        _focusNode.dispose();
        _isInternalFocusNode = false;
      }
      _focusNode = widget.focusNode!;
      _focusNode.addListener(_onFocusChanged);
    }
    if (widget.initialCountryCode != oldWidget.initialCountryCode) {
      setState(_initCountry);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.removeListener(_onFocusChanged);
    _controller.removeListener(_onPhoneChanged);
    if (_isInternalFocusNode) {
      _focusNode.dispose();
    }
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  // --- Callbacks ---

  void _onPhoneChanged() {
    if (_selectedCountry != null) {
      widget.onChanged?.call(_controller.text, _selectedCountry!);
    }
  }

  void _onCountrySelected(Country country) {
    _removeOverlay();
    setState(() {
      _selectedCountry = country;
    });
    widget.onCountryChanged?.call(country);
    widget.onChanged?.call(_controller.text, country);
  }

  // --- Picker open logic ---

  void _openCountryPicker() {
    if (!widget.enabled || widget.pickerMode == CountryPickerMode.none) return;
    if (widget.pickerMode == CountryPickerMode.dropdown) {
      _toggleDropdown();
    } else {
      _openModalPicker();
    }
  }

  // --- Overlay dropdown ---

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final fieldSize = renderBox.size;
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();

    _overlayEntry = OverlayEntry(
      builder: (context) => PhoneDropdownOverlay(
        link: _layerLink,
        fieldKey: _fieldKey,
        fieldWidth: fieldSize.width,
        maxHeight: widget.dropdownMaxHeight,
        theme: pickerTheme,
        searchEnabled: _effectiveSearchEnabled,
        config: widget.config,
        selectedCountry: _selectedCountry,
        showFlag: widget.showFlag,
        showCountryName: widget.showCountryNameInDropdown,
        flagSize: widget.flagSize,
        flagBorderRadius: widget.flagBorderRadius,
        onSelected: _onCountrySelected,
        onDismiss: _removeOverlay,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    if (_isDropdownOpen && mounted) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  // --- Modal pickers (bottom sheet / dialog / full screen) ---

  Future<void> _openModalPicker() async {
    // Dismiss keyboard from the phone number field before opening the modal
    // so the sheet is not partially covered by the keyboard on first open.
    _focusNode.unfocus();

    Country? selected;

    switch (widget.pickerMode) {
      case CountryPickerMode.bottomSheet:
        selected = await _showBottomSheet();
      case CountryPickerMode.dialog:
        selected = await _showDialog();
      case CountryPickerMode.fullScreen:
        selected = await _showFullScreen();
      case CountryPickerMode.dropdown:
        return; // handled via overlay
      case CountryPickerMode.none:
        return; // picker disabled
    }

    if (selected != null) {
      _onCountrySelected(selected);
    }
  }

  Future<Country?> _showBottomSheet() async {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();
    return showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PhoneModalCountryList(
        theme: pickerTheme,
        searchEnabled: _effectiveSearchEnabled,
        config: widget.config,
        selectedCountry: _selectedCountry,
        showFlag: widget.showFlag,
        flagSize: widget.flagSize,
        flagBorderRadius: widget.flagBorderRadius,
        onSelected: (c) => Navigator.pop(ctx, c),
        isBottomSheet: true,
      ),
    );
  }

  Future<Country?> _showDialog() async {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();
    return showDialog<Country>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: pickerTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: pickerTheme.borderRadius ??
              const BorderRadius.all(Radius.circular(20)),
        ),
        child: SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.85,
          height: MediaQuery.of(ctx).size.height * 0.55,
          child: PhoneModalCountryList(
            theme: pickerTheme,
            searchEnabled: _effectiveSearchEnabled,
            config: widget.config,
            selectedCountry: _selectedCountry,
            showFlag: widget.showFlag,
            flagSize: widget.flagSize,
            flagBorderRadius: widget.flagBorderRadius,
            onSelected: (c) => Navigator.pop(ctx, c),
          ),
        ),
      ),
    );
  }

  Future<Country?> _showFullScreen() async {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();
    return Navigator.of(context).push<Country>(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: pickerTheme.backgroundColor,
          appBar: AppBar(
            backgroundColor: pickerTheme.headerColor,
            title: Text(
                (widget.config ?? const CountryPickerConfig()).titleText,
                style: pickerTheme.appBarTitleTextStyle ??
                    pickerTheme.headerTextStyle),
            leading: IconButton(
              icon: Icon(pickerTheme.closeIcon ?? CountrifyIcons.x,
                  color: pickerTheme.headerIconColor),
              onPressed: () => Navigator.pop(ctx),
            ),
          ),
          body: PhoneModalCountryList(
            theme: pickerTheme,
            searchEnabled: _effectiveSearchEnabled,
            config: widget.config,
            selectedCountry: _selectedCountry,
            showFlag: widget.showFlag,
            flagSize: widget.flagSize,
            flagBorderRadius: widget.flagBorderRadius,
            onSelected: (c) => Navigator.pop(ctx, c),
            showHeader: false,
          ),
        ),
      ),
    );
  }

  // --- Auto-validation ---

  String? _autoValidator(String? value) {
    if (widget.validator != null) return widget.validator!(value);
    final meta = _selectedCountry?.phoneMetadata;
    if (meta == null || value == null || value.isEmpty) return null;
    if (!meta.isValidLength(value)) {
      return 'Phone number must be ${meta.minLength}-${meta.maxLength} digits';
    }
    return null;
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();
    final effectiveStyle =
        widget.style ?? CountrifyFieldStyle.defaultStyle();

    // Auto hint text from phone metadata example number.
    var resolvedStyle = effectiveStyle;
    final meta = _selectedCountry?.phoneMetadata;
    if (resolvedStyle.hintText == null && meta?.exampleNumber != null) {
      resolvedStyle = resolvedStyle.copyWith(hintText: meta!.exampleNumber);
    }

    // Auto maxLength from phone metadata.
    final effectiveMaxLength =
        widget.maxLength ?? _selectedCountry?.phoneMetadata?.maxLength;

    final prefix = PhonePrefix(
      selectedCountry: _selectedCountry,
      style: effectiveStyle,
      theme: pickerTheme,
      pickerMode: widget.pickerMode,
      showFlag: widget.showFlag,
      showDialCode: widget.showDialCode,
      showDropdownIcon: widget.showDropdownIcon,
      flagSize: widget.flagSize,
      flagBorderRadius: widget.flagBorderRadius,
      isDropdownOpen: _isDropdownOpen,
      enabled: widget.enabled,
      onTap: _openCountryPicker,
    );

    final decoration = resolvedStyle.toInputDecoration(
      prefixIconOverride: prefix,
      isFocused: _isFocused,
    );

    final field = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius:
            resolvedStyle.fieldBorderRadius ?? BorderRadius.circular(12),
        boxShadow: _isFocused && resolvedStyle.focusedBoxShadow != null
            ? resolvedStyle.focusedBoxShadow!
            : const [],
      ),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: TextFormField(
          key: _fieldKey,
          controller: _controller,
          focusNode: _focusNode,
          cursorColor:
              resolvedStyle.cursorColor ?? pickerTheme.searchCursorColor,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLength: effectiveMaxLength,
          style:
              resolvedStyle.phoneTextStyle ?? pickerTheme.countryNameTextStyle,
          inputFormatters: widget.inputFormatters,
          validator: _autoValidator,
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          decoration: decoration,
        ),
      ),
    );

    return resolvedStyle.wrapWithExternalLabel(context, child: field);
  }
}
