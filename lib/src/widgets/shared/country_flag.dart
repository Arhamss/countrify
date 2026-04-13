import 'package:countrify/src/models/country.dart';
import 'package:flutter/material.dart';

/// A standalone flag widget that displays a country's flag image with
/// automatic emoji fallback.
///
/// Example:
/// ```dart
/// CountryFlag(
///   country: CountryUtils.getCountryByAlpha2Code('US')!,
///   size: const Size(32, 24),
/// )
/// ```
class CountryFlag extends StatelessWidget {
  const CountryFlag({
    required this.country,
    super.key,
    this.size = const Size(24, 18),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.borderColor,
    this.borderWidth = 0.5,
    this.emojiTextStyle,
  });

  /// The country whose flag to display.
  final Country country;

  /// Size of the flag image.
  final Size size;

  /// Border radius of the flag container.
  final BorderRadius borderRadius;

  /// Border color. Defaults to `Colors.grey.shade300`.
  final Color? borderColor;

  /// Border width. Defaults to `0.5`.
  final double borderWidth;

  /// Text style for the emoji fallback when the flag image fails to load.
  final TextStyle? emojiTextStyle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Flag of ${country.name}',
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: borderColor ?? Colors.grey.shade300,
              width: borderWidth,
            ),
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Image.asset(
              country.flagImagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: Colors.grey.shade300,
                child: Center(
                  child: Text(
                    country.flagEmoji,
                    style: emojiTextStyle ??
                        TextStyle(fontSize: size.width * 0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
