import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/shared/country_list_tile.dart';
import 'package:countrify/src/widgets/shared/empty_state.dart';
import 'package:flutter/material.dart';

/// A scrollable list of countries with selection support and empty state.
///
/// Example:
/// ```dart
/// CountryListView(
///   countries: CountryUtils.getAllCountries(),
///   onSelected: (country) => print(country.name),
///   selectedCountry: currentCountry,
/// )
/// ```
class CountryListView extends StatelessWidget {
  /// Creates a [CountryListView].
  const CountryListView({
    required this.countries,
    required this.onSelected,
    super.key,
    this.selectedCountry,
    this.theme,
    this.showFlag = true,
    this.showCountryName = true,
    this.showDialCode = true,
    this.flagSize = const Size(24, 18),
    this.flagBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.itemExtent = 44,
    this.emptyStateText = 'No countries found',
    this.emptyStateIcon,
    this.displayNameBuilder,
  });

  /// The list of countries to display.
  final List<Country> countries;

  /// Called when a country is tapped.
  final ValueChanged<Country> onSelected;

  /// The currently selected country, if any.
  final Country? selectedCountry;

  /// Optional theme overrides for list items.
  final CountryPickerTheme? theme;

  /// Whether to show country flags. Defaults to `true`.
  final bool showFlag;

  /// Whether to show country names. Defaults to `true`.
  final bool showCountryName;

  /// Whether to show dial codes. Defaults to `true`.
  final bool showDialCode;

  /// Size of each country flag.
  final Size flagSize;

  /// Border radius of each country flag.
  final BorderRadius flagBorderRadius;

  /// Fixed height for each list item. Defaults to `44`.
  final double itemExtent;

  /// Text shown in the empty state. Defaults to `'No countries found'`.
  final String emptyStateText;

  /// Icon shown in the empty state.
  final IconData? emptyStateIcon;

  /// Build a localized display name for a country.
  /// Falls back to [Country.name].
  final String Function(Country)? displayNameBuilder;

  @override
  Widget build(BuildContext context) {
    if (countries.isEmpty) {
      return CountryEmptyState(
        text: emptyStateText,
        icon: emptyStateIcon,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      itemCount: countries.length,
      itemExtent: itemExtent,
      itemBuilder: (_, index) {
        final country = countries[index];
        final isSelected = selectedCountry?.alpha2Code == country.alpha2Code;

        return CountryListTile(
          country: country,
          onTap: onSelected,
          isSelected: isSelected,
          showFlag: showFlag,
          showCountryName: showCountryName,
          showDialCode: showDialCode,
          flagSize: flagSize,
          flagBorderRadius: flagBorderRadius,
          displayName: displayNameBuilder?.call(country),
          countryNameStyle: theme?.countryNameTextStyle,
          dialCodeStyle: theme?.compactDialCodeTextStyle,
          selectedColor: theme?.countryItemSelectedColor,
          selectedIconColor: theme?.countryItemSelectedIconColor,
        );
      },
    );
  }
}
