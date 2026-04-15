import 'package:flutter/widgets.dart';

// ═══════════════════════════════════════════════════════════════════════
// Shared custom-painted SVG icons. Rendered with [CustomPaint] so the
// package can ship new default icons without adding a flutter_svg
// dependency. Each icon is scaled from a 24×24 source viewBox.
// ═══════════════════════════════════════════════════════════════════════

/// A filled circle with a checkmark cut out of it — the default "selected"
/// indicator in Countrify pickers.
///
/// Rendered via [CustomPaint] from a hand-converted SVG path so the package
/// stays font-only and adds no new dependencies. The icon scales to [size]
/// and takes its colour from [color].
class CountrifyCheckIcon extends StatelessWidget {
  /// Creates a tick icon rendered at the given [size] and [color].
  const CountrifyCheckIcon({
    super.key,
    this.size = 20,
    this.color,
  });

  /// Width and height of the square icon.
  final double size;

  /// Fill colour of the outer circle. Falls back to the ambient
  /// [DefaultTextStyle] colour when null.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolved =
        color ?? DefaultTextStyle.of(context).style.color ?? const Color(0xFF000000);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _CheckIconPainter(resolved),
      ),
    );
  }
}

class _CheckIconPainter extends CustomPainter {
  _CheckIconPainter(this.color);

  final Color color;

  // Source viewBox is 24x24.
  static const double _vb = 24;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _vb;
    canvas
      ..save()
      ..scale(scale);

    // Outer circle + checkmark cut-out via even-odd fill.
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..moveTo(12, 2)
      ..cubicTo(6.49, 2, 2, 6.49, 2, 12)
      ..cubicTo(2, 17.51, 6.49, 22, 12, 22)
      ..cubicTo(17.51, 22, 22, 17.51, 22, 12)
      ..cubicTo(22, 6.49, 17.51, 2, 12, 2)
      ..close()
      ..moveTo(16.78, 9.7)
      ..lineTo(11.11, 15.37)
      ..cubicTo(10.97, 15.51, 10.78, 15.59, 10.58, 15.59)
      ..cubicTo(10.38, 15.59, 10.19, 15.51, 10.05, 15.37)
      ..lineTo(7.22, 12.54)
      ..cubicTo(6.93, 12.25, 6.93, 11.77, 7.22, 11.48)
      ..cubicTo(7.51, 11.19, 7.99, 11.19, 8.28, 11.48)
      ..lineTo(10.58, 13.78)
      ..lineTo(15.72, 8.64)
      ..cubicTo(16.01, 8.35, 16.49, 8.35, 16.78, 8.64)
      ..cubicTo(17.07, 8.93, 17.07, 9.4, 16.78, 9.7)
      ..close();

    canvas
      ..drawPath(path, Paint()..color = color)
      ..restore();
  }

  @override
  bool shouldRepaint(_CheckIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ─────────────────────────────────────────────────────────────────────────

/// A chevron-down arrow — the default dropdown indicator used across
/// Countrify fields.
///
/// Rendered as a stroked V with rounded joins, faithful to the supplied
/// `down_arrow.svg`.
class CountrifyDownArrowIcon extends StatelessWidget {
  /// Creates a down-arrow icon rendered at the given [size] and [color].
  const CountrifyDownArrowIcon({
    super.key,
    this.size = 20,
    this.color,
  });

  /// Width and height of the square icon.
  final double size;

  /// Stroke colour. Falls back to the ambient [DefaultTextStyle] colour
  /// when null.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolved = color ??
        DefaultTextStyle.of(context).style.color ??
        const Color(0xFF000000);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _DownArrowPainter(resolved),
      ),
    );
  }
}

class _DownArrowPainter extends CustomPainter {
  _DownArrowPainter(this.color);

  final Color color;
  static const double _vb = 24;
  static const double _strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _vb;
    final path = Path()
      ..moveTo(6, 9)
      ..lineTo(12, 15)
      ..lineTo(18, 9);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas
      ..save()
      ..scale(scale)
      ..drawPath(path, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_DownArrowPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ─────────────────────────────────────────────────────────────────────────

/// A magnifying-glass icon — the default prefix in Countrify search bars.
///
/// Rendered as a stroked circle + diagonal handle, visually equivalent to
/// the supplied `search_icon.svg` ring-and-handle shape.
class CountrifySearchIcon extends StatelessWidget {
  /// Creates a search icon rendered at the given [size] and [color].
  const CountrifySearchIcon({
    super.key,
    this.size = 20,
    this.color,
  });

  /// Width and height of the square icon.
  final double size;

  /// Stroke colour. Falls back to the ambient [DefaultTextStyle] colour
  /// when null.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final resolved = color ??
        DefaultTextStyle.of(context).style.color ??
        const Color(0xFF000000);
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _SearchIconPainter(resolved),
      ),
    );
  }
}

class _SearchIconPainter extends CustomPainter {
  _SearchIconPainter(this.color);

  final Color color;
  static const double _vb = 24;
  static const double _strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / _vb;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas
      ..save()
      ..scale(scale)
      // Lens — outer radius 10.25, inner 8.75 from the source SVG, so the
      // centre stroke radius is 9.5 with a 1.5 stroke width.
      ..drawCircle(const Offset(11.5, 11.5), 9.5, paint)
      // Handle — diagonal from (20, 20) to (22.5, 22.5) with round caps.
      ..drawLine(const Offset(20, 20), const Offset(22.5, 22.5), paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_SearchIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
