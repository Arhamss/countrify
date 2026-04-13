// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final sourceFile = File('lib/src/l10n/country_name_l10n.dart');
  final content = sourceFile.readAsStringSync();

  // Extract supportedLocales list
  final supportedLocalesMatch = RegExp(
    r"static const supportedLocales = <String>\[\s*([\s\S]*?)\s*\];",
  ).firstMatch(content);
  if (supportedLocalesMatch == null) {
    print('ERROR: Could not find supportedLocales');
    exit(1);
  }
  final localeListRaw = supportedLocalesMatch.group(1)!;
  final locales = RegExp(r"'([^']+)'")
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
      r"static const _" + escapedLocale + r"\s*=\s*<String,\s*String>\{([\s\S]*?)\};",
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

    final fileContent = StringBuffer();
    fileContent.writeln('// Generated — do not edit by hand.');
    fileContent.writeln('/// Country name translations for $locale.');
    fileContent.writeln('const Map<String, String> $varName = <String, String>{$mapEntries};');

    File('${localeDir.path}/$fileName').writeAsStringSync(fileContent.toString());
    print('  Created locales/$fileName');
  }

  // Generate the new registry file
  final registry = StringBuffer();
  registry.writeln('// GENERATED FILE — DO NOT EDIT BY HAND.');
  registry.writeln('// ignore_for_file: lines_longer_than_80_chars');
  registry.writeln();

  // Imports
  for (final locale in locales) {
    registry.writeln("import 'package:countrify/src/l10n/locales/l10n_$locale.dart';");
  }
  registry.writeln();

  registry.writeln('/// Provides country name translations keyed by');
  registry.writeln('/// ISO 639-1 language code and ISO 3166-1 alpha-2 country code.');
  registry.writeln('///');
  registry.writeln('/// All data is compile-time constant and has zero runtime dependencies.');
  registry.writeln('class CountryNameL10n {');
  registry.writeln('  CountryNameL10n._();');
  registry.writeln();

  // supportedLocales
  registry.writeln('  /// All supported language / locale codes.');
  registry.writeln('  static const supportedLocales = <String>[');
  for (final locale in locales) {
    registry.writeln("    '$locale',");
  }
  registry.writeln('  ];');
  registry.writeln();

  // Cache
  registry.writeln('  static final _cache = <String, Map<String, String>>{};');
  registry.writeln();

  // getTranslations
  registry.writeln('  /// Returns the full translation map for a given locale code.');
  registry.writeln('  /// Falls back to English for unknown locales. Results are cached.');
  registry.writeln('  static Map<String, String> getTranslations(String locale) {');
  registry.writeln('    return _cache[locale] ??= _loadLocale(locale);');
  registry.writeln('  }');
  registry.writeln();

  // getLocalizedName (preserve existing API)
  registry.writeln('  /// Returns the localized country name, or `null` if unavailable.');
  registry.writeln('  static String? getLocalizedName(String alpha2Code, String languageCode) {');
  registry.writeln('    if (!supportedLocales.contains(languageCode)) return null;');
  registry.writeln('    return getTranslations(languageCode)[alpha2Code];');
  registry.writeln('  }');
  registry.writeln();

  // getTranslationsForLocale (preserve existing API)
  registry.writeln('  /// Returns the full translation map for a given language code,');
  registry.writeln('  /// or `null` if the locale is not supported.');
  registry.writeln('  static Map<String, String>? getTranslationsForLocale(String languageCode) {');
  registry.writeln('    if (!supportedLocales.contains(languageCode)) return null;');
  registry.writeln('    return getTranslations(languageCode);');
  registry.writeln('  }');
  registry.writeln();

  // _loadLocale
  registry.writeln('  static Map<String, String> _loadLocale(String locale) {');
  registry.writeln('    return switch (locale) {');
  for (final locale in locales) {
    final varSuffix = _localeToVarSuffix(locale);
    registry.writeln("      '$locale' => l10n$varSuffix,");
  }
  registry.writeln("      _ => l10nEn, // fallback to English");
  registry.writeln('    };');
  registry.writeln('  }');

  registry.writeln('}');

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
