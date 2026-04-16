import 'dart:async';

import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_search_overlay.dart';
import 'package:flutter/material.dart';

/// Result record returned by [CitySearchField.onChanged].
typedef CitySearchResult = ({City city, CountryState state});

/// {@template city_search_field}
/// A searchable text field that searches across all cities for a given country
/// without requiring a pre-selected state. When a city is selected the parent
/// state is resolved automatically.
///
/// ```dart
/// CitySearchField(
///   countryIso2: 'US',
///   onChanged: (result) {
///     if (result != null) {
///       print('${result.city.name}, ${result.state.name}');
///     }
///   },
/// )
/// ```
/// {@endtemplate}
class CitySearchField extends StatefulWidget {
  /// {@macro city_search_field}
  const CitySearchField({
    required this.countryIso2,
    super.key,
    this.initialCityId,
    this.initialCityName,
    this.onChanged,
    this.style,
    this.pickerTheme,
    this.pickerConfig,
    this.placeholder,
    this.emptyPlaceholder,
    this.enabled = true,
    this.focusNode,
    this.repository,
  });

  /// ISO 3166-1 alpha-2 country code to search within (e.g. `'US'`).
  final String countryIso2;

  /// Initially selected city id. On hydration the field resolves the city and
  /// its parent state, then updates the display text.
  final int? initialCityId;

  /// Initial city name to pre-fill the text field without needing a city ID.
  /// Useful in edit flows where the backend provides a name string.
  final String? initialCityName;

  /// Called when the user picks a city. Receives `null` when the field is
  /// cleared.
  final ValueChanged<CitySearchResult?>? onChanged;

  /// Field decoration.
  final CountrifyFieldStyle? style;

  /// Theme applied to the dropdown overlay.
  final GeoPickerTheme? pickerTheme;

  /// Config for search behaviour (debounce, max height, etc.).
  final GeoPickerConfig? pickerConfig;

  /// Placeholder shown when no city is selected. Defaults to
  /// `"Search city"`.
  final String? placeholder;

  /// Text shown inside the overlay when no results match. Defaults to the
  /// overlay's built-in "No results" label.
  final String? emptyPlaceholder;

  /// Whether the field accepts input.
  final bool enabled;

