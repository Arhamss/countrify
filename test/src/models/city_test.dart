import 'package:countrify/src/models/city.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('City', () {
    test('fromJson parses a fully-populated record', () {
      final city = City.fromJson(
        const {
          'id': 52,
          'name': 'Ashkāsham',
          'lat': 36.68333,
          'lng': 71.53333,
        },
        stateId: 3901,
      );
      expect(city.id, 52);
      expect(city.name, 'Ashkāsham');
      expect(city.stateId, 3901);
      expect(city.latitude, 36.68333);
      expect(city.longitude, 71.53333);
    });

    test('fromJson tolerates missing coordinates', () {
      final city = City.fromJson(
        const {'id': 1, 'name': 'Unknown'},
        stateId: 1,
      );
      expect(city.latitude, isNull);
      expect(city.longitude, isNull);
    });

    test('equality is based on id alone', () {
      const a = City(id: 100, name: 'Lahore', stateId: 1);
      const b = City(id: 100, name: 'Different', stateId: 2);
      const c = City(id: 101, name: 'Lahore', stateId: 1);
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('toString contains id, name, and stateId', () {
      const city = City(id: 7, name: 'Karachi', stateId: 3176);
      final rendered = city.toString();
      expect(rendered, contains('7'));
      expect(rendered, contains('Karachi'));
      expect(rendered, contains('3176'));
    });
  });
}
