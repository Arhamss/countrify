import 'package:countrify/src/data/geo_repository.dart';
import 'package:countrify/src/models/city.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/models/country_code.dart';
import 'package:countrify/src/models/state.dart';
import 'package:countrify/src/utils/country_utils.dart';
import 'package:countrify/src/widgets/city_dropdown_field/city_dropdown_field.dart';
import 'package:countrify/src/widgets/countrify_field_style.dart';
import 'package:countrify/src/widgets/country_dropdown_field/country_dropdown_field.dart';
import 'package:countrify/src/widgets/country_picker_config.dart';
import 'package:countrify/src/widgets/country_picker_mode.dart';
import 'package:countrify/src/widgets/country_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_config.dart';
import 'package:countrify/src/widgets/geo_picker/geo_picker_theme.dart';
import 'package:countrify/src/widgets/geo_picker/geo_sort_by.dart';
import 'package:countrify/src/widgets/state_dropdown_field/state_dropdown_field.dart';
import 'package:flutter/widgets.dart';

/// Immutable snapshot of the current country / state / city selection.
@immutable
class CountryStateCitySelection {
  /// Creates a selection snapshot.
  const CountryStateCitySelection({this.country, this.state, this.city});

  /// Selected country, or null when nothing is selected.
  final Country? country;

  /// Selected state, or null when no state has been chosen for [country].
  final CountryState? state;

  /// Selected city, or null when no city has been chosen for [state].
  final City? city;

  /// Whether all three levels are populated.
  bool get isComplete => country != null && state != null && city != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountryStateCitySelection &&
          other.country == country &&
          other.state == state &&
          other.city == city);

  @override
  int get hashCode => Object.hash(country, state, city);

  @override
  String toString() =>
      'CountryStateCitySelection(country: ${country?.name}, state: ${state?.name}, city: ${city?.name})';
}

/// {@template country_state_city_field}
/// A composite form field that stacks [CountryDropdownField],
/// [StateDropdownField], and [CityDropdownField] into a cascading
/// country → state → city selector.
///
/// Changing the country clears the state and city; changing the state
/// clears the city.
///
/// All three children share [fieldStyle] for visual consistency but each
/// exposes picker-level theming and config overrides individually:
///
/// ```dart
/// CountryStateCityField(
///   initialCountryCode: CountryCode.us,
///   onChanged: (sel) => print(sel),
///   fieldStyle: CountrifyFieldStyle.defaultStyle(),
///   countryPickerTheme: CountryPickerTheme(...),
///   geoPickerTheme: GeoPickerTheme.light(),
/// )
/// ```
/// {@endtemplate}
class CountryStateCityField extends StatefulWidget {
  /// {@macro country_state_city_field}
  const CountryStateCityField({
    super.key,
    this.initialCountryCode,
    this.initialStateId,
    this.initialCityId,
    this.onChanged,
    this.fieldStyle,
    this.countryFieldStyle,
    this.stateFieldStyle,
    this.cityFieldStyle,
    this.countryPickerTheme,
    this.countryPickerConfig,
    this.geoPickerTheme,
    this.geoPickerConfig,
    this.pickerMode = CountryPickerMode.bottomSheet,
    this.enabled = true,
    this.showFlag = true,
    this.searchEnabled = true,
    this.showStateType = true,
    this.showCityCoordinates = false,
    this.countryLabel = 'Country',
    this.stateLabel = 'State / Province',
    this.cityLabel = 'City',
    this.spacing = 12,
    this.stateSortBy = StateSortBy.name,
    this.citySortBy = CitySortBy.name,
    this.repository,
  });

  /// Initial country by enum code.
  final CountryCode? initialCountryCode;

  /// Initial state id (only applied if it belongs to [initialCountryCode]).
  final int? initialStateId;

  /// Initial city id (only applied if it belongs to [initialStateId]).
  final int? initialCityId;

  /// Emits on every selection change.
  final ValueChanged<CountryStateCitySelection>? onChanged;

  /// Shared field decoration applied to all three dropdowns. Per-field
  /// overrides below take precedence when set.
  final CountrifyFieldStyle? fieldStyle;

  /// Field decoration for the country dropdown.
  final CountrifyFieldStyle? countryFieldStyle;

  /// Field decoration for the state dropdown.
  final CountrifyFieldStyle? stateFieldStyle;

  /// Field decoration for the city dropdown.
  final CountrifyFieldStyle? cityFieldStyle;