  /// Optional external focus node.
  final FocusNode? focusNode;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  CitySearchResult? _selected;
  List<CitySearchResult> _results = const [];
  bool _loading = false;
  GeoRepository get _repo => widget.repository ?? GeoRepository.instance;

  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  FocusNode? _internalFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  Timer? _debounce;
  bool _selecting = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
    // Kick off background preload so subsequent searches are instant.
    _repo.preloadCities(widget.countryIso2);
    if (widget.initialCityId != null) {
      _hydrateInitial();
    } else if (widget.initialCityName != null &&
        widget.initialCityName!.isNotEmpty) {
      _searchController.text = widget.initialCityName!;
      _hydrateByName(widget.initialCityName!);
    }
  }

  @override
  void didUpdateWidget(CitySearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryIso2 != oldWidget.countryIso2) {
      _clear(notify: true);
      _repo.preloadCities(widget.countryIso2);
    }

    // React to external initialCityName changes (when no ID is set).
    if (widget.initialCityName != oldWidget.initialCityName &&
        widget.initialCityName != null &&
        widget.initialCityName!.isNotEmpty &&
        widget.initialCityId == null &&
        _selected == null) {
      _searchController.text = widget.initialCityName!;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _removeOverlay();
    _searchController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  // ── Focus handling ─────────────────────────────────────────────────────

  void _onFocusChanged() {
    setState(() => _isFocused = _focusNode.hasFocus);
    if (_focusNode.hasFocus) {
      _search(_searchController.text);
    } else if (!_selecting) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!_focusNode.hasFocus && mounted) _removeOverlay();
      });
    }
  }

  // ── Search ─────────────────────────────────────────────────────────────

  void _onSearchTextChanged(String query) {
    // If the user clears the field, clear the selection immediately.
    if (query.isEmpty && _selected != null) {
      _clear(notify: true);
    }
    _debounce?.cancel();
    final debounceMs =
        widget.pickerConfig?.searchDebounce.inMilliseconds ?? 300;
    _debounce = Timer(Duration(milliseconds: debounceMs), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    if (!mounted) return;
    final q = query.trim();
    if (q.isEmpty) {
      setState(() => _results = const []);
      _showOverlay();
      return;
    }

    setState(() => _loading = true);
    final results = await _repo.searchCities(
      countryIso2: widget.countryIso2,
      query: q,
    );
    if (!mounted) return;
    setState(() {
      _results = results;
      _loading = false;
    });
    _showOverlay();
  }

  // ── Overlay ────────────────────────────────────────────────────────────

  void _showOverlay() {
    _removeOverlay();
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => GeoSearchOverlay<CitySearchResult>(
        link: _layerLink,
        fieldKey: _fieldKey,
        fieldWidth: box.size.width,
        items: _results,
        query: _searchController.text,
        nameOf: (r) => r.city.name,
        subtitleOf: (r) => r.state.name,
        selected: _selected,
        theme: widget.pickerTheme,
        maxHeight: widget.pickerConfig?.dropdownMaxHeight ?? 240,
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

  // ── Selection ──────────────────────────────────────────────────────────

  void _onItemSelected(CitySearchResult result) {
    _selecting = true;
    _removeOverlay();
    _searchController.text = result.city.name;
    setState(() => _selected = result);
    widget.onChanged?.call(result);
    _selecting = false;
  }

  void _clear({required bool notify}) {
    _removeOverlay();
    _searchController.clear();
    setState(() {
      _selected = null;
      _results = const [];
    });
    if (notify) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        widget.onChanged?.call(null);
      });
    }
  }

  // ── Initial hydration ──────────────────────────────────────────────────

  Future<void> _hydrateByName(String cityName) async {
    final results = await _repo.searchCities(
      countryIso2: widget.countryIso2,
      query: cityName,
    );
    if (!mounted || results.isEmpty) return;

    // Find exact match (case-insensitive).
    final match = results.cast<CitySearchResult?>().firstWhere(
          (r) => r!.city.name.toLowerCase() == cityName.toLowerCase(),
          orElse: () => null,
        );

    if (match != null) {
      setState(() => _selected = match);
      // Don't call onChanged — this is restoring state, not a user action.
    }
  }

  Future<void> _hydrateInitial() async {
    final states = await _repo.statesOf(widget.countryIso2);
    for (final state in states) {
      final cities = await _repo.citiesOf(state.id);
      for (final city in cities) {
        if (city.id == widget.initialCityId) {
          if (!mounted) return;
          final result = (city: city, state: state);
          _searchController.text = city.name;
          setState(() => _selected = result);
          widget.onChanged?.call(result);
          return;
        }
      }
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? CountrifyFieldStyle.defaultStyle();
    final disabled = !widget.enabled;
    final placeholder = widget.placeholder ?? 'Search city';

    final suffix = _loading
        ? const Padding(
            padding: EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        : null;

    final field = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: style.fieldBorderRadius ?? BorderRadius.circular(12),
        boxShadow: _isFocused && style.focusedBoxShadow != null
            ? style.focusedBoxShadow!
            : const [],
      ),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Opacity(
          opacity: disabled ? 0.55 : 1,
          child: IgnorePointer(
            ignoring: disabled,
            child: TextField(
              key: _fieldKey,
              controller: _searchController,
              focusNode: _focusNode,
              enabled: !disabled,
              onChanged: _onSearchTextChanged,
              style: style.selectedCountryTextStyle,
              cursorColor: style.cursorColor,
              decoration: style
                  .toInputDecoration(suffixIconOverride: suffix)
                  .copyWith(hintText: placeholder),
            ),
          ),
        ),
      ),
    );

    return style.wrapWithExternalLabel(context, child: field);
  }
}
