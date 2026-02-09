import 'package:countrify/src/icons/countrify_icons.dart';
import 'package:flutter/material.dart';
import 'package:countrify/src/models/country.dart';
import 'package:countrify/src/widgets/country_picker.dart';

/// {@template modal_country_picker}
/// A modal country picker that can be easily shown as a bottom sheet or dialog
/// {@endtemplate}
class ModalCountryPicker {
  /// Show country picker as bottom sheet
  static Future<Country?> showBottomSheet({
    required BuildContext context,
    CountryPickerTheme? theme,
    CountryPickerConfig? config,
    Country? initialCountry,
    String? title,
    bool showTitle = true,
    TextStyle? titleStyle,
    Widget? closeButton,
    bool showCloseButton = true,
    VoidCallback? onClose,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
  }) async {
    return showModalBottomSheet<Country>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (context) => _CountryPickerModal(
        theme: theme,
        config: config ?? const CountryPickerConfig(),
        initialCountry: initialCountry,
        title: title,
        showTitle: showTitle,
        titleStyle: titleStyle,
        closeButton: closeButton,
        showCloseButton: showCloseButton,
        onClose: onClose ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  /// Show country picker as dialog
  static Future<Country?> showDialogPicker({
    required BuildContext context,
    CountryPickerTheme? theme,
    CountryPickerConfig? config,
    Country? initialCountry,
    String? title,
    bool showTitle = true,
    TextStyle? titleStyle,
    Widget? closeButton,
    bool showCloseButton = true,
    VoidCallback? onClose,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = false,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) async {
    return showDialog<Country>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      builder: (BuildContext context) => Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          color: theme?.backgroundColor ?? Colors.white,
          child: _CountryPickerModal(
            theme: theme,
            config: config ?? const CountryPickerConfig(),
            initialCountry: initialCountry,
            title: title,
            showTitle: showTitle,
            titleStyle: titleStyle,
            closeButton: closeButton,
            showCloseButton: showCloseButton,
            onClose: onClose ?? () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }

  /// Show country picker as full screen
  static Future<Country?> showFullScreen({
    required BuildContext context,
    CountryPickerTheme? theme,
    CountryPickerConfig? config,
    Country? initialCountry,
    String? title,
    bool showTitle = true,
    TextStyle? titleStyle,
    Widget? closeButton,
    bool showCloseButton = true,
    VoidCallback? onClose,
    bool maintainState = true,
    bool fullscreenDialog = false,
    RouteSettings? routeSettings,
  }) async {
    return Navigator.of(context).push<Country>(
      MaterialPageRoute(
        builder: (context) => _CountryPickerFullScreen(
          theme: theme,
          config: config ?? const CountryPickerConfig(),
          initialCountry: initialCountry,
          title: title,
          showTitle: showTitle,
          titleStyle: titleStyle,
          closeButton: closeButton,
          showCloseButton: showCloseButton,
          onClose: onClose ?? () => Navigator.of(context).pop(),
        ),
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        settings: routeSettings,
      ),
    );
  }
}

/// Internal widget for modal country picker
class _CountryPickerModal extends StatefulWidget {
  const _CountryPickerModal({
    required this.theme,
    required this.config,
    required this.initialCountry,
    required this.title,
    required this.showTitle,
    required this.titleStyle,
    required this.closeButton,
    required this.showCloseButton,
    required this.onClose,
  });

  final CountryPickerTheme? theme;
  final CountryPickerConfig config;
  final Country? initialCountry;
  final String? title;
  final bool showTitle;
  final TextStyle? titleStyle;
  final Widget? closeButton;
  final bool showCloseButton;
  final VoidCallback onClose;

  @override
  State<_CountryPickerModal> createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<_CountryPickerModal> {
  void _onCountrySelected(Country country) {
    Navigator.of(context).pop(country);
  }

  @override
  Widget build(BuildContext context) {
    return CountryPicker(
      onCountrySelected: _onCountrySelected,
      theme: widget.theme,
      config: widget.config,
      initialCountry: widget.initialCountry,
      title: widget.title,
      showTitle: widget.showTitle,
      titleStyle: widget.titleStyle,
      closeButton: widget.closeButton,
      showCloseButton: widget.showCloseButton,
      onClose: widget.onClose,
    );
  }
}

/// Internal widget for full screen country picker
class _CountryPickerFullScreen extends StatefulWidget {
  const _CountryPickerFullScreen({
    required this.theme,
    required this.config,
    required this.initialCountry,
    required this.title,
    required this.showTitle,
    required this.titleStyle,
    required this.closeButton,
    required this.showCloseButton,
    required this.onClose,
  });

  final CountryPickerTheme? theme;
  final CountryPickerConfig config;
  final Country? initialCountry;
  final String? title;
  final bool showTitle;
  final TextStyle? titleStyle;
  final Widget? closeButton;
  final bool showCloseButton;
  final VoidCallback onClose;

  @override
  State<_CountryPickerFullScreen> createState() =>
      _CountryPickerFullScreenState();
}

class _CountryPickerFullScreenState extends State<_CountryPickerFullScreen> {
  void _onCountrySelected(Country country) {
    Navigator.of(context).pop(country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme?.backgroundColor ?? Colors.white,
      appBar: AppBar(
        title: Text(widget.title ?? 'Select Country'),
        backgroundColor: widget.theme?.backgroundColor ?? Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: widget.showCloseButton
            ? (widget.closeButton ??
                IconButton(
                  icon: Icon(widget.theme?.closeIcon ?? CountrifyIcons.x),
                  onPressed: widget.onClose,
                ))
            : null,
      ),
      body: CountryPicker(
        onCountrySelected: _onCountrySelected,
        theme: widget.theme,
        config: widget.config,
        initialCountry: widget.initialCountry,
        showTitle: false, // Title is shown in AppBar
        showCloseButton: false, // Close button is shown in AppBar
      ),
    );
  }
}