  /// Theme applied to the `CountryPicker` opened by the country dropdown.
  final CountryPickerTheme? countryPickerTheme;

  /// Config applied to the `CountryPicker`.
  final CountryPickerConfig? countryPickerConfig;

  /// Theme applied to both the state and city pickers.
  final GeoPickerTheme? geoPickerTheme;

  /// Config applied to both the state and city pickers.
  final GeoPickerConfig? geoPickerConfig;

  /// Display style applied to all three pickers.
  final CountryPickerMode pickerMode;

  /// Whether the field accepts input.
  final bool enabled;

  /// Whether to show the country flag inside the country dropdown.
  final bool showFlag;

  /// Whether the pickers show search fields.
  final bool searchEnabled;

  /// Whether to show the subdivision type as a subtitle on state rows.
  final bool showStateType;

  /// Whether to show lat/lng as a subtitle on city rows.
  final bool showCityCoordinates;

  /// Label for the country field.
  final String countryLabel;

  /// Label for the state field.
  final String stateLabel;

  /// Label for the city field.
  final String cityLabel;

  /// Vertical gap between each dropdown.
  final double spacing;

  /// Sort order in the state picker.
  final StateSortBy stateSortBy;

  /// Sort order in the city picker.
  final CitySortBy citySortBy;

  /// Repository override (primarily for tests).
  final GeoRepository? repository;

  @override
  State<CountryStateCityField> createState() => _CountryStateCityFieldState();
}

class _CountryStateCityFieldState extends State<CountryStateCityField> {
  Country? _country;
  CountryState? _state;
  City? _city;

  @override
  void initState() {
    super.initState();
    _country = CountryUtils.resolveInitialCountry(
      initialCountryCode: widget.initialCountryCode,
    );
  }

  void _emit() {
    widget.onChanged?.call(
      CountryStateCitySelection(country: _country, state: _state, city: _city),
    );
  }

  CountrifyFieldStyle _styleFor({required String label, CountrifyFieldStyle? override}) {
    final base = override ??
        widget.fieldStyle ??
        CountrifyFieldStyle.defaultStyle();
    // Use external label by default; fall back to in-field labelText only
    // if the caller explicitly set it via the style override.
    final useExternal = base.externalLabel == null && base.labelText == null;
    return base.copyWith(
      externalLabel: useExternal ? label : base.externalLabel,
      labelText: useExternal ? null : base.labelText,
      enabled: widget.enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CountryDropdownField(
          initialCountryCode: widget.initialCountryCode,
          style: _styleFor(override: widget.countryFieldStyle, label: widget.countryLabel),
          theme: widget.countryPickerTheme,
          config: widget.countryPickerConfig,
          pickerMode: widget.pickerMode,
          enabled: widget.enabled,
          showFlag: widget.showFlag,
          searchEnabled: widget.searchEnabled,
          onChanged: (country) {
            setState(() {
              _country = country;
              _state = null;
              _city = null;
            });
            _emit();
          },
        ),
        SizedBox(height: widget.spacing),
        StateDropdownField(
          countryIso2: _country?.alpha2Code,
          initialStateId: widget.initialStateId,
          style: _styleFor(override: widget.stateFieldStyle, label: widget.stateLabel),
          pickerTheme: widget.geoPickerTheme,
          pickerConfig: widget.geoPickerConfig,
          pickerMode: widget.pickerMode,
          sortBy: widget.stateSortBy,
          enabled: widget.enabled,
          searchEnabled: widget.searchEnabled,
          showType: widget.showStateType,
          placeholder: widget.stateLabel,
          repository: widget.repository,
          onChanged: (state) {
            setState(() {
              _state = state;
              _city = null;
            });
            _emit();
          },
        ),
        SizedBox(height: widget.spacing),
        CityDropdownField(
          stateId: _state?.id,
          initialCityId: widget.initialCityId,
          style: _styleFor(override: widget.cityFieldStyle, label: widget.cityLabel),
          pickerTheme: widget.geoPickerTheme,
          pickerConfig: widget.geoPickerConfig,
          pickerMode: widget.pickerMode,
          sortBy: widget.citySortBy,
          enabled: widget.enabled,
          searchEnabled: widget.searchEnabled,
          showCoordinates: widget.showCityCoordinates,
          placeholder: widget.cityLabel,
          repository: widget.repository,
          onChanged: (city) {
            setState(() => _city = city);
            _emit();
          },
        ),
      ],
    );
  }
}
