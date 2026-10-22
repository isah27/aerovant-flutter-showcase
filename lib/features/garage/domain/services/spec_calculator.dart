import '../entities/car_build.dart';
import '../entities/launch_mode.dart';
import '../entities/spec_sheet.dart';

/// Pure functions, so the readout is easy to test and computed once per
/// change (in the controller), never inside build().
abstract final class SpecCalculator {
  /// Range loses half a kilometre per extra kilogram of interior.
  static SpecSheet forBuild(CarBuild build) {
    final int range =
        build.trim.rangeKm +
        build.wheels.rangeDeltaKm -
        (build.interior.massDeltaKg / 2).round();
    return SpecSheet(
      zeroTo100Seconds: build.trim.zeroTo100Seconds,
      rangeKm: range,
      topSpeedKmh: build.trim.topSpeedKmh,
      powerKw: build.trim.powerKw,
    );
  }

  static double launchSeconds(CarBuild build, LaunchMode mode) {
    final double raw = build.trim.zeroTo100Seconds + mode.offsetSeconds;
    return (raw * 10).round() / 10;
  }
}
