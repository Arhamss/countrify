import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
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
/// Example usage:
/// ```dart
/// PhoneNumberField(
///   onPhoneNumberChanged: (phoneNumber, country) {
///     print('Full number: +${country.callingCodes.first}$phoneNumber');
///   },
///   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    this.onPhoneNumberChanged,
    this.onCountryChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.inputFormatters,
    this.decoration,
    this.phoneTextStyle,
    this.dialCodeTextStyle,
    this.hintText,
    this.labelText,
    this.labelTextStyle,
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
    this.pickerType = PickerOpenType.dropdown,
    this.dropdownMaxHeight = 350,
    this.dividerColor,
    this.prefixPadding,
    this.fieldBorderRadius,
    this.contentPadding,
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
  final void Function(String phoneNumber, Country country)?
      onPhoneNumberChanged;

  /// Called when the selected country changes via the picker.
  final ValueChanged<Country>? onCountryChanged;

  /// Called when the user submits the text field (e.g. pressing done).
  final ValueChanged<String>? onSubmitted;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Optional list of [TextInputFormatter]s applied to the phone number field.
  /// Use this for validation, e.g. `FilteringTextInputFormatter.digitsOnly`.
  final List<TextInputFormatter>? inputFormatters;

  /// Custom [InputDecoration] for the entire field.
  /// When provided, this overrides the default decoration.
  final InputDecoration? decoration;

  /// Text style for the phone number input.
  final TextStyle? phoneTextStyle;

  /// Text style for the dial code in the prefix.
  final TextStyle? dialCodeTextStyle;

  /// Hint text displayed in the phone number field.
  final String? hintText;

  /// Label text for the field.
  final String? labelText;

  /// Label text style for the field.
  final TextStyle? labelTextStyle;

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

  /// How the country picker is opened. Defaults to [PickerOpenType.dropdown].
  final PickerOpenType pickerType;

  /// Maximum height of the dropdown overlay. Only used when
  /// [pickerType] is [PickerOpenType.dropdown]. Defaults to 350.
  final double dropdownMaxHeight;

  /// Color of the divider between the prefix and the text field.
  final Color? dividerColor;

  /// Padding around the prefix area.
  final EdgeInsetsGeometry? prefixPadding;

  /// Border radius for the outer field container.
  final BorderRadius? fieldBorderRadius;

  /// Content padding inside the text field.
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _controller;
  Country? _selectedCountry;
  bool _isInternalController = false;

  // Overlay dropdown state
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  bool get _effectiveSearchEnabled => widget.config?.enableSearch ?? true;

  InputDecoration _mergeDecoration(InputDecoration defaultDecoration) {
    final custom = widget.decoration;
    if (custom == null) return defaultDecoration;

    return defaultDecoration.copyWith(
      labelText: custom.labelText ?? defaultDecoration.labelText,
      labelStyle: custom.labelStyle ?? defaultDecoration.labelStyle,
      hintText: custom.hintText ?? defaultDecoration.hintText,
      hintStyle: custom.hintStyle ?? defaultDecoration.hintStyle,
      helperText: custom.helperText,
      helperStyle: custom.helperStyle,
      errorText: custom.errorText,
      errorStyle: custom.errorStyle,
      prefixIcon: custom.prefixIcon ?? defaultDecoration.prefixIcon,
      prefixIconConstraints: custom.prefixIconConstraints ??
          defaultDecoration.prefixIconConstraints,
      suffixIcon: custom.suffixIcon ?? defaultDecoration.suffixIcon,
      suffixIconConstraints: custom.suffixIconConstraints,
      contentPadding: custom.contentPadding ?? defaultDecoration.contentPadding,
      border: custom.border ?? defaultDecoration.border,
      enabledBorder: custom.enabledBorder ?? defaultDecoration.enabledBorder,
      focusedBorder: custom.focusedBorder ?? defaultDecoration.focusedBorder,
      disabledBorder: custom.disabledBorder ?? defaultDecoration.disabledBorder,
      errorBorder: custom.errorBorder ?? defaultDecoration.errorBorder,
      focusedErrorBorder:
          custom.focusedErrorBorder ?? defaultDecoration.focusedErrorBorder,
      filled: custom.filled ?? defaultDecoration.filled,
      fillColor: custom.fillColor ?? defaultDecoration.fillColor,
      counterText: custom.counterText ?? defaultDecoration.counterText,
      constraints: custom.constraints,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _isInternalController = true;
    }
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
    if (widget.initialCountryCode != oldWidget.initialCountryCode) {
      setState(_initCountry);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.removeListener(_onPhoneChanged);
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  // ─── Callbacks ──────────────────────────────────────────────────────

  void _onPhoneChanged() {
    if (_selectedCountry != null) {
      widget.onPhoneNumberChanged?.call(_controller.text, _selectedCountry!);
    }
  }

  void _onCountrySelected(Country country) {
    _removeOverlay();
    setState(() {
      _selectedCountry = country;
    });
    widget.onCountryChanged?.call(country);
    widget.onPhoneNumberChanged?.call(_controller.text, country);
  }

  // ─── Picker open logic ─────────────────────────────────────────────

  void _openCountryPicker() {
    if (!widget.enabled || widget.pickerType == PickerOpenType.none) return;
    if (widget.pickerType == PickerOpenType.dropdown) {
      _toggleDropdown();
    } else {
      _openModalPicker();
    }
  }

  // ─── Overlay dropdown ──────────────────────────────────────────────

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
      builder: (context) => _DropdownOverlay(
        link: _layerLink,
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

  // ─── Modal pickers (bottom sheet / dialog / full screen) ───────────

  Future<void> _openModalPicker() async {
    Country? selected;

    switch (widget.pickerType) {
      case PickerOpenType.bottomSheet:
        selected = await _showBottomSheet();
      case PickerOpenType.dialog:
        selected = await _showDialog();
      case PickerOpenType.fullScreen:
        selected = await _showFullScreen();
      case PickerOpenType.dropdown:
        return; // handled via overlay
      case PickerOpenType.none:
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
      builder: (ctx) => _ModalCountryList(
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
          child: _ModalCountryList(
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
          body: _ModalCountryList(
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

  // ─── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();
    final borderRadius = widget.fieldBorderRadius ?? BorderRadius.circular(12);

    final defaultDecoration = InputDecoration(
      labelText: widget.labelText,
      labelStyle: widget.labelTextStyle,
      hintText: widget.hintText ?? 'Phone number',
      hintStyle: pickerTheme.searchHintStyle,
      prefixIcon: _buildPrefix(pickerTheme),
      prefixIconConstraints: const BoxConstraints(),
      contentPadding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: borderRadius),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide:
            BorderSide(color: pickerTheme.borderColor ?? Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: pickerTheme.countryItemSelectedBorderColor ?? Colors.blue,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor:
          widget.enabled ? pickerTheme.backgroundColor : Colors.grey.shade100,
      counterText: '',
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        key: _fieldKey,
        controller: _controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        style: widget.phoneTextStyle ?? pickerTheme.countryNameTextStyle,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        decoration: _mergeDecoration(defaultDecoration),
      ),
    );
  }

  Widget _buildPrefix(CountryPickerTheme pickerTheme) {
    final dialCode =
        _selectedCountry != null && _selectedCountry!.callingCodes.isNotEmpty
            ? '+${_selectedCountry!.callingCodes.first}'
            : '';

    return GestureDetector(
      onTap:
          widget.pickerType == PickerOpenType.none ? null : _openCountryPicker,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: widget.prefixPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showFlag && _selectedCountry != null) ...[
              _buildFlagImage(_selectedCountry!),
              const SizedBox(width: 8),
            ],
            if (widget.showDialCode && dialCode.isNotEmpty)
              Text(
                dialCode,
                style: widget.dialCodeTextStyle ??
                    pickerTheme.compactDialCodeTextStyle ??
                    pickerTheme.countryNameTextStyle?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            if (widget.showDropdownIcon &&
                widget.pickerType != PickerOpenType.none) ...[
              const SizedBox(width: 4),
              AnimatedRotation(
                turns: _isDropdownOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  pickerTheme.dropdownIcon ?? CountrifyIcons.chevronDown,
                  size: 20,
                  color: widget.enabled
                      ? pickerTheme.headerIconColor ?? Colors.black54
                      : Colors.grey,
                ),
              ),
            ],
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 24,
              color: widget.dividerColor ??
                  pickerTheme.borderColor ??
                  Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagImage(Country country) {
    final pickerTheme = widget.theme ?? CountryPickerTheme.defaultTheme();

    return Container(
      width: widget.flagSize.width,
      height: widget.flagSize.height,
      decoration: BoxDecoration(
        borderRadius: widget.flagBorderRadius,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: widget.flagBorderRadius,
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => ColoredBox(
            color: Colors.grey.shade300,
            child: Center(
              child: Text(
                country.flagEmoji,
                style: pickerTheme.flagEmojiTextStyle?.copyWith(
                      fontSize: widget.flagSize.width * 0.5,
                    ) ??
                    TextStyle(fontSize: widget.flagSize.width * 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════
// Dropdown overlay (compact, anchored below the field)
// ═════════════════════════════════════════════════════════════════════════

class _DropdownOverlay extends StatefulWidget {
  const _DropdownOverlay({
    required this.link,
    required this.fieldWidth,
    required this.maxHeight,
    required this.theme,
    required this.searchEnabled,
    required this.onSelected,
    required this.onDismiss,
    this.config,
    this.selectedCountry,
    this.showFlag = true,
    this.showCountryName = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final LayerLink link;
  final double fieldWidth;
  final double maxHeight;
  final CountryPickerTheme theme;
  final bool searchEnabled;
  final CountryPickerConfig? config;
  final Country? selectedCountry;
  final bool showFlag;
  final bool showCountryName;
  final Size flagSize;
  final BorderRadius flagBorderRadius;
  final ValueChanged<Country> onSelected;
  final VoidCallback onDismiss;

  @override
  State<_DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<_DropdownOverlay> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Country> _countries = [];
  List<Country> _filtered = [];
  Timer? _debounce;
  late String _effectiveLocale;

  @override
  void initState() {
    super.initState();
    _effectiveLocale = widget.config?.locale ?? 'en';
    _loadCountries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =
        widget.config?.locale ?? Localizations.localeOf(context).languageCode;
    if (locale != _effectiveLocale) {
      _effectiveLocale = locale;
      _loadCountries();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String _displayName(Country country) {
    if (_effectiveLocale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, _effectiveLocale);
  }

  void _loadCountries() {
    var list = CountryUtils.getAllCountries()
        .where((c) => c.callingCodes.isNotEmpty)
        .toList()
      ..sort((a, b) => _displayName(a).compareTo(_displayName(b)));

    final config = widget.config;
    if (config != null) {
      if (config.includeCountries.isNotEmpty) {
        list = list
            .where((c) => config.includeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.excludeCountries.isNotEmpty) {
        list = list
            .where((c) => !config.excludeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.includeRegions.isNotEmpty) {
        list = list
            .where((c) => config.includeRegions.contains(c.region))
            .toList();
      }
      if (config.excludeRegions.isNotEmpty) {
        list = list
            .where((c) => !config.excludeRegions.contains(c.region))
            .toList();
      }
    }

    _countries = list;
    _filtered = list;
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _applyFilter(query);
    });
  }

  void _applyFilter(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filtered = _countries;
      } else {
        final q = query.toLowerCase();
        _filtered = _countries.where((c) {
          return _displayName(c).toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q) ||
              c.alpha2Code.toLowerCase().contains(q) ||
              c.callingCodes.any((code) => code.contains(q));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Stack(
      children: [
        // Dismiss layer
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        // Dropdown card
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: const Offset(0, 4),
          targetAnchor: Alignment.bottomLeft,
          child: Material(
            elevation: theme.elevation ?? 8,
            shadowColor: theme.shadowColor ?? Colors.black26,
            borderRadius: theme.dropdownMenuBorderRadius ??
                const BorderRadius.all(Radius.circular(12)),
            color: theme.dropdownMenuBackgroundColor ??
                theme.backgroundColor ??
                Colors.white,
            child: Container(
              width: widget.fieldWidth,
              constraints: BoxConstraints(maxHeight: widget.maxHeight),
              decoration: BoxDecoration(
                borderRadius: theme.dropdownMenuBorderRadius ??
                    const BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: theme.dropdownMenuBorderColor ??
                      theme.borderColor ??
                      Colors.grey.shade300,
                  width: theme.dropdownMenuBorderWidth ?? 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: theme.dropdownMenuBorderRadius ??
                    const BorderRadius.all(Radius.circular(12)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.searchEnabled) _buildSearch(theme),
                    Flexible(child: _buildList(theme)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearch(CountryPickerTheme theme) {
    final config = widget.config ?? const CountryPickerConfig();
    final effectiveBorderRadius = theme.searchBarBorderRadius ??
        const BorderRadius.all(Radius.circular(12));
    final effectiveDecoration = theme.searchInputDecoration ??
        InputDecoration(
          hintText: theme.searchHintText ?? config.searchHintText,
          hintStyle: theme.searchHintStyle,
          prefixIcon: Icon(theme.searchIcon ?? CountrifyIcons.search,
              color: theme.searchIconColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(theme.clearIcon ?? CountrifyIcons.circleX,
                      color: theme.searchIconColor),
                  onPressed: () {
                    _searchController.clear();
                    _applyFilter('');
                  },
                )
              : null,
          filled: true,
          fillColor: theme.searchBarColor,
          contentPadding: theme.searchContentPadding,
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchFocusedBorderColor ??
                    theme.searchBarBorderColor ??
                    Colors.blue),
          ),
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: theme.searchTextStyle,
        cursorColor: theme.searchCursorColor,
        decoration: effectiveDecoration,
      ),
    );
  }

  Widget _buildList(CountryPickerTheme theme) {
    if (_filtered.isEmpty) {
      final config = widget.config ?? const CountryPickerConfig();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(theme.emptyStateIcon ?? CountrifyIcons.searchX,
                  size: 28, color: Colors.grey),
              const SizedBox(height: 6),
              Text(
                config.emptyStateText,
                style: theme.readOnlyHintTextStyle ??
                    theme.countrySubtitleTextStyle,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      itemCount: _filtered.length,
      itemExtent: 44,
      itemBuilder: (_, index) {
        final country = _filtered[index];
        final isSelected =
            widget.selectedCountry?.alpha2Code == country.alpha2Code;

        return InkWell(
          onTap: () => widget.onSelected(country),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: isSelected
                ? theme.countryItemSelectedColor ??
                    Colors.blue.withValues(alpha: 0.08)
                : null,
            child: Row(
              children: [
                if (widget.showFlag) ...[
                  _buildFlagTile(country),
                  const SizedBox(width: 10),
                ],
                SizedBox(
                  width: 48,
                  child: Text(
                    '+${country.callingCodes.first}',
                    style: theme.compactDialCodeTextStyle?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ) ??
                        theme.countryNameTextStyle?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (widget.showCountryName) ...[
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _displayName(country),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.countrySubtitleTextStyle?.copyWith(
                            fontSize: 13,
                          ) ??
                          theme.compactCountryNameTextStyle,
                    ),
                  ),
                ],
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      theme.selectedIcon ?? CountrifyIcons.circleCheckBig,
                      size: 16,
                      color: theme.countryItemSelectedIconColor ?? Colors.blue,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFlagTile(Country country) {
    final theme = widget.theme;

    return Container(
      width: widget.flagSize.width,
      height: widget.flagSize.height,
      decoration: BoxDecoration(
        borderRadius: widget.flagBorderRadius,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: widget.flagBorderRadius,
        child: Image.asset(
          country.flagImagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => ColoredBox(
            color: Colors.grey.shade300,
            child: Center(
              child: Text(
                country.flagEmoji,
                style: theme.flagEmojiTextStyle?.copyWith(
                      fontSize: widget.flagSize.width * 0.5,
                    ) ??
                    TextStyle(fontSize: widget.flagSize.width * 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════
// Shared modal country list (for bottom sheet / dialog / full screen)
// ═════════════════════════════════════════════════════════════════════════

class _ModalCountryList extends StatefulWidget {
  const _ModalCountryList({
    required this.theme,
    required this.searchEnabled,
    required this.onSelected,
    this.config,
    this.selectedCountry,
    this.showFlag = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.isBottomSheet = false,
    this.showHeader = true,
  });

  final CountryPickerTheme theme;
  final bool searchEnabled;
  final CountryPickerConfig? config;
  final Country? selectedCountry;
  final bool showFlag;
  final Size flagSize;
  final BorderRadius flagBorderRadius;
  final ValueChanged<Country> onSelected;
  final bool isBottomSheet;
  final bool showHeader;

  @override
  State<_ModalCountryList> createState() => _ModalCountryListState();
}

class _ModalCountryListState extends State<_ModalCountryList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Country> _countries = [];
  List<Country> _filtered = [];
  Timer? _debounce;
  late String _effectiveLocale;

  @override
  void initState() {
    super.initState();
    _effectiveLocale = widget.config?.locale ?? 'en';
    _loadCountries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =
        widget.config?.locale ?? Localizations.localeOf(context).languageCode;
    if (locale != _effectiveLocale) {
      _effectiveLocale = locale;
      _loadCountries();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  String _displayName(Country country) {
    if (_effectiveLocale == 'en') return country.name;
    return CountryUtils.getCountryNameInLanguage(country, _effectiveLocale);
  }

  void _loadCountries() {
    var list = CountryUtils.getAllCountries()
        .where((c) => c.callingCodes.isNotEmpty)
        .toList()
      ..sort((a, b) => _displayName(a).compareTo(_displayName(b)));

    final config = widget.config;
    if (config != null) {
      if (config.includeCountries.isNotEmpty) {
        list = list
            .where((c) => config.includeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.excludeCountries.isNotEmpty) {
        list = list
            .where((c) => !config.excludeCountries.contains(c.alpha2Code))
            .toList();
      }
      if (config.includeRegions.isNotEmpty) {
        list = list
            .where((c) => config.includeRegions.contains(c.region))
            .toList();
      }
      if (config.excludeRegions.isNotEmpty) {
        list = list
            .where((c) => !config.excludeRegions.contains(c.region))
            .toList();
      }
    }

    _countries = list;
    _filtered = list;
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _applyFilter(query);
    });
  }

  void _applyFilter(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filtered = _countries;
      } else {
        final q = query.toLowerCase();
        _filtered = _countries.where((c) {
          return _displayName(c).toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q) ||
              c.alpha2Code.toLowerCase().contains(q) ||
              c.callingCodes.any((code) => code.contains(q));
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    final body = Column(
      children: [
        if (widget.showHeader) _buildHeader(theme),
        if (widget.searchEnabled) _buildSearchBar(theme),
        Expanded(child: _buildList(theme)),
      ],
    );

    if (widget.isBottomSheet) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
          color: theme.backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: body,
      );
    }

    return body;
  }

  Widget _buildHeader(CountryPickerTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.headerColor,
        borderRadius: widget.isBottomSheet
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : null,
      ),
      child: Row(
        children: [
          Text((widget.config ?? const CountryPickerConfig()).titleText,
              style: theme.headerTextStyle),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(theme.closeIcon ?? CountrifyIcons.x,
                color: theme.headerIconColor, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(CountryPickerTheme theme) {
    final effectiveBorderRadius = theme.searchBarBorderRadius ??
        const BorderRadius.all(Radius.circular(12));
    final effectiveDecoration = theme.searchInputDecoration ??
        InputDecoration(
          hintText: theme.searchHintText ??
              (widget.config ?? const CountryPickerConfig()).searchHintText,
          hintStyle: theme.searchHintStyle,
          prefixIcon: Icon(theme.searchIcon ?? CountrifyIcons.search,
              color: theme.searchIconColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(theme.clearIcon ?? CountrifyIcons.circleX,
                      color: theme.searchIconColor),
                  onPressed: () {
                    _searchController.clear();
                    _applyFilter('');
                  },
                )
              : null,
          filled: true,
          fillColor: theme.searchBarColor,
          contentPadding: theme.searchContentPadding,
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchBarBorderColor ?? Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
                color: theme.searchFocusedBorderColor ??
                    theme.searchBarBorderColor ??
                    Colors.blue),
          ),
        );

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: theme.searchTextStyle,
        cursorColor: theme.searchCursorColor,
        decoration: effectiveDecoration,
      ),
    );
  }

  Widget _buildList(CountryPickerTheme theme) {
    if (_filtered.isEmpty) {
      final config = widget.config ?? const CountryPickerConfig();
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(theme.emptyStateIcon ?? CountrifyIcons.searchX,
                size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              config.emptyStateText,
              style:
                  theme.readOnlyHintTextStyle ?? theme.countrySubtitleTextStyle,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: _filtered.length,
      itemBuilder: (_, index) {
        final country = _filtered[index];
        final isSelected =
            widget.selectedCountry?.alpha2Code == country.alpha2Code;

        return ListTile(
          onTap: () => widget.onSelected(country),
          dense: true,
          selected: isSelected,
          selectedTileColor: theme.countryItemSelectedColor,
          leading: widget.showFlag
              ? Container(
                  width: widget.flagSize.width,
                  height: widget.flagSize.height,
                  decoration: BoxDecoration(
                    borderRadius: widget.flagBorderRadius,
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                  ),
                  child: ClipRRect(
                    borderRadius: widget.flagBorderRadius,
                    child: Image.asset(
                      country.flagImagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color: Colors.grey.shade300,
                        child: Center(child: Text(country.flagEmoji)),
                      ),
                    ),
                  ),
                )
              : null,
          title: Text(_displayName(country),
              style: theme.countryNameTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          trailing: Text(
            '+${country.callingCodes.first}',
            style: theme.compactDialCodeTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                ) ??
                theme.countrySubtitleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        );
      },
    );
  }
}

/// How the country picker is opened from the phone number field.
enum PickerOpenType {
  /// Show a compact scrollable dropdown anchored below the field (default).
  dropdown,

  /// Show picker as a modal bottom sheet.
  bottomSheet,

  /// Show picker as a dialog.
  dialog,

  /// Show picker as a full screen page.
  fullScreen,

  /// Disable picker opening and keep the selected country unchanged.
  none,
}
