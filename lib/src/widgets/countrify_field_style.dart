import 'package:flutter/material.dart';

/// {@template countrify_field_style}
/// A single, modular style class for the Countrify field widgets.
///
/// Exposes **every** [InputDecoration] property plus field-specific extras
/// (`phoneTextStyle`, `dialCodeTextStyle`, `cursorColor`, etc.) so users can
/// configure all styling in one place.
///
/// ```dart
/// PhoneNumberField(
///   style: CountrifyFieldStyle.defaultStyle().copyWith(
///     fillColor: Colors.grey.shade50,
///     labelText: 'Phone',
///     focusedBorder: OutlineInputBorder(
///       borderSide: BorderSide(color: Colors.teal, width: 2),
///     ),
///   ),
/// )
/// ```
/// {@endtemplate}
class CountrifyFieldStyle {
  /// {@macro countrify_field_style}
  const CountrifyFieldStyle({
    // ── InputDecoration properties ────────────────────────────────────
    this.icon,
    this.iconColor,
    this.label,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelBehavior,
    this.floatingLabelAlignment,
    this.helper,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.hintText,
    this.hintStyle,
    this.hintTextDirection,
    this.hintMaxLines,
    this.hintFadeDuration,
    this.error,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.isCollapsed,
    this.isDense,
    this.contentPadding,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefix,
    this.prefixText,
    this.prefixStyle,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.suffixIconColor,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.enabled,
    this.semanticCounterText,
    this.alignLabelWithHint,
    this.constraints,
    // ── Field-specific extras ─────────────────────────────────────────
    this.phoneTextStyle,
    this.dialCodeTextStyle,
    this.selectedCountryTextStyle,
    this.dividerColor,
    this.prefixPadding,
    this.cursorColor,
    this.fieldBorderRadius,
  });

