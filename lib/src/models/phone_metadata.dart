/// Lightweight phone number metadata for basic validation.
///
/// Provides minimum/maximum digit lengths and an optional example number
/// for hint text display. Zero external dependencies.
///
/// ```dart
/// const meta = PhoneMetadata(minLength: 10, maxLength: 10, exampleNumber: '2025551234');
/// print(meta.isValidLength('2025551234')); // true
/// print(meta.isValidLength('12345'));       // false
/// ```
class PhoneMetadata {
  /// Creates phone metadata with length constraints.
  const PhoneMetadata({
    required this.minLength,
    required this.maxLength,
    this.exampleNumber,
  });

  /// Minimum number of digits in a valid phone number.
  final int minLength;

  /// Maximum number of digits in a valid phone number.
  final int maxLength;

  /// An example phone number for this country (digits only, no country code).
  /// Used as hint text in `PhoneNumberField`.
  final String? exampleNumber;

  /// Returns true if [phoneNumber] has a valid number of digits.
  /// Non-digit characters are stripped before checking.
  bool isValidLength(String phoneNumber) {
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return digits.length >= minLength && digits.length <= maxLength;
  }
}
