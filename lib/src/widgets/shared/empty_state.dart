import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';

/// Displayed when a country search or filter yields no results.
class CountryEmptyState extends StatelessWidget {
  /// Creates a [CountryEmptyState].
  const CountryEmptyState({
    super.key,
    this.text = 'No countries found',
    this.icon,
    this.iconSize = 28,
    this.iconColor,
    this.textStyle,
  });

  /// The message displayed below the icon.
  final String text;

  /// The icon displayed above the text. Defaults to [CountrifyIcons.searchX].
  final IconData? icon;

  /// Size of the icon. Defaults to `28`.
  final double iconSize;

  /// Color of the icon. Defaults to [Colors.grey].
  final Color? iconColor;

  /// Style for the message text.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? CountrifyIcons.searchX,
              size: iconSize,
              color: iconColor ?? Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: textStyle ??
                  TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
