/// How the country picker is displayed.
///
/// Used by `PhoneNumberField`, `CountryDropdownField`, and `PhoneCodePicker`
/// to determine the picker presentation style.
///
/// Example:
/// ```dart
/// PhoneNumberField(
///   pickerMode: CountryPickerMode.bottomSheet,
/// )
/// ```
enum CountryPickerMode {
  /// Show a compact scrollable dropdown anchored below the field.
  dropdown,

  /// Show picker as a modal bottom sheet.
  bottomSheet,

  /// Show picker as a dialog.
  dialog,

  /// Show picker as a full screen page.
  fullScreen,

  /// Disable picker opening entirely.
  none,
}
