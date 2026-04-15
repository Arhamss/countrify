// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final sourceFile = File('lib/src/l10n/country_name_l10n.dart');
  final content = sourceFile.readAsStringSync();

  // Extract supportedLocales list
  final supportedLocalesMatch = RegExp(
    r'static const supportedLocales = <String>\[\s*([\s\S]*?)\s*\];',
  ).firstMatch(content);
  if (supportedLocalesMatch == null) {
    print('ERROR: Could not find supportedLocales');
    exit(1);
  }
  final localeListRaw = supportedLocalesMatch.group(1)!;
  final locales = RegExp("'([^']+)'")
      .allMatches(localeListRaw)
      .map((m) => m.group(1)!)
      .toList();
  print('Found ${locales.length} locales');

  // Extract each locale block: static const _XX = <String, String>{...};
  final localeDir = Directory('lib/src/l10n/locales');
  if (!localeDir.existsSync()) {
    localeDir.createSync(recursive: true);
  }

  for (final locale in locales) {
    // Build regex to match the static const block
    final escapedLocale = RegExp.escape(locale);
    final pattern = RegExp(
      'static const _' +
          escapedLocale +
          r'\s*=\s*<String,\s*String>\{([\s\S]*?)\};',
    );
    final match = pattern.firstMatch(content);
    if (match == null) {
      print('WARNING: Could not find block for locale: $locale');
      continue;
    }
    final mapEntries = match.group(1)!;

    // Convert locale code to variable name: pt_BR -> PtBr
    final varSuffix = _localeToVarSuffix(locale);
    final varName = 'l10n$varSuffix';
    final fileName = 'l10n_$locale.dart';

    final fileContent = StringBuffer()
      ..writeln('// Generated — do not edit by hand.')
      ..writeln('/// Country name translations for $locale.')
      ..writeln(
          'const Map<String, String> $varName = <String, String>{$mapEntries};');

    File('${localeDir.path}/$fileName')
        .writeAsStringSync(fileContent.toString());
    print('  Created locales/$fileName');
  }

  // Generate the new registry file
  final registry = StringBuffer()
    ..writeln('// GENERATED FILE — DO NOT EDIT BY HAND.')
    ..writeln('// ignore_for_file: lines_longer_than_80_chars')
    ..writeln();

  // Imports
  for (final locale in locales) {
    registry.writeln(
        "import 'package:countrify/src/l10n/locales/l10n_$locale.dart';");
  }
  registry
    ..writeln()
    ..writeln('/// Provides country name translations keyed by')
    ..writeln(
        '/// ISO 639-1 language code and ISO 3166-1 alpha-2 country code.')
    ..writeln('///')
    ..writeln(
        '/// All data is compile-time constant and has zero runtime dependencies.')
    ..writeln('class CountryNameL10n {')
    ..writeln('  CountryNameL10n._();')
    ..writeln()

    // supportedLocales
    ..writeln('  /// All supported language / locale codes.')
    ..writeln('  static const supportedLocales = <String>[');
  for (final locale in locales) {
    registry.writeln("    '$locale',");
  }
  registry
    ..writeln('  ];')
    ..writeln()

    // Cache
    ..writeln('  static final _cache = <String, Map<String, String>>{};')
    ..writeln()

    // getTranslations
    ..writeln('  /// Returns the full translation map for a given locale code.')
    ..writeln(
        '  /// Falls back to English for unknown locales. Results are cached.')
    ..writeln('  static Map<String, String> getTranslations(String locale) {')
    ..writeln('    return _cache[locale] ??= _loadLocale(locale);')
    ..writeln('  }')
    ..writeln()

    // getLocalizedName (preserve existing API)
    ..writeln(
        '  /// Returns the localized country name, or `null` if unavailable.')
    ..writeln(
        '  static String? getLocalizedName(String alpha2Code, String languageCode) {')
    ..writeln('    if (!supportedLocales.contains(languageCode)) return null;')
    ..writeln('    return getTranslations(languageCode)[alpha2Code];')
    ..writeln('  }')
    ..writeln()

    // getTranslationsForLocale (preserve existing API)
    ..writeln(
        '  /// Returns the full translation map for a given language code,')
    ..writeln('  /// or `null` if the locale is not supported.')
    ..writeln(
        '  static Map<String, String>? getTranslationsForLocale(String languageCode) {')
    ..writeln('    if (!supportedLocales.contains(languageCode)) return null;')
    ..writeln('    return getTranslations(languageCode);')
    ..writeln('  }')
    ..writeln()

    // _loadLocale
    ..writeln('  static Map<String, String> _loadLocale(String locale) {')
    ..writeln('    return switch (locale) {');
  for (final locale in locales) {
    final varSuffix = _localeToVarSuffix(locale);
    registry.writeln("      '$locale' => l10n$varSuffix,");
  }
  registry
    ..writeln('      _ => l10nEn, // fallback to English')
    ..writeln('    };')
    ..writeln('  }')
    ..writeln('}');

  sourceFile.writeAsStringSync(registry.toString());
  print('\nRewrote country_name_l10n.dart as lazy registry');
  print('Done!');
}

/// Converts a locale code to a PascalCase variable suffix.
/// e.g. 'en' -> 'En', 'pt_BR' -> 'PtBr', 'zh' -> 'Zh'
String _localeToVarSuffix(String locale) {
  return locale
      .split(RegExp(r'[_\-]'))
      .map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase())
      .join();
}
