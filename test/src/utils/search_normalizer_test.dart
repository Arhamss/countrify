import 'package:countrify/src/utils/search_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchNormalizer.basic', () {
    test('trims surrounding whitespace', () {
      expect(SearchNormalizer.basic('  Paris  '), 'paris');
    });

    test('lower-cases all ASCII characters', () {
      expect(SearchNormalizer.basic('CALIFORNIA'), 'california');
    });

    test('leaves an empty string empty', () {
      expect(SearchNormalizer.basic(''), '');
      expect(SearchNormalizer.basic('   '), '');
    });

    test('does not fold diacritics', () {
      expect(SearchNormalizer.basic('São Paulo'), 'são paulo');
    });
  });

  group('SearchNormalizer.foldAccents', () {
    test('maps Latin-1 supplement characters to ASCII', () {
      expect(SearchNormalizer.foldAccents('São Paulo'), 'sao paulo');
      expect(SearchNormalizer.foldAccents('Zürich'), 'zurich');
      expect(SearchNormalizer.foldAccents('Köln'), 'koln');
      expect(SearchNormalizer.foldAccents('mañana'), 'manana');
      expect(SearchNormalizer.foldAccents('café'), 'cafe');
    });

    test('handles Latin Extended-A characters common in place names', () {
      expect(SearchNormalizer.foldAccents('Łódź'), 'lodz');
      expect(SearchNormalizer.foldAccents('Karlový Vary'), 'karlovy vary');
      expect(SearchNormalizer.foldAccents('Čačak'), 'cacak');
    });

    test('preserves characters outside the fold table', () {
      // CJK characters are passed through untouched.
      expect(SearchNormalizer.foldAccents('北京'), '北京');
    });

    test('lower-cases and trims as a superset of basic()', () {
      expect(SearchNormalizer.foldAccents('  SÃO Paulo  '), 'sao paulo');
    });

    test('empty input stays empty', () {
      expect(SearchNormalizer.foldAccents(''), '');
      expect(SearchNormalizer.foldAccents('   '), '');
    });
  });
}
