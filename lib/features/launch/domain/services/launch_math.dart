import 'dart:math' as math;

/// The maths behind the launch screen, kept pure so it can be tested.
abstract final class LaunchMath {
  static const int ticks = 4;

  /// Speed in km/h at run progress [t] (0 → 1). An EV pulls hardest at the
  /// start, so the curve is steep early and eases into 100.
  static double speedAt(double t) {
    final double c = t.clamp(0.0, 1.0);
    return 100 * (1 - math.pow(1 - c, 1.7)).toDouble();
  }

  /// Which haptic tick (0..[ticks]) the hold ring has reached.
  static int tickFor(double holdProgress) =>
      (holdProgress.clamp(0.0, 1.0) * ticks).floor();

  /// Counter run time on screen, matching the result it shows.
  static Duration runDuration(double seconds) =>
      Duration(milliseconds: (seconds * 1000).round());
}
