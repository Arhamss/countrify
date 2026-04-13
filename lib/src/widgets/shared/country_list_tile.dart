import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:flutter/material.dart';

/// A reusable country row widget that displays a flag, country name,
/// dial code, and optional selected checkmark.
///
/// Example:
/// ```dart
/// CountryListTile(
///   country: CountryUtils.getCountryByAlpha2Code('US')!,
///   onTap: (country) => print(country.name),
///   isSelected: true,
/// )
/// ```
class CountryListTile extends StatelessWidget {
  /// Creates a [CountryListTile].
  const CountryListTile({
    required this.country,
    required this.onTap,
    super.key,
    this.isSelected = false,
    this.showFlag = true,
    this.showCountryName = true,
    this.showDialCode = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.countryNameStyle,
    this.dialCodeStyle,
    this.selectedColor,
    this.selectedIconColor,
    this.selectedIcon,
    this.displayName,
  });

  /// The country to display.
  final Country country;

  /// Callback when the tile is tapped.
  final ValueChanged<Country> onTap;

  /// Whether this tile is currently selected.
  final bool isSelected;

  /// Whether to show the flag. Defaults to `true`.
  final bool showFlag;

  /// Whether to show the country name. Defaults to `true`.
  final bool showCountryName;

  /// Whether to show the dial code. Defaults to `true`.
  final bool showDialCode;

  /// Size of the flag image.
  final Size flagSize;

  /// Border radius of the flag container.
  final BorderRadius flagBorderRadius;

  /// Text style for the country name.
  final TextStyle? countryNameStyle;

  /// Text style for the dial code.
  final TextStyle? dialCodeStyle;

  /// Background color when selected.
  final Color? selectedColor;

  /// Color of the selected checkmark icon.
  final Color? selectedIconColor;

  /// Custom icon to show when selected. Defaults to [Icons.check].
  final IconData? selectedIcon;

  /// Pre-localized display name. Falls back to [Country.name].
  final String? displayName;

  String get _effectiveName => displayName ?? country.name;

  String get _dialCode =>
      country.callingCodes.isNotEmpty ? '+${country.callingCodes.first}' : '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: '$_effectiveName, dial code $_dialCode',
      child: InkWell(
        onTap: () => onTap(country),
        child: Container(
          color: isSelected ? (selectedColor ?? theme.highlightColor) : null,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (showFlag) ...[
                CountryFlag(
                  country: country,
                  size: flagSize,
                  borderRadius: flagBorderRadius,
                ),
                const SizedBox(width: 12),
              ],
              if (showDialCode && _dialCode.isNotEmpty) ...[
                Text(
                  _dialCode,
                  style: dialCodeStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 8),
              ],
              if (showCountryName)
                Expanded(
                  child: Text(
                    _effectiveName,
                    overflow: TextOverflow.ellipsis,
                    style: countryNameStyle ?? theme.textTheme.bodyMedium,
                  ),
                )
              else
                const Spacer(),
              if (isSelected)
                Icon(
                  selectedIcon ?? Icons.check,
                  color: selectedIconColor ?? theme.colorScheme.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
