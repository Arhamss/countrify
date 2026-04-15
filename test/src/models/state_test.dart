import 'package:countrify/src/models/state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CountryState', () {
    test('fromJson parses a fully-populated record', () {
      final state = CountryState.fromJson(
        const {
          'id': 3172,
          'name': 'Azad Kashmir',
          'iso2': 'JK',
          'type': 'administered area',
          'lat': 33.84412,
          'lng': 73.796642,
        },
        countryIso2: 'PK',
      );
      expect(state.id, 3172);
      expect(state.name, 'Azad Kashmir');
      expect(state.countryIso2, 'PK');
      expect(state.iso2, 'JK');
      expect(state.type, 'administered area');
      expect(state.latitude, 33.84412);
      expect(state.longitude, 73.796642);
    });

    test('fromJson tolerates missing optional fields', () {
      final state = CountryState.fromJson(
        const {'id': 1, 'name': 'Nowhere'},
        countryIso2: 'ZZ',
      );
      expect(state.iso2, isNull);
      expect(state.type, isNull);
      expect(state.latitude, isNull);
      expect(state.longitude, isNull);
    });

    test('iso3166Code combines countryIso2 and iso2', () {
      final state = CountryState.fromJson(
        const {'id': 1, 'name': 'Sindh', 'iso2': 'SD'},
        countryIso2: 'PK',
      );
      expect(state.iso3166Code, 'PK-SD');
    });

    test('iso3166Code returns null when iso2 is missing', () {
      final state = CountryState.fromJson(
        const {'id': 1, 'name': 'Unknown'},
        countryIso2: 'PK',
      );
      expect(state.iso3166Code, isNull);
    });

    test('equality is based on id alone', () {
      const a = CountryState(id: 1, name: 'A', countryIso2: 'PK');
      const b = CountryState(id: 1, name: 'Different', countryIso2: 'US');
      const c = CountryState(id: 2, name: 'A', countryIso2: 'PK');
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString contains id, name, and country', () {
      const state = CountryState(id: 42, name: 'Punjab', countryIso2: 'PK');
      final rendered = state.toString();
      expect(rendered, contains('42'));
      expect(rendered, contains('Punjab'));
      expect(rendered, contains('PK'));
    });
  });
}
