import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/countrify_check_icon.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:countrify/src/widgets/shared/empty_state.dart';
import 'package:flutter/material.dart';

/// Internal dropdown overlay anchored below (or above) the phone number
/// field.
///
/// On every rebuild the overlay inspects the ambient [MediaQuery] and the
/// live field position (via [fieldKey]) so it can flip above the field when
/// the keyboard — or a short distance to the bottom edge — would cover it.
///
/// This widget is not publicly exported.
class PhoneDropdownOverlay extends StatefulWidget {
  const PhoneDropdownOverlay({
    required this.link,
    required this.fieldKey,
    required this.fieldWidth,
    required this.maxHeight,
    required this.theme,
    required this.searchEnabled,
    required this.onSelected,
    required this.onDismiss,
    super.key,
    this.config,
    this.selectedCountry,
    this.showFlag = true,
    this.showCountryName = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final LayerLink link;

  /// Key attached to the anchor field. Used to read the field's live global
  /// position on every rebuild so the overlay can decide whether to drop
  /// below or flip above.
  final GlobalKey fieldKey;
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
  State<PhoneDropdownOverlay> createState() => _PhoneDropdownOverlayState();
}

class _PhoneDropdownOverlayState extends State<PhoneDropdownOverlay>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Country> _countries = [];
  List<Country> _filtered = [];
  Timer? _debounce;
  late String _effectiveLocale;
  late final AnimationController _animController;
  late final Animation<double> _fade;
  Animation<Offset> _slide = const AlwaysStoppedAnimation(Offset.zero);
  bool _closing = false;

  // Minimum pixels needed below the field before we give up and flip above.
  static const double _minSpaceBelow = 150;

  // Gap between the field and the dropdown card.
  static const double _gap = 4;

  // Breathing room left between the card and the opposite edge of the
  // available space (keyboard / top of screen), so the card never bleeds
  // straight into the viewport boundary.
  static const double _edgeMargin = 20;

  @override
  void initState() {
    super.initState();
    _effectiveLocale = widget.config?.locale ?? 'en';
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _fade = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _loadCountries();
    // The slide direction is decided in [build] (once layout is known and
    // we can tell whether the dropdown should appear below or above). The
    // forward animation is kicked off from the very first build so it
    // plays with the correct direction without a flicker.
  }

  Future<void> _runExitThen(VoidCallback after) async {
    if (_closing) return;
    _closing = true;
    if (mounted) {
      await _animController.reverse();
    }
    after();
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
    _animController.dispose();
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

  /// Reads the live global position of the anchor field from `fieldKey`
  /// and figures out whether to open the dropdown below or above,
  /// plus how much vertical room the card has.
  ({bool openAbove, double maxHeight}) _resolvePlacement(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final keyboardInset = mediaQuery.viewInsets.bottom;
    final topPadding = mediaQuery.padding.top;

    final renderBox =
        widget.fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      // Field not laid out yet — keep the requested maxHeight, default
      // to opening below.
      return (openAbove: false, maxHeight: widget.maxHeight);
    }

    final fieldTopLeft = renderBox.localToGlobal(Offset.zero);
    final fieldTop = fieldTopLeft.dy;
    final fieldBottom = fieldTop + renderBox.size.height;

    final spaceBelow = screenHeight - fieldBottom - keyboardInset - _gap;
    final spaceAbove = fieldTop - topPadding - _gap;

    final openAbove = spaceBelow < _minSpaceBelow && spaceAbove > spaceBelow;

    final available = openAbove ? spaceAbove : spaceBelow;
    final clamped = (available - _edgeMargin).clamp(0.0, widget.maxHeight);
    return (openAbove: openAbove, maxHeight: clamped);
  }

  void _ensureSlideDirection({required bool openAbove}) {
    // Slide from slightly below when opening upward, from slightly above
    // when opening downward. Rebuild the tween whenever direction flips.
    final begin =
        openAbove ? const Offset(0, 0.08) : const Offset(0, -0.08);
    if (_slide is Tween<Offset> || _animController.isAnimating) {
      // Flutter won't accept re-configuring the same running animation, so
      // compare via the current begin value encoded in _slide.value at rest.
    }
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    if (_animController.status == AnimationStatus.dismissed) {
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final placement = _resolvePlacement(context);
    final openAbove = placement.openAbove;
    final effectiveMaxHeight = placement.maxHeight > 0
        ? placement.maxHeight
        : widget.maxHeight;

    // Kick off / re-orient the slide-in animation once we know which way
    // the dropdown is opening. Done after the current frame so we never
    // call setState / rebuild tweens during paint.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _ensureSlideDirection(openAbove: openAbove);
    });

    // Anchors flip depending on whether the card sits below or above the
    // field. The LayerLink itself still follows the field, so the card
    // stays attached if the field is scrolled or the keyboard pushes it.
    final targetAnchor =
        openAbove ? Alignment.topLeft : Alignment.bottomLeft;
    final followerAnchor =
        openAbove ? Alignment.bottomLeft : Alignment.topLeft;
    final followerOffset =
        openAbove ? const Offset(0, -_gap) : const Offset(0, _gap);

    return Stack(
      children: [
        // Dismiss layer — tapping outside first unfocuses any field, then
        // plays the reverse animation before removing the overlay.
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              _runExitThen(widget.onDismiss);
            },
            behavior: HitTestBehavior.translucent,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        // Dropdown card
        CompositedTransformFollower(
          link: widget.link,
          showWhenUnlinked: false,
          offset: followerOffset,
          targetAnchor: targetAnchor,
          followerAnchor: followerAnchor,
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
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
                  constraints: BoxConstraints(maxHeight: effectiveMaxHeight),
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
          prefixIcon: theme.searchIcon != null
              ? Icon(theme.searchIcon, color: theme.searchIconColor)
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: CountrifySearchIcon(color: theme.searchIconColor),
                ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  tooltip: 'Clear search',
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
      child: Semantics(
        label: 'Search countries',
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: theme.searchTextStyle,
          cursorColor: theme.searchCursorColor,
          decoration: effectiveDecoration,
        ),
      ),
    );
  }

  Widget _buildList(CountryPickerTheme theme) {
    if (_filtered.isEmpty) {
      final config = widget.config ?? const CountryPickerConfig();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: CountryEmptyState(
          text: config.emptyStateText,
          icon: theme.emptyStateIcon ?? CountrifyIcons.searchX,
          textStyle:
              theme.readOnlyHintTextStyle ?? theme.countrySubtitleTextStyle,
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
          onTap: () {
            FocusScope.of(context).unfocus();
            _runExitThen(() => widget.onSelected(country));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: isSelected
                ? theme.countryItemSelectedColor ??
                    Colors.blue.withValues(alpha: 0.08)
                : null,
            child: Row(
              children: [
                if (widget.showFlag) ...[
                  CountryFlag(
                    country: country,
                    size: widget.flagSize,
                    borderRadius: widget.flagBorderRadius,
                  ),
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
                    child: theme.selectedIcon != null
                        ? Icon(
                            theme.selectedIcon,
                            size: 16,
                            color: theme.countryItemSelectedIconColor ??
                                Colors.blue,
                          )
                        : CountrifyCheckIcon(
                            size: 16,
                            color: theme.countryItemSelectedIconColor ??
                                Colors.blue,
                          ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
