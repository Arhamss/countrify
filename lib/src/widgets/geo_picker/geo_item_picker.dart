// ignore_for_file: avoid_positional_boolean_parameters, the `selected` flag is a natural positional argument on item-builder callbacks and matches Flutter's own builder conventions.

import 'dart:async';

import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Signature for a row builder. Called for every visible item; return a
/// widget to render inside the tap region. [selected] indicates whether the
/// item is the currently-selected one and can be used to alter appearance.
typedef GeoItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool selected,
);

/// Signature for an async loader producing the full list of pickable items.
/// The picker shows a progress indicator while the future is pending and an
/// empty-state if it resolves to an empty list.
typedef GeoItemLoader<T> = Future<List<T>> Function();

/// Signature for text-based item matching. Return `true` when [item] matches
/// the free-text [query] (already lower-cased and trimmed by the picker).
typedef GeoItemMatcher<T> = bool Function(T item, String query);

/// Signature for fully-custom header builders.
typedef GeoHeaderBuilder = Widget Function(
  BuildContext context,
  VoidCallback onClose,
);

/// Signature for fully-custom search field builders. The provided
/// [controller] must be attached to the returned widget for the picker to
/// receive query updates.
typedef GeoSearchBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
);

/// Signature for the empty-state builder.
typedef GeoEmptyStateBuilder = Widget Function(BuildContext context);

/// Generic picker scaffold used internally by `StatePicker` and `CityPicker`.
///
/// Exposed to package consumers via those two thin wrappers so the UI stays
/// consistent across pickers without duplicating list / search / mode
/// handling logic.
class GeoItemPicker<T> extends StatefulWidget {
  /// Creates a generic picker. Prefer `StatePicker` / `CityPicker` unless
  /// building a custom adapter.
  const GeoItemPicker({
    required this.loader,
    required this.matcher,
    required this.itemBuilder,
    required this.title,
    required this.searchHintText,
    required this.emptyStateText,
    super.key,
    this.selected,
    this.onSelected,
    this.theme,
    this.config,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.headerBuilder,
    this.searchBuilder,
    this.emptyStateBuilder,
    this.subtitleOf,
    this.semanticLabelOf,
    this.onSearchChanged,
    this.onResultsChanged,
  });

  /// Loads the pickable items asynchronously. The result is cached for the
  /// lifetime of the widget.
  final GeoItemLoader<T> loader;

  /// Returns true when an item matches the search query.
  final GeoItemMatcher<T> matcher;

  /// Builds each visible item row.
  final GeoItemBuilder<T> itemBuilder;

  /// Optional subtitle provider, used when [itemBuilder] is not supplied and
  /// falls through to the default row rendering (not used when a custom
  /// [itemBuilder] owns the full row).
  final String? Function(T)? subtitleOf;

  /// Optional custom semantic label provider for accessibility.
  final String Function(T)? semanticLabelOf;

  /// Currently selected item, highlighted in the list.
  final T? selected;

  /// Invoked when an item is tapped. The picker does not dismiss itself;
  /// callers are expected to pop the enclosing route or close the sheet.
  final ValueChanged<T>? onSelected;

  /// Theme.
  final GeoPickerTheme? theme;

  /// Config.
  final GeoPickerConfig? config;

  /// Display style.
  final CountryPickerMode pickerMode;

  /// Fully custom header builder.
  final GeoHeaderBuilder? headerBuilder;

  /// Fully custom search field builder.
  final GeoSearchBuilder? searchBuilder;

  /// Fully custom empty-state builder.
  final GeoEmptyStateBuilder? emptyStateBuilder;

  /// Title shown in the header.
  final String title;

  /// Hint shown in the search field.
  final String searchHintText;

  /// Primary text of the empty-results state.
  final String emptyStateText;

  /// Fires on every debounced search change with the raw (untrimmed) query.
  /// Useful for analytics or cross-picker synchronization.
  final ValueChanged<String>? onSearchChanged;

  /// Fires whenever the filtered result list changes. Callers receive an
  /// immutable `List<T>` they can safely forward into their own state.
  final ValueChanged<List<T>>? onResultsChanged;

  @override
  State<GeoItemPicker<T>> createState() => _GeoItemPickerState<T>();
}

