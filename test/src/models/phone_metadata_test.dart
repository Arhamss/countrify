import 'package:countrify/countrify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneMetadata', () {
    test('isValidLength returns true for valid length', () {
      const meta = PhoneMetadata(
          minLength: 10, maxLength: 10, exampleNumber: '2025551234');
      expect(meta.isValidLength('2025551234'), isTrue);
    });

    test('isValidLength returns false for too short', () {
      const meta = PhoneMetadata(minLength: 10, maxLength: 10);
      expect(meta.isValidLength('12345'), isFalse);
    });

    test('isValidLength returns false for empty string', () {
      const meta = PhoneMetadata(minLength: 10, maxLength: 10);
      expect(meta.isValidLength(''), isFalse);
    });

    test('isValidLength strips non-digit characters', () {
      const meta = PhoneMetadata(minLength: 10, maxLength: 10);
      expect(meta.isValidLength('(202) 555-1234'), isTrue);
    });

    test('isValidLength handles range', () {
      const meta = PhoneMetadata(minLength: 7, maxLength: 10);
      expect(meta.isValidLength('1234567'), isTrue);
      expect(meta.isValidLength('1234567890'), isTrue);
      expect(meta.isValidLength('123456'), isFalse);
    });
  });
}
