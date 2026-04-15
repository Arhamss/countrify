import 'package:flutter/foundation.dart';

/// {@template country_state}
/// A model representing a state, province, region or other top-level
/// administrative subdivision of a country.
/// {@endtemplate}
@immutable
class CountryState {
  /// {@macro country_state}
  const CountryState({
    required this.id,
    required this.name,
    required this.countryIso2,
    this.iso2,
    this.type,
    this.latitude,
    this.longitude,
  });

  /// Builds a [CountryState] from a JSON map produced by the bundled
  /// `assets/geo/states/{ISO2}.json` files.
  factory CountryState.fromJson(
    Map<String, dynamic> json, {
    required String countryIso2,
  }) {
    return CountryState(
      id: json['id'] as int,
      name: json['name'] as String,
      countryIso2: countryIso2,
      iso2: json['iso2'] as String?,
      type: json['type'] as String?,
      latitude: (json['lat'] as num?)?.toDouble(),
      longitude: (json['lng'] as num?)?.toDouble(),
    );
  }

  /// Numeric identifier from the upstream dataset. Stable across releases and
  /// used as the lookup key for [CountryState] cities.
  final int id;

  /// Display name in English (e.g. `Sindh`, `California`).
  final String name;

  /// ISO 3166-1 alpha-2 code of the parent country (e.g. `PK`, `US`).
  final String countryIso2;

  /// ISO 3166-2 subdivision code without the country prefix (e.g. `SD`,
  /// `CA`). May be null for some subdivisions.
  final String? iso2;

  /// Subdivision type as classified by the upstream dataset (e.g. `province`,
  /// `state`, `region`, `district`).
  final String? type;

  /// Latitude of the geographic centroid in decimal degrees.
  final double? latitude;

  /// Longitude of the geographic centroid in decimal degrees.
  final double? longitude;

  /// ISO 3166-2 full code (e.g. `PK-SD`) when [iso2] is available.
  String? get iso3166Code => iso2 == null ? null : '$countryIso2-$iso2';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryState && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CountryState(id: $id, name: $name, country: $countryIso2)';
}
