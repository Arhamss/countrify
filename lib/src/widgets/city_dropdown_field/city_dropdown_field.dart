import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:countrify/src/widgets/city_picker/city_picker.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_search_overlay.dart';
import 'package:countrify/src/widgets/geo_picker/geo_sort_by.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:flutter/material.dart';

/// {@template city_dropdown_field}
/// A form-style dropdown that opens a [CityPicker] for the provided
/// [stateId].
///
/// ```dart
/// CityDropdownField(
///   stateId: selectedState?.id,
///   onChanged: (city) => print(city?.name),
/// )
/// ```
/// {@endtemplate}
class CityDropdownField extends StatefulWidget {
  /// {@macro city_dropdown_field}
  const CityDropdownField({
    required this.stateId,
    super.key,
    this.initialCityId,
    this.onChanged,
    this.style,
    this.pickerTheme,
    this.pickerConfig,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.sortBy = CitySortBy.name,
    this.enabled = true,
    this.searchable = true,
    this.searchEnabled = true,
    this.showCoordinates = false,
    this.placeholder,
    this.emptyPlaceholder,
    this.loadingIndicatorBuilder,
    this.customCityBuilder,
    this.customHeaderBuilder,
    this.customSearchBuilder,
    this.customEmptyStateBuilder,
    this.customMatcher,
    this.onSearchChanged,
    this.onResultsChanged,
    this.repository,
    this.focusNode,
  });

  /// Optional external focus node. Lets callers wire this field into form
  /// focus chains (e.g. `FocusScope.of(context).nextFocus()`).
  final FocusNode? focusNode;

  /// Id of the parent state. Changing this prop clears any current selection
  /// and refetches cities.
  final int? stateId;

  /// Initially selected city id.
  final int? initialCityId;

  /// Called when the user picks a city. Receives `null` on external clears.
  final ValueChanged<City?>? onChanged;

  /// Field decoration.
  final CountrifyFieldStyle? style;

  /// Theme applied to the opened picker.
  final GeoPickerTheme? pickerTheme;

  /// Config applied to the opened picker.
  final GeoPickerConfig? pickerConfig;

  /// How the picker is displayed.
  final CountryPickerMode pickerMode;

  /// Sort order inside the picker.
  final CitySortBy sortBy;

  /// Whether the field accepts input.
  final bool enabled;

  /// When true (the default), the field becomes a searchable text field.
  final bool searchable;

  /// Whether the picker shows a search field (when [searchable] is false).
  final bool searchEnabled;

  /// Whether to show lat/lng as a subtitle in the default city row.
  final bool showCoordinates;

  /// Placeholder shown when no city is selected. Defaults to `"Select city"`.
  final String? placeholder;

  /// Placeholder shown when the state has no cities. Defaults to
  /// `"No cities available"`.
  final String? emptyPlaceholder;

  /// Optional override for the in-field loading indicator.
  final WidgetBuilder? loadingIndicatorBuilder;

  /// Custom row builder forwarded to the picker.
  final CityItemBuilder? customCityBuilder;

  /// Custom header builder forwarded to the picker.
  final Widget Function(BuildContext, VoidCallback)? customHeaderBuilder;

  /// Custom search builder forwarded to the picker.
  final Widget Function(BuildContext, TextEditingController)? customSearchBuilder;

  /// Custom empty-state builder forwarded to the picker.
  final WidgetBuilder? customEmptyStateBuilder;

  /// Override the picker's matching function.
  final CityMatcher? customMatcher;

  /// Called with the raw query text on every debounced search change inside
  /// the opened picker.
  final ValueChanged<String>? onSearchChanged;

  /// Called whenever the picker's filtered city list changes.
  final ValueChanged<List<City>>? onResultsChanged;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  State<CityDropdownField> createState() => _CityDropdownFieldState();
}

class _CityDropdownFieldState extends State<CityDropdownField> {
  City? _selected;
  List<City> _available = const [];
  List<City> _filtered = const [];
  bool _loading = false;
  GeoRepository get _repo => widget.repository ?? GeoRepository.instance;

