import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/rendering.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../driver/domain/entities/route_preference.dart';

/// A small glowing map line: a wave for the coast, a grid zig-zag for the
/// city and a closed loop for the track.
class RoutePainter extends CustomPainter {
  const RoutePainter({required this.preference});

  final RoutePreference preference;

  Path _path(Size s) {
    final Path p = Path();
    switch (preference) {
      case RoutePreference.coastal:
        p.moveTo(0, s.height * 0.8);
        for (double x = 0; x <= s.width; x += 2) {
          final double t = x / s.width;
          p.lineTo(
            x,
            s.height * (0.75 - 0.45 * t) +
                math.sin(t * math.pi * 3) * s.height * 0.12,
          );
        }
      case RoutePreference.city:
        final double u = s.width / 5;
        p
          ..moveTo(0, s.height * 0.85)
          ..lineTo(u, s.height * 0.85)
          ..lineTo(u, s.height * 0.55)
          ..lineTo(u * 2.5, s.height * 0.55)
          ..lineTo(u * 2.5, s.height * 0.3)
          ..lineTo(u * 4, s.height * 0.3)
          ..lineTo(u * 4, s.height * 0.12)
          ..lineTo(s.width, s.height * 0.12);
      case RoutePreference.track:
        p.addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(4, s.height * 0.2, s.width - 8, s.height * 0.6),
            Radius.circular(s.height * 0.3),
          ),
        );
    }
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = _path(size);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..color = AppColors.ionGlow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = AppColors.ionBlue,
    );
    final PathMetric metric = path.computeMetrics().first;
    final Tangent? end = metric.getTangentForOffset(metric.length * 0.98);
    if (end != null) {
      canvas.drawCircle(
        end.position,
        4,
        Paint()..color = AppColors.afterburnAmber,
      );
    }
  }

  @override
  bool shouldRepaint(RoutePainter old) => old.preference != preference;
}
