import 'dart:ui';

/// Turns a drag into a small, bounded tilt. Kept pure so it is testable.
abstract final class TiltMath {
  /// Pixels of drag for a full tilt.
  static const double travel = 160;
  static const double maxYaw = 0.22;
  static const double maxPitch = 0.08;

  static Offset applyDrag(Offset tilt, Offset delta) => Offset(
    (tilt.dx + delta.dx / travel).clamp(-1.0, 1.0),
    (tilt.dy + delta.dy / travel).clamp(-1.0, 1.0),
  );

  static double yaw(Offset tilt) => tilt.dx * maxYaw;
  static double pitch(Offset tilt) => -tilt.dy * maxPitch;

  /// Foreground and background move in opposite directions (parallax).
  static Offset carShift(Offset tilt) => Offset(tilt.dx * 14, tilt.dy * 6);
  static Offset glowShift(Offset tilt) => Offset(-tilt.dx * 36, -tilt.dy * 12);
}