  // Searchable mode state
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  FocusNode? _internalFocusNode;
  FocusNode get _focusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.stateId != null) _hydrate(widget.stateId!);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(CityDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stateId != oldWidget.stateId) {
      _selected = null;
      _available = const [];
      _filtered = const [];
      _searchController.clear();
      _removeOverlay();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        widget.onChanged?.call(null);
      });
      if (widget.stateId != null) _hydrate(widget.stateId!);
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() => _isFocused = _focusNode.hasFocus);
    if (_focusNode.hasFocus && widget.searchable && _available.isNotEmpty) {
      _filterAndShowOverlay(_searchController.text);
    } else if (!_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!_focusNode.hasFocus && mounted) _removeOverlay();
      });
    }
  }

  void _onSearchTextChanged(String query) {
    _filterAndShowOverlay(query);
  }

  void _filterAndShowOverlay(String query) {
    final q = SearchNormalizer.basic(query);
    setState(() {
      _filtered = q.isEmpty
          ? _available
          : _available
              .where((c) => SearchNormalizer.basic(c.name).contains(q))
              .toList();
    });
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => GeoSearchOverlay<City>(
        link: _layerLink,
        fieldKey: _fieldKey,
        fieldWidth: box.size.width,
        items: _filtered,
        query: _searchController.text,
        nameOf: (c) => c.name,
        selected: _selected,
        theme: widget.pickerTheme,
        onSelected: _onItemSelected,
        onDismiss: () {
          _removeOverlay();
          _focusNode.unfocus();
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onItemSelected(City city) {
    _removeOverlay();
    _searchController.text = city.name;
    setState(() => _selected = city);
    widget.onChanged?.call(city);
  }

  Future<void> _hydrate(int stateId) async {
    setState(() => _loading = true);
    final cities = await _repo.citiesOf(stateId);
    if (!mounted) return;
    setState(() {
      _available = cities;
      _loading = false;
      if (widget.initialCityId != null) {
        _selected = cities.cast<City?>().firstWhere(
              (c) => c!.id == widget.initialCityId,
              orElse: () => null,
            );
        if (_selected != null) widget.onChanged?.call(_selected);
      }
    });
  }

  Future<void> _openPicker() async {
    final id = widget.stateId;
    if (!widget.enabled || id == null || _available.isEmpty) return;

    // Dismiss any currently-focused keyboard before opening the picker.
    FocusScope.of(context).unfocus();

    City? picked;
    final picker = CityPicker(
      stateId: id,
      initialCityId: _selected?.id,
      pickerMode: widget.pickerMode,
      theme: widget.pickerTheme,
      config: (widget.pickerConfig ?? const GeoPickerConfig())
          .copyWith(searchEnabled: widget.searchEnabled),
      sortBy: widget.sortBy,
      showCoordinates: widget.showCoordinates,
      customCityBuilder: widget.customCityBuilder,
      customHeaderBuilder: widget.customHeaderBuilder,
      customSearchBuilder: widget.customSearchBuilder,
      customEmptyStateBuilder: widget.customEmptyStateBuilder,
      customMatcher: widget.customMatcher,
      onSearchChanged: widget.onSearchChanged,
      onResultsChanged: widget.onResultsChanged,
      repository: widget.repository,
      onCitySelected: (c) {
        picked = c;
        Navigator.of(context).maybePop();
      },
    );

    switch (widget.pickerMode) {
      case CountryPickerMode.bottomSheet:
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => picker,
        );
      case CountryPickerMode.dialog:
        await showDialog<void>(
          context: context,
          builder: (_) => Dialog(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(width: 420, height: 560, child: picker),
          ),
        );
      case CountryPickerMode.fullScreen:
        await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => picker));
      case CountryPickerMode.dropdown:
        await showDialog<void>(
          context: context,
          barrierColor: Colors.transparent,
          builder: (_) => Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
              child: Material(color: Colors.transparent, child: picker),
            ),
          ),
        );
      case CountryPickerMode.none:
        return;
    }

    if (picked != null && picked != _selected) {
      setState(() => _selected = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? CountrifyFieldStyle.defaultStyle();
    final id = widget.stateId;
    final disabled = !widget.enabled || id == null;
    final placeholder = id == null
        ? (widget.placeholder ?? 'Select city')
        : (_available.isEmpty && !_loading
            ? (widget.emptyPlaceholder ?? 'No cities available')
            : (widget.placeholder ?? 'Select city'));

    final suffix = Padding(
      padding: const EdgeInsets.only(right: 12),
      child: _loading
          ? (widget.loadingIndicatorBuilder?.call(context) ??
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ))
          : const CountrifyDownArrowIcon(size: 20),
    );

    final shadowDecoration = BoxDecoration(
      borderRadius: style.fieldBorderRadius ?? BorderRadius.circular(12),
      boxShadow: _isFocused && style.focusedBoxShadow != null
          ? style.focusedBoxShadow!
          : const [],
    );

    // ── Searchable mode ────────────────────────────────────────────────
    if (widget.searchable) {
      final searchSuffix = _loading ? suffix : null;
      final field = DecoratedBox(
        decoration: shadowDecoration,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: Opacity(
            opacity: disabled ? 0.55 : 1,
            child: IgnorePointer(
              ignoring: disabled || _loading,
              child: TextField(
                key: _fieldKey,
                controller: _searchController,
                focusNode: _focusNode,
                enabled: !disabled && !_loading,
                onChanged: _onSearchTextChanged,
                style: style.selectedCountryTextStyle,
                cursorColor: style.cursorColor,
                decoration: style.toInputDecoration(
                  suffixIconOverride: searchSuffix,
                ).copyWith(hintText: placeholder),
              ),
            ),
          ),
        ),
      );
      return style.wrapWithExternalLabel(context, child: field);
    }

    // ── Tap-to-open picker mode ────────────────────────────────────────
    final content = _selected == null
        ? Text(placeholder, style: style.hintStyle ?? const TextStyle(color: Colors.grey))
        : Text(_selected!.name, style: style.selectedCountryTextStyle);

    final field = DecoratedBox(
      decoration: shadowDecoration,
      child: Focus(
        focusNode: widget.focusNode,
        canRequestFocus: !disabled,
        child: Opacity(
          opacity: disabled ? 0.55 : 1,
          child: IgnorePointer(
            ignoring: disabled || _loading,
            child: InkWell(
              borderRadius: style.fieldBorderRadius ?? BorderRadius.circular(12),
              onTap: _openPicker,
              child: InputDecorator(
                decoration: style.toInputDecoration(suffixIconOverride: suffix),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );

    return style.wrapWithExternalLabel(context, child: field);
  }
}
