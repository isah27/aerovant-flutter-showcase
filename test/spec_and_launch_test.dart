import 'package:aerovant/features/garage/domain/entities/car_build.dart';
import 'package:aerovant/features/garage/domain/entities/interior.dart';
import 'package:aerovant/features/garage/domain/entities/launch_mode.dart';
import 'package:aerovant/features/garage/domain/entities/trim.dart';
import 'package:aerovant/features/garage/domain/entities/wheel_set.dart';
import 'package:aerovant/features/garage/domain/services/spec_calculator.dart';
import 'package:aerovant/features/garage/presentation/controllers/garage_controller.dart';
import 'package:aerovant/features/launch/domain/services/launch_math.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Zenith in Afterburn launches in the headline 1.9 s', () {
    expect(
      SpecCalculator.launchSeconds(const CarBuild(), LaunchMode.afterburn),
      1.9,
    );
    expect(
      SpecCalculator.launchSeconds(const CarBuild(), LaunchMode.glide),
      3.1,
    );
  });

  test('the spec readout changes with trim, wheels and interior', () {
    expect(SpecCalculator.forBuild(const CarBuild()).rangeKm, 540);
    expect(
      SpecCalculator.forBuild(
        const CarBuild(
          trim: Trim.touring,
          wheels: WheelSet.forgedBronze,
          interior: Interior.carbonIon,
        ),
      ).rangeKm,
      640 + 12 + 5,
    );
  });

  test('garage controller recomputes the spec and skips no-op updates', () {
    final GarageController g = GarageController();
    int notified = 0;
    g.addListener(() => notified++);
    g.selectTrim(Trim.zenith);
    expect(notified, 0);
    g.selectTrim(Trim.apex);
    expect(notified, 1);
    expect(g.spec.zeroTo100Seconds, 2.2);
  });

  test('speed runs 0 to 100 and haptic ticks are quarters', () {
    expect(LaunchMath.speedAt(0), 0);
    expect(LaunchMath.speedAt(1), 100);
    expect(LaunchMath.speedAt(0.5), greaterThan(50));
    expect(LaunchMath.tickFor(0.24), 0);
    expect(LaunchMath.tickFor(0.25), 1);
    expect(LaunchMath.tickFor(1), 4);
  });
}
