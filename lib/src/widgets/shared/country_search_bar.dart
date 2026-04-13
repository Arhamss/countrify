import 'dart:async';

import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:flutter/material.dart';

/// {@template country_search_bar}
/// A reusable, theme-aware search bar with debounce, clear button,
/// and accessibility support.
///
/// Replaces duplicated search field patterns across the country picker widgets.
/// {@endtemplate}
class CountrySearchBar extends StatefulWidget {
  /// {@macro country_search_bar}
  const CountrySearchBar({
    super.key,
    this.onChanged,
    this.hintText = 'Search countries',
    this.debounceDuration = const Duration(milliseconds: 200),
    this.theme,
    this.autofocus = false,
  });

  /// Called after the debounce period when the search text changes.
  final ValueChanged<String>? onChanged;

  /// Hint text displayed when the search field is empty.
  final String hintText;

  /// Duration to debounce [onChanged] callbacks.
  final Duration debounceDuration;

  /// Optional theme for styling the search bar.
  final CountryPickerTheme? theme;

  /// Whether the search field should be autofocused.
  final bool autofocus;

  @override
  State<CountrySearchBar> createState() => _CountrySearchBarState();
}

class _CountrySearchBarState extends State<CountrySearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    // Rebuild to show/hide clear button.
    setState(() {});

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  void _clearText() {
    _controller.clear();
    setState(() {});

    _debounceTimer?.cancel();
    widget.onChanged?.call('');
  }

  InputDecoration _buildDecoration() {
    final theme = widget.theme;

    // If a full custom InputDecoration is provided, use it directly.
    if (theme?.searchInputDecoration != null) {
      return theme!.searchInputDecoration!;
    }

    final borderRadius =
        theme?.searchBarBorderRadius ?? BorderRadius.circular(12);
    final borderColor = theme?.searchBarBorderColor ?? const Color(0xFFE0E0E0);
    final focusedBorderColor =
        theme?.searchFocusedBorderColor ?? borderColor;

    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: theme?.searchHintStyle,
      filled: theme?.searchBarColor != null,
      fillColor: theme?.searchBarColor,
      contentPadding: theme?.searchContentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: Icon(
        theme?.searchIcon ?? CountrifyIcons.search,
        color: theme?.searchIconColor,
      ),
      suffixIcon: _controller.text.isNotEmpty
          ? Tooltip(
              message: 'Clear search',
              child: IconButton(
                icon: Icon(
                  theme?.clearIcon ?? CountrifyIcons.circleX,
                  color: theme?.searchIconColor,
                ),
                onPressed: _clearText,
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: focusedBorderColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Semantics(
      label: 'Search countries',
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        style: theme?.searchTextStyle,
        cursorColor: theme?.searchCursorColor,
        decoration: _buildDecoration(),
        onChanged: _onTextChanged,
      ),
    );
  }
}