class _GeoItemPickerState<T> extends State<GeoItemPicker<T>> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;
  List<T>? _items;
  List<T> _filtered = const [];
  String _query = '';
  Object? _loadError;

  GeoPickerTheme get _theme => widget.theme ?? const GeoPickerTheme();
  GeoPickerConfig get _config => widget.config ?? const GeoPickerConfig();

  @override
  void initState() {
    super.initState();
    final seed = (widget.config ?? const GeoPickerConfig()).initialSearchText;
    if (seed != null && seed.isNotEmpty) {
      _searchController.text = seed;
      _query = _normalize(seed);
    }
    _load();
    _searchController.addListener(_onSearchChanged);
  }

  String _normalize(String input) {
    return _config.accentInsensitiveSearch
        ? SearchNormalizer.foldAccents(input)
        : SearchNormalizer.basic(input);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final data = await widget.loader();
      if (!mounted) return;
      final initial = _query.isEmpty
          ? data
          : data.where((e) => widget.matcher(e, _query)).toList(growable: false);
      setState(() {
        _items = data;
        _filtered = initial;
      });
      widget.onResultsChanged?.call(initial);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _loadError = e);
    }
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(_config.searchDebounce, () {
      final raw = _searchController.text;
      final q = _normalize(raw);
      if (q == _query) return;
      _query = q;
      widget.onSearchChanged?.call(raw);
      final source = _items ?? const [];
      final next = q.isEmpty
          ? source
          : source.where((e) => widget.matcher(e, q)).toList(growable: false);
      if (!mounted) return;
      setState(() => _filtered = next);
      widget.onResultsChanged?.call(next);
    });
  }

  void _handleTap(T item) {
    if (_config.hapticFeedback) {
      HapticFeedback.selectionClick();
    }
    widget.onSelected?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.pickerMode) {
      CountryPickerMode.bottomSheet => _buildSheetShell(),
      CountryPickerMode.dialog => _buildSheetShell(),
      CountryPickerMode.fullScreen => _buildFullScreen(context),
      CountryPickerMode.dropdown => _buildDropdown(),
      CountryPickerMode.none => const SizedBox.shrink(),
    };
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Layouts
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildSheetShell() {
    final bg = _theme.backgroundColor ?? Theme.of(context).colorScheme.surface;
    final radius = _theme.borderRadius ?? const BorderRadius.vertical(top: Radius.circular(20));
    final shape = RoundedRectangleBorder(borderRadius: radius);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final availableHeight = screenHeight - mediaQuery.padding.top;
    final requestedMax = _config.maxHeight ?? screenHeight * 0.85;
    final maxHeight = availableHeight - keyboardInset < requestedMax
        ? availableHeight - keyboardInset
        : requestedMax;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: keyboardInset),
        child: Material(
          color: bg,
          shape: shape,
          elevation: _theme.elevation ?? 0,
          shadowColor: _theme.shadowColor,
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: _config.minHeight,
              maxHeight: maxHeight < _config.minHeight
                  ? _config.minHeight
                  : maxHeight,
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildGrabber(),
                  _buildHeader(),
                  if (_config.searchEnabled) _buildSearch(),
                  Expanded(child: _buildBody()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullScreen(BuildContext context) {
    final bg = _theme.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: _theme.headerColor,
        title: Text(widget.title, style: _theme.headerTextStyle),
        iconTheme: IconThemeData(color: _theme.headerIconColor),
        actions: [
          IconButton(
            icon: Icon(_theme.resolvedCloseIcon),
            tooltip: _config.cancelText,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_config.searchEnabled)
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearch(),
            ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Material(
      color: _theme.backgroundColor ?? Theme.of(context).colorScheme.surface,
      elevation: _theme.elevation ?? 4,
      shadowColor: _theme.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: _theme.borderRadius ?? BorderRadius.circular(12),
        side: _theme.borderColor == null
            ? BorderSide.none
            : BorderSide(color: _theme.borderColor!),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: _config.dropdownMaxHeight ?? 280,
        child: Column(
          children: [
            if (_config.searchEnabled)
              Padding(
                padding: const EdgeInsets.all(8),
                child: _buildSearch(),
              ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // Pieces
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildGrabber() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (widget.headerBuilder != null) {
      return widget.headerBuilder!(context, () => Navigator.of(context).maybePop());
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 8, 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: _theme.headerTextStyle ??
                  Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
            ),
          ),
          IconButton(
            icon: Icon(
              _theme.resolvedCloseIcon,
              color: _theme.headerIconColor,
              size: 18,
            ),
            tooltip: _config.cancelText,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    if (widget.searchBuilder != null) {
      return widget.searchBuilder!(context, _searchController);
    }
    if (_theme.searchInputDecoration != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _searchController,
          decoration: _theme.searchInputDecoration,
          style: _theme.searchTextStyle,
          cursorColor: _theme.searchCursorColor,
        ),
      );
    }
    final radius = _theme.searchBarBorderRadius ?? BorderRadius.circular(12);
    final borderColor = _theme.searchBarBorderColor ?? Theme.of(context).dividerColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: TextField(
        controller: _searchController,
        autofocus: _config.autofocusSearch,
        style: _theme.searchTextStyle,
        cursorColor: _theme.searchCursorColor,
        decoration: InputDecoration(
          hintText: widget.searchHintText,
          hintStyle: _theme.searchHintStyle,
          filled: _theme.searchBarColor != null,
          fillColor: _theme.searchBarColor,
          contentPadding: _theme.searchContentPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          prefixIcon: _theme.searchIcon != null
              ? Icon(_theme.searchIcon, color: _theme.searchIconColor, size: 18)
              : Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: CountrifySearchIcon(
                      size: 18, color: _theme.searchIconColor),
                ),
          prefixIconConstraints: const BoxConstraints(),
          // ValueListenableBuilder keeps the clear button in sync with every
          // keystroke without waiting for the debounced filter to fire.
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (_, value, __) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(_theme.resolvedClearIcon, size: 16, color: _theme.searchIconColor),
                tooltip: 'Clear',
                onPressed: _searchController.clear,
              );
            },
          ),
          border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(
              color: _theme.searchFocusedBorderColor ?? Theme.of(context).colorScheme.primary,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loadError != null) {
      return _buildEmpty(message: 'Failed to load data');
    }
    if (_items == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_filtered.isEmpty) {
      return _buildEmpty();
    }
    final list = ListView.builder(
      controller: _scrollController,
      padding: _config.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
      itemCount: _filtered.length,
      itemExtent: _config.itemExtent,
      itemBuilder: (_, i) => _buildRow(_filtered[i]),
    );
    if (!_config.enableScrollbar) return list;
    return Scrollbar(
      controller: _scrollController,
      thickness: _theme.scrollbarThickness,
      radius: _theme.scrollbarRadius,
      child: list,
    );
  }

  Widget _buildRow(T item) {
    final isSelected = widget.selected != null && item == widget.selected;
    final radius = _theme.itemBorderRadius ?? BorderRadius.circular(10);
    final bg = isSelected
        ? (_theme.itemSelectedColor ??
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.08))
        : _theme.itemBackgroundColor ?? Colors.transparent;
    final border = isSelected && _theme.itemSelectedBorderColor != null
        ? Border.all(color: _theme.itemSelectedBorderColor!)
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Semantics(
        button: true,
        label: widget.semanticLabelOf?.call(item),
        selected: isSelected,
        child: Material(
          color: bg,
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: () => _handleTap(item),
            child: Container(
              decoration: BoxDecoration(borderRadius: radius, border: border),
              padding: _theme.itemContentPadding ??
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: widget.itemBuilder(context, item, isSelected)),
                  if (isSelected && _config.showSelectedIcon)
                    if (_theme.selectedIcon != null)
                      Icon(
                        _theme.selectedIcon,
                        size: 18,
                        color: _theme.itemSelectedIconColor ??
                            Theme.of(context).colorScheme.primary,
                      )
                    else
                      CountrifyCheckIcon(
                        size: 18,
                        color: _theme.itemSelectedIconColor ??
                            Theme.of(context).colorScheme.primary,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty({String? message}) {
    if (widget.emptyStateBuilder != null) {
      return widget.emptyStateBuilder!(context);
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _theme.resolvedEmptyStateIcon,
              size: 40,
              color: _theme.headerIconColor ?? Theme.of(context).hintColor,
            ),
            const SizedBox(height: 12),
            Text(
              message ?? widget.emptyStateText,
              style: _theme.emptyStateTextStyle ?? Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (_config.emptyStateSubtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                _config.emptyStateSubtitle!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
