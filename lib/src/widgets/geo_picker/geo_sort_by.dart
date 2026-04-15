/// Sort order applied to the state list inside `StatePicker` and
/// `StateDropdownField`.
enum StateSortBy {
  /// Alphabetical by display name (default).
  name,

  /// Grouped by subdivision type (province, state, region) then by name.
  type,

  /// By numeric id from the upstream dataset (stable iteration order).
  id,
}

/// Sort order applied to the city list inside `CityPicker` and
/// `CityDropdownField`.
enum CitySortBy {
  /// Alphabetical by display name (default).
  name,

  /// By numeric id from the upstream dataset (stable iteration order).
  id,
}
