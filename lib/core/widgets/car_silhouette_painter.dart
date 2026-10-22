import 'dart:ui';

import 'package:flutter/rendering.dart';

import '../theme/app_colors.dart';

/// An original side-profile outline drawn as a vector, so onboarding can
/// recolour it live and the reveal can trace it as a wireframe.
///
/// [trace] draws the outline on (0 → 1); [fill] fades the paint in (0 → 1).
class CarSilhouettePainter extends CustomPainter {
  const CarSilhouettePainter({
    required this.color,
    this.trace = 1,
    this.fill = 1,
  });

  final Color color;
  final double trace;
  final double fill;

  static const double aspect = 0.36;

  static Path body(Size s) {
    final double w = s.width;
    final double h = s.width * aspect;
    Offset p(double x, double y) => Offset(x * w, y * h / aspect);
    final Radius arch = Radius.circular(w * 0.095);
    return Path()
      ..moveTo(p(0.03, 0.27).dx, p(0.03, 0.27).dy)
      ..lineTo(p(0.005, 0.225).dx, p(0.005, 0.225).dy)
      ..quadraticBezierTo(
        p(0.0, 0.19).dx,
        p(0.0, 0.19).dy,
        p(0.05, 0.175).dx,
        p(0.05, 0.175).dy,
      )
      ..quadraticBezierTo(
        p(0.25, 0.155).dx,
        p(0.25, 0.155).dy,
        p(0.39, 0.135).dx,
        p(0.39, 0.135).dy,
      )
      ..quadraticBezierTo(
        p(0.49, 0.07).dx,
        p(0.49, 0.07).dy,
        p(0.58, 0.068).dx,
        p(0.58, 0.068).dy,
      )
      ..quadraticBezierTo(
        p(0.70, 0.07).dx,
        p(0.70, 0.07).dy,
        p(0.88, 0.125).dx,
        p(0.88, 0.125).dy,
      )
      ..lineTo(p(0.99, 0.13).dx, p(0.99, 0.13).dy)
      ..lineTo(p(1.0, 0.19).dx, p(1.0, 0.19).dy)
      ..lineTo(p(0.97, 0.27).dx, p(0.97, 0.27).dy)
      ..lineTo(p(0.885, 0.27).dx, p(0.885, 0.27).dy)
      ..arcToPoint(p(0.695, 0.27), radius: arch, clockwise: false)
      ..lineTo(p(0.285, 0.27).dx, p(0.285, 0.27).dy)
      ..arcToPoint(p(0.095, 0.27), radius: arch, clockwise: false)
      ..close();
  }

  static Path glass(Size s) {
    final double w = s.width;
    Offset p(double x, double y) => Offset(x * w, y * w);
    return Path()
      ..moveTo(p(0.43, 0.13).dx, p(0.43, 0.13).dy)
      ..quadraticBezierTo(
        p(0.51, 0.08).dx,
        p(0.51, 0.08).dy,
        p(0.59, 0.079).dx,
        p(0.59, 0.079).dy,
      )
      ..quadraticBezierTo(
        p(0.68, 0.08).dx,
        p(0.68, 0.08).dy,
        p(0.79, 0.12).dx,
        p(0.79, 0.12).dy,
      )
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Path outline = body(size);
    final double w = size.width;
    if (fill > 0) {
      final Rect bounds = outline.getBounds();
      final Paint body = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.lerp(
              color,
              AppColors.plasmaWhite,
              0.35,
            )!.withValues(alpha: fill),
            color.withValues(alpha: fill),
            Color.lerp(
              color,
              AppColors.voidBlack,
              0.55,
            )!.withValues(alpha: fill),
          ],
          stops: const <double>[0, 0.45, 1],
        ).createShader(bounds);
      canvas.drawPath(outline, body);
      canvas.drawPath(
        glass(size),
        Paint()..color = AppColors.voidBlack.withValues(alpha: 0.85 * fill),
      );
    }
    final Paint wire = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..color = AppColors.ionBlue;
    final Path traced = trace >= 1 ? outline : _partial(outline, trace);
    canvas.drawPath(traced, wire);
    if (trace >= 1) {
      canvas.drawPath(glass(size), wire..strokeWidth = 1);
    }
    final Paint tyre = Paint()..color = AppColors.voidBlack;
    final Paint rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = AppColors.ionBlue.withValues(alpha: trace.clamp(0, 1));
    for (final double x in <double>[0.19, 0.79]) {
      final Offset c = Offset(x * w, 0.27 * w);
      canvas.drawCircle(c, 0.078 * w, tyre);
      canvas.drawCircle(c, 0.078 * w, rim);
      canvas.drawCircle(c, 0.045 * w, rim);
    }
  }

  static Path _partial(Path source, double t) {
    final Path out = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      out.addPath(metric.extractPath(0, metric.length * t), Offset.zero);
    }
    return out;
  }

  @override
  bool shouldRepaint(CarSilhouettePainter old) =>
      old.color != color || old.trace != trace || old.fill != fill;
}
