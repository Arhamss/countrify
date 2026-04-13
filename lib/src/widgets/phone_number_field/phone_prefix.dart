import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/country_flag.dart';
import 'package:flutter/material.dart';

/// Internal prefix widget for the phone number field.
///
/// Displays the selected country flag, dial code, dropdown icon, and divider.
/// This widget is not publicly exported.
class PhonePrefix extends StatelessWidget {
  const PhonePrefix({
    required this.style,
    required this.theme,
    required this.pickerMode,
    super.key,
    this.selectedCountry,
    this.showFlag = true,
    this.showDialCode = true,
    this.showDropdownIcon = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.isDropdownOpen = false,
    this.enabled = true,
    this.onTap,
  });

  /// The currently selected country.
  final Country? selectedCountry;

  /// Style configuration for the field.
  final CountrifyFieldStyle style;

  /// Theme configuration for the picker.
  final CountryPickerTheme theme;

  /// How the picker opens.
  final CountryPickerMode pickerMode;

  /// Whether to show the country flag.
  final bool showFlag;

  /// Whether to show the dial code.
  final bool showDialCode;

  /// Whether to show a dropdown arrow icon.
  final bool showDropdownIcon;

  /// Size of the flag image.
  final Size flagSize;

  /// Border radius of the flag.
  final BorderRadius flagBorderRadius;

  /// Whether the dropdown is currently open.
  final bool isDropdownOpen;

  /// Whether the field is enabled.
  final bool enabled;

  /// Called when the prefix is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dialCode =
        selectedCountry != null && selectedCountry!.callingCodes.isNotEmpty
            ? '+${selectedCountry!.callingCodes.first}'
            : '';

    return GestureDetector(
      onTap: pickerMode == CountryPickerMode.none ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: style.prefixPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showFlag && selectedCountry != null) ...[
              CountryFlag(
                country: selectedCountry!,
                size: flagSize,
                borderRadius: flagBorderRadius,
              ),
              const SizedBox(width: 8),
            ],
            if (showDialCode && dialCode.isNotEmpty)
              Text(
                dialCode,
                style: style.dialCodeTextStyle ??
                    theme.compactDialCodeTextStyle ??
                    theme.countryNameTextStyle?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            if (showDropdownIcon &&
                pickerMode != CountryPickerMode.none) ...[
              const SizedBox(width: 4),
              Semantics(
                label: 'Open country picker',
                child: AnimatedRotation(
                  turns: isDropdownOpen ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    theme.dropdownIcon ?? CountrifyIcons.chevronDown,
                    size: 20,
                    color: enabled
                        ? theme.headerIconColor ?? Colors.black54
                        : Colors.grey,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 24,
              color: style.dividerColor ??
                  theme.borderColor ??
                  Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
