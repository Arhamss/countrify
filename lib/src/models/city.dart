import 'package:countrify/src/models/state.dart';
import 'package:flutter/foundation.dart';

/// {@template city}
/// A model representing a city or populated place within a [CountryState].
/// {@endtemplate}
@immutable
class City {
  /// {@macro city}
  const City({
    required this.id,
    required this.name,
    required this.stateId,
    this.latitude,
    this.longitude,
  });

  /// Builds a [City] from a JSON map produced by the bundled
  /// `assets/geo/cities/{stateId}.json` files.
  factory City.fromJson(Map<String, dynamic> json, {required int stateId}) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
      stateId: stateId,
      latitude: (json['lat'] as num?)?.toDouble(),
      longitude: (json['lng'] as num?)?.toDouble(),
    );
  }

  /// Numeric identifier from the upstream dataset. Stable across releases.
  final int id;

  /// Display name in English (e.g. `Karachi`, `San Francisco`).
  final String name;

  /// Identifier of the parent [CountryState].
  final int stateId;

  /// Latitude in decimal degrees.
  final double? latitude;

  /// Longitude in decimal degrees.
  final double? longitude;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'City(id: $id, name: $name, stateId: $stateId)';
}
