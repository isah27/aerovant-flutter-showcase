import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../../../core/theme/app_colors.dart';

/// Horizontal light streaks that get longer and faster with speed.
class SpeedStreaksPainter extends CustomPainter {
  const SpeedStreaksPainter({required this.intensity, required this.phase});

  final double intensity;
  final double phase;

  static const int _count = 46;

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0) {
      return;
    }
    final math.Random rng = math.Random(7);
    final Paint p = Paint()..strokeCap = StrokeCap.round;
    for (int i = 0; i < _count; i++) {
      final double y = size.height * (0.1 + 0.8 * rng.nextDouble());
      final double speed = 0.6 + rng.nextDouble();
      final double length = (40 + 220 * rng.nextDouble()) * intensity;
      final double x =
          size.width -
          ((rng.nextDouble() + phase * speed * 6) % 1.0) *
              (size.width + length);
      final bool amber = i % 5 == 0;
      p
        ..strokeWidth = amber ? 2 : 1.2
        ..color = (amber ? AppColors.afterburnAmber : AppColors.plasmaWhite)
            .withValues(alpha: (0.15 + 0.5 * rng.nextDouble()) * intensity);
      canvas.drawLine(Offset(x, y), Offset(x + length, y), p);
    }
  }

  @override
  bool shouldRepaint(SpeedStreaksPainter old) =>
      old.intensity != intensity || old.phase != phase;
}