  /// Default light style that matches the current built-in field defaults.
  factory CountrifyFieldStyle.defaultStyle() {
    const radius = BorderRadius.all(Radius.circular(12));
    return CountrifyFieldStyle(
      fieldBorderRadius: radius,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      counterText: '',
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      border: const OutlineInputBorder(borderRadius: radius),
      prefixIconConstraints: const BoxConstraints(),
      cursorColor: Colors.blue,
      dividerColor: const Color(0xFFE0E0E0),
      prefixPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  /// Dark style for dark-themed apps.
  factory CountrifyFieldStyle.darkStyle() {
    const radius = BorderRadius.all(Radius.circular(12));
    return const CountrifyFieldStyle(
      fieldBorderRadius: radius,
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      counterText: '',
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Color(0xFF404040)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Color(0xFF303030)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: radius),
      hintStyle: TextStyle(color: Colors.white60),
      labelStyle: TextStyle(color: Colors.white70),
      phoneTextStyle: TextStyle(color: Colors.white),
      dialCodeTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      selectedCountryTextStyle: TextStyle(color: Colors.white),
      prefixIconConstraints: BoxConstraints(),
      cursorColor: Color(0xFF64B5F6),
      dividerColor: Color(0xFF404040),
      prefixPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  /// Clean outline style with a customizable border color.
  factory CountrifyFieldStyle.outlineStyle({
    Color borderColor = const Color(0xFFBDBDBD),
    Color focusedBorderColor = Colors.blue,
    double borderWidth = 1,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) {
    return CountrifyFieldStyle(
      fieldBorderRadius: borderRadius,
      filled: false,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      counterText: '',
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor, width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: focusedBorderColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: borderColor.withValues(alpha: 0.4),
          width: borderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: borderRadius),
      prefixIconConstraints: const BoxConstraints(),
      dividerColor: borderColor,
      prefixPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  /// Filled style with no visible border.
  factory CountrifyFieldStyle.filledStyle({
    Color fillColor = const Color(0xFFF5F5F5),
    Color focusedBorderColor = Colors.blue,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) {
    return CountrifyFieldStyle(
      fieldBorderRadius: borderRadius,
      filled: true,
      fillColor: fillColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      counterText: '',
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: focusedBorderColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      prefixIconConstraints: const BoxConstraints(),
      dividerColor: const Color(0xFFE0E0E0),
      prefixPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // InputDecoration properties
  // ═══════════════════════════════════════════════════════════════════════

  /// An icon to show before the input field and outside of the decoration's
  /// container.
  final Widget? icon;

  /// The color of the [icon].
  final Color? iconColor;

  /// A widget to use for the label. Takes priority over [labelText].
  final Widget? label;

  /// Text that describes the input field.
  final String? labelText;

  /// The style to use for [labelText].
  final TextStyle? labelStyle;

  /// The style to use for [labelText] when the label is above (floating).
  final TextStyle? floatingLabelStyle;

  /// Defines how the floating label should behave.
  final FloatingLabelBehavior? floatingLabelBehavior;

  /// Defines where the floating label should be displayed.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// A widget to show below the input field. Takes priority over [helperText].
  final Widget? helper;

  /// Text that provides context about the input field's value.
  final String? helperText;

  /// The style to use for [helperText].
  final TextStyle? helperStyle;

  /// The maximum number of lines the [helperText] can occupy.
  final int? helperMaxLines;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// The style to use for [hintText].
  final TextStyle? hintStyle;

  /// The direction to use for the [hintText].
  final TextDirection? hintTextDirection;

  /// The maximum number of lines the [hintText] can occupy.
  final int? hintMaxLines;

  /// The duration of the [hintText] fade-in and fade-out animations.
  final Duration? hintFadeDuration;

  /// A widget to show below the input in place of [errorText].
  final Widget? error;

  /// Text that appears below the input when the field is in an error state.
  final String? errorText;

  /// The style to use for [errorText].
  final TextStyle? errorStyle;

  /// The maximum number of lines the [errorText] can occupy.
  final int? errorMaxLines;

  /// Whether the decoration is the same size as the input field (collapsed).
  final bool? isCollapsed;

  /// Whether the input field is part of a dense form (uses less vertical
  /// space).
  final bool? isDense;

  /// The padding for the input decoration's container.
  final EdgeInsetsGeometry? contentPadding;

  /// An icon that appears before the [prefix] or [prefixText] and before the
  /// editable part of the text field.
  final Widget? prefixIcon;

  /// The constraints for the [prefixIcon].
  final BoxConstraints? prefixIconConstraints;

  /// A widget to place before the input area inline.
  final Widget? prefix;

  /// Text to place before the input area inline.
  final String? prefixText;

  /// The style to use for [prefixText].
  final TextStyle? prefixStyle;

  /// The color of the [prefixIcon].
  final Color? prefixIconColor;

  /// An icon that appears after the editable part of the text field and after
  /// the [suffix] or [suffixText].
  final Widget? suffixIcon;

  /// The constraints for the [suffixIcon].
  final BoxConstraints? suffixIconConstraints;

  /// A widget to place after the input area inline.
  final Widget? suffix;

  /// Text to place after the input area inline.
  final String? suffixText;

  /// The style to use for [suffixText].
  final TextStyle? suffixStyle;

  /// The color of the [suffixIcon].
  final Color? suffixIconColor;

  /// A widget to place below the line as a character count.
  final Widget? counter;

  /// Text to place below the line as a character count.
  final String? counterText;

  /// The style to use for [counterText].
  final TextStyle? counterStyle;

  /// If true the decoration's container is filled with [fillColor].
  final bool? filled;

  /// The base fill color of the decoration's container.
  final Color? fillColor;

  /// The color to blend with the decoration's [fillColor] when the container
  /// has input focus.
  final Color? focusColor;

  /// The color to blend with the decoration's [fillColor] when the container
  /// is hovered.
  final Color? hoverColor;

  /// The border to display when the field has an error and does not have
  /// focus.
  final InputBorder? errorBorder;

  /// The border to display when the field has input focus.
  final InputBorder? focusedBorder;

  /// The border to display when the field has input focus and has an error.
  final InputBorder? focusedErrorBorder;

  /// The border to display when the field is disabled.
  final InputBorder? disabledBorder;

  /// The border to display when the field is enabled and not showing an error.
  final InputBorder? enabledBorder;

  /// The shape of the border to draw around the decoration's container.
  final InputBorder? border;

  /// Whether the input field is enabled.
  final bool? enabled;

  /// A semantic label for the [counterText].
  final String? semanticCounterText;

  /// Whether to align the label with the hint.
  final bool? alignLabelWithHint;

  /// Defines minimum and maximum sizes for the [InputDecorator].
  final BoxConstraints? constraints;

  // ═══════════════════════════════════════════════════════════════════════
  // Field-specific extras
  // ═══════════════════════════════════════════════════════════════════════

  /// Text style for the phone number input.
  final TextStyle? phoneTextStyle;

  /// Text style for the dial code displayed in the prefix.
  final TextStyle? dialCodeTextStyle;

  /// Text style for the selected country name displayed in the dropdown field.
  final TextStyle? selectedCountryTextStyle;

  /// Color of the vertical divider between the country prefix and the phone
  /// number input.
  final Color? dividerColor;

  /// Padding around the prefix area (flag + dial code + dropdown icon).
  final EdgeInsetsGeometry? prefixPadding;

  /// Cursor color for the text field.
  final Color? cursorColor;

  /// Convenience border radius. When set and individual border properties
  /// (e.g. [enabledBorder]) are null, [toInputDecoration] automatically
  /// generates [OutlineInputBorder] instances using this radius.
  final BorderRadius? fieldBorderRadius;

  // ═══════════════════════════════════════════════════════════════════════
  // toInputDecoration
  // ═══════════════════════════════════════════════════════════════════════

  /// Builds an [InputDecoration] from the flat properties.
  ///
  /// [prefixIconOverride] lets widgets inject their own prefix widget (e.g.
  /// the flag + dial code row). When non-null it takes priority over
  /// [prefixIcon].
  ///
  /// [suffixIconOverride] works the same way for suffixes (e.g. the dropdown
  /// arrow).
  InputDecoration toInputDecoration({
    Widget? prefixIconOverride,
    Widget? suffixIconOverride,
  }) {
    final radius = fieldBorderRadius ?? BorderRadius.circular(12);

    return InputDecoration(
      icon: icon,
      iconColor: iconColor,
      label: label,
      labelText: labelText,
      labelStyle: labelStyle,
      floatingLabelStyle: floatingLabelStyle,
      floatingLabelBehavior: floatingLabelBehavior,
      floatingLabelAlignment: floatingLabelAlignment,
      helper: helper,
      helperText: helperText,
      helperStyle: helperStyle,
      helperMaxLines: helperMaxLines,
      hintText: hintText,
      hintStyle: hintStyle,
      hintTextDirection: hintTextDirection,
      hintMaxLines: hintMaxLines,
      hintFadeDuration: hintFadeDuration,
      error: error,
      errorText: errorText,
      errorStyle: errorStyle,
      errorMaxLines: errorMaxLines,
      isCollapsed: isCollapsed ?? false,
      isDense: isDense,
      contentPadding: contentPadding,
      prefixIcon: prefixIconOverride ?? prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      prefix: prefix,
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      prefixIconColor: prefixIconColor,
      suffixIcon: suffixIconOverride ?? suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      suffix: suffix,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      suffixIconColor: suffixIconColor,
      counter: counter,
      counterText: counterText,
      counterStyle: counterStyle,
      filled: filled,
      fillColor: fillColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      errorBorder: errorBorder ??
          OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.red),
          ),
      focusedBorder: focusedBorder ??
          OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
      focusedErrorBorder: focusedErrorBorder ??
          OutlineInputBorder(
            borderRadius: radius,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
      disabledBorder: disabledBorder ??
          OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
      enabledBorder: enabledBorder ??
          OutlineInputBorder(
            borderRadius: radius,
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
      border: border ?? OutlineInputBorder(borderRadius: radius),
      enabled: enabled ?? true,
      semanticCounterText: semanticCounterText,
      alignLabelWithHint: alignLabelWithHint,
      constraints: constraints,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // copyWith
  // ═══════════════════════════════════════════════════════════════════════

  /// Returns a copy of this style with the given fields replaced.
  CountrifyFieldStyle copyWith({
    // InputDecoration
    Widget? icon,
    Color? iconColor,
    Widget? label,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    Widget? helper,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    Duration? hintFadeDuration,
    Widget? error,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    bool? isCollapsed,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? prefix,
    String? prefixText,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? disabledBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    bool? enabled,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
    // Field-specific
    TextStyle? phoneTextStyle,
    TextStyle? dialCodeTextStyle,
    TextStyle? selectedCountryTextStyle,
    Color? dividerColor,
    EdgeInsetsGeometry? prefixPadding,
    Color? cursorColor,
    BorderRadius? fieldBorderRadius,
  }) {
    return CountrifyFieldStyle(
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      label: label ?? this.label,
      labelText: labelText ?? this.labelText,
      labelStyle: labelStyle ?? this.labelStyle,
      floatingLabelStyle: floatingLabelStyle ?? this.floatingLabelStyle,
      floatingLabelBehavior:
          floatingLabelBehavior ?? this.floatingLabelBehavior,
      floatingLabelAlignment:
          floatingLabelAlignment ?? this.floatingLabelAlignment,
      helper: helper ?? this.helper,
      helperText: helperText ?? this.helperText,
      helperStyle: helperStyle ?? this.helperStyle,
      helperMaxLines: helperMaxLines ?? this.helperMaxLines,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      hintTextDirection: hintTextDirection ?? this.hintTextDirection,
      hintMaxLines: hintMaxLines ?? this.hintMaxLines,
      hintFadeDuration: hintFadeDuration ?? this.hintFadeDuration,
      error: error ?? this.error,
      errorText: errorText ?? this.errorText,
      errorStyle: errorStyle ?? this.errorStyle,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      isDense: isDense ?? this.isDense,
      contentPadding: contentPadding ?? this.contentPadding,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      prefixIconConstraints:
          prefixIconConstraints ?? this.prefixIconConstraints,
      prefix: prefix ?? this.prefix,
      prefixText: prefixText ?? this.prefixText,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      suffixIconConstraints:
          suffixIconConstraints ?? this.suffixIconConstraints,
      suffix: suffix ?? this.suffix,
      suffixText: suffixText ?? this.suffixText,
      suffixStyle: suffixStyle ?? this.suffixStyle,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
      counter: counter ?? this.counter,
      counterText: counterText ?? this.counterText,
      counterStyle: counterStyle ?? this.counterStyle,
      filled: filled ?? this.filled,
      fillColor: fillColor ?? this.fillColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      border: border ?? this.border,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      disabledBorder: disabledBorder ?? this.disabledBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      enabled: enabled ?? this.enabled,
      semanticCounterText: semanticCounterText ?? this.semanticCounterText,
      alignLabelWithHint: alignLabelWithHint ?? this.alignLabelWithHint,
      constraints: constraints ?? this.constraints,
      phoneTextStyle: phoneTextStyle ?? this.phoneTextStyle,
      dialCodeTextStyle: dialCodeTextStyle ?? this.dialCodeTextStyle,
      selectedCountryTextStyle:
          selectedCountryTextStyle ?? this.selectedCountryTextStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      prefixPadding: prefixPadding ?? this.prefixPadding,
      cursorColor: cursorColor ?? this.cursorColor,
      fieldBorderRadius: fieldBorderRadius ?? this.fieldBorderRadius,
    );
  }
}
