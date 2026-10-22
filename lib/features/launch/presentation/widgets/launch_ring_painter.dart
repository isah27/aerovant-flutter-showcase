import 'dart:math' as math;

import 'package:flutter/rendering.dart';

import '../../../../core/theme/app_colors.dart';

/// The countdown ring: ion blue track, amber arc that fills while you hold,
/// with a notch at each haptic tick.
class LaunchRingPainter extends CustomPainter {
  const LaunchRingPainter({required this.progress, required this.live});

  final double progress;
  final bool live;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.width / 2 - 10;
    final Rect rect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = AppColors.hairline,
    );
    for (int i = 0; i < 4; i++) {
      final double a = -math.pi / 2 + i * math.pi / 2;
      canvas.drawCircle(
        c + Offset(math.cos(a), math.sin(a)) * r,
        3,
        Paint()..color = AppColors.ionBlue,
      );
    }
    final double sweep = (live ? 1 : progress) * math.pi * 2;
    if (sweep <= 0) {
      return;
    }
    final Paint arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..color = AppColors.afterburnAmber;
    canvas.drawArc(rect, -math.pi / 2, sweep, false, arc);
    if (live) {
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..color = AppColors.afterburnAmber.withValues(alpha: 0.18)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );
    }
  }

  @override
  bool shouldRepaint(LaunchRingPainter old) =>
      old.progress != progress || old.live != live;
}
