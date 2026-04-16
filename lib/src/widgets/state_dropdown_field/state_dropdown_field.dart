import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_search_overlay.dart';
import 'package:countrify/src/widgets/geo_picker/geo_sort_by.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:countrify/src/widgets/state_picker/state_picker.dart';
import 'package:flutter/material.dart';

/// {@template state_dropdown_field}
/// A form-style dropdown that opens a [StatePicker] for the provided
/// [countryIso2].
///
/// Uses the shared [CountrifyFieldStyle] for decoration (so it matches
/// `PhoneNumberField`, `CountryDropdownField`, and friends out of the box)
/// plus [GeoPickerTheme] / [GeoPickerConfig] for picker internals.
///
/// ```dart
/// StateDropdownField(
///   countryIso2: 'US',
///   onChanged: (state) => print(state?.name),
///   style: CountrifyFieldStyle.defaultStyle().copyWith(labelText: 'State'),
/// )
/// ```
/// {@endtemplate}
class StateDropdownField extends StatefulWidget {
  /// {@macro state_dropdown_field}
  const StateDropdownField({
    required this.countryIso2,
    super.key,
    this.initialStateId,
    this.onChanged,
    this.style,
    this.pickerTheme,
    this.pickerConfig,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.sortBy = StateSortBy.name,
    this.enabled = true,
    this.searchable = true,
    this.searchEnabled = true,
    this.showType = true,
    this.placeholder,
    this.emptyPlaceholder,
    this.loadingIndicatorBuilder,
    this.customStateBuilder,
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

  /// ISO 3166-1 alpha-2 code of the parent country. Changing this prop
  /// clears any current selection and refetches states.
  final String? countryIso2;

  /// Initially selected state id.
  final int? initialStateId;

  /// Called when the user picks a state. The callback receives `null` only
  /// when the selection is cleared by an external prop change (e.g. when
  /// [countryIso2] becomes null).
  final ValueChanged<CountryState?>? onChanged;

  /// Field decoration.
  final CountrifyFieldStyle? style;

  /// Theme applied to the opened picker.
  final GeoPickerTheme? pickerTheme;

  /// Config applied to the opened picker.
  final GeoPickerConfig? pickerConfig;

  /// How the picker is displayed.
  final CountryPickerMode pickerMode;

  /// Sort order inside the picker.
  final StateSortBy sortBy;

  /// Whether the field accepts input.
  final bool enabled;

  /// When true (the default), the field becomes a searchable text field that
  /// shows matching states in a dropdown as the user types. When false, the
  /// field is a tap-to-open picker using [pickerMode].
  final bool searchable;

  /// Whether the picker shows a search field (only used when [searchable] is
  /// false and a modal picker is opened).
  final bool searchEnabled;

  /// Whether to show the subdivision type as a subtitle in the default row.
  final bool showType;

  /// Placeholder shown when no state is selected. Defaults to
  /// `"Select state"`.
  final String? placeholder;

  /// Placeholder shown when the country has no states available. Defaults
  /// to `"No states available"`.
  final String? emptyPlaceholder;

  /// Optional override for the in-field loading indicator.
  final WidgetBuilder? loadingIndicatorBuilder;

  /// Custom row builder forwarded to the picker.
  final StateItemBuilder? customStateBuilder;

  /// Custom header builder forwarded to the picker.
  final Widget Function(BuildContext, VoidCallback)? customHeaderBuilder;

  /// Custom search builder forwarded to the picker.
  final Widget Function(BuildContext, TextEditingController)? customSearchBuilder;

  /// Custom empty-state builder forwarded to the picker.
  final WidgetBuilder? customEmptyStateBuilder;

  /// Override the picker's matching function.
  final StateMatcher? customMatcher;

  /// Called with the raw query text on every debounced search change inside
  /// the opened picker.
  final ValueChanged<String>? onSearchChanged;

  /// Called whenever the picker's filtered state list changes.
  final ValueChanged<List<CountryState>>? onResultsChanged;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  State<StateDropdownField> createState() => _StateDropdownFieldState();
}

class _StateDropdownFieldState extends State<StateDropdownField> {
  CountryState? _selected;
  List<CountryState> _available = const [];
  List<CountryState> _filtered = const [];
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
    if (widget.countryIso2 != null) _hydrate(widget.countryIso2!);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(StateDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryIso2 != oldWidget.countryIso2) {
      _selected = null;
      _available = const [];
      _filtered = const [];
      _searchController.clear();
      _removeOverlay();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        widget.onChanged?.call(null);
      });
      if (widget.countryIso2 != null) _hydrate(widget.countryIso2!);
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
      // Delay removal so tap on overlay item registers first
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
              .where((s) =>
                  SearchNormalizer.basic(s.name).contains(q) ||
                  (s.iso2 != null &&
                      SearchNormalizer.basic(s.iso2!).contains(q)))
              .toList();
    });
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => GeoSearchOverlay<CountryState>(
        link: _layerLink,
        fieldKey: _fieldKey,
        fieldWidth: box.size.width,
        items: _filtered,
        query: _searchController.text,
        nameOf: (s) => s.name,
        subtitleOf: null,
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

  void _onItemSelected(CountryState state) {
    _removeOverlay();
    _searchController.text = state.name;
    setState(() => _selected = state);
    widget.onChanged?.call(state);
  }

  Future<void> _hydrate(String iso2) async {
    setState(() => _loading = true);
    final states = await _repo.statesOf(iso2);
    if (!mounted) return;
    setState(() {
      _available = states;
      _loading = false;
      if (widget.initialStateId != null) {
        _selected = states.cast<CountryState?>().firstWhere(
              (s) => s!.id == widget.initialStateId,
              orElse: () => null,
            );
        if (_selected != null) widget.onChanged?.call(_selected);
      }
    });
  }

  Future<void> _openPicker() async {
    final iso2 = widget.countryIso2;
    if (!widget.enabled || iso2 == null || _available.isEmpty) return;

    // Dismiss any currently-focused keyboard before opening the picker.
    FocusScope.of(context).unfocus();

    CountryState? picked;
    final picker = StatePicker(
      countryIso2: iso2,
      initialStateId: _selected?.id,
      pickerMode: widget.pickerMode,
      theme: widget.pickerTheme,
      config: (widget.pickerConfig ?? const GeoPickerConfig())
          .copyWith(searchEnabled: widget.searchEnabled),
      sortBy: widget.sortBy,
      showType: widget.showType,
      customStateBuilder: widget.customStateBuilder,
      customHeaderBuilder: widget.customHeaderBuilder,
      customSearchBuilder: widget.customSearchBuilder,
      customEmptyStateBuilder: widget.customEmptyStateBuilder,
      customMatcher: widget.customMatcher,
      onSearchChanged: widget.onSearchChanged,
      onResultsChanged: widget.onResultsChanged,
      repository: widget.repository,
      onStateSelected: (s) {
        picked = s;
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
    final iso2 = widget.countryIso2;
    final disabled = !widget.enabled || iso2 == null;
    final placeholder = iso2 == null
        ? (widget.placeholder ?? 'Select state')
        : (_available.isEmpty && !_loading
            ? (widget.emptyPlaceholder ?? 'No states available')
            : (widget.placeholder ?? 'Select state'));

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
      final searchSuffix = _loading
          ? suffix
          : null;
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
