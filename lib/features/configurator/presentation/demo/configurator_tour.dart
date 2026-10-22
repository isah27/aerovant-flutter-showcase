import 'package:flutter/widgets.dart';

import '../../../garage/domain/entities/interior.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../../../garage/domain/entities/trim.dart';
import '../../../garage/domain/entities/wheel_set.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';

/// Recording-only walk through the configurator: tilt, paints, wheels,
/// trims and cabin, then back home.
class ConfiguratorTour {
  ConfiguratorTour({
    required this.garage,
    required this.tilt,
    required this.onDone,
    required this.isActive,
  });

  final GarageController garage;
  final ValueNotifier<Offset> tilt;
  final VoidCallback onDone;
  final bool Function() isActive;

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  Future<void> _sweep(double from, double to, int steps) async {
    for (int i = 0; i <= steps; i++) {
      if (!isActive()) {
        return;
      }
      final double x =
          from + (to - from) * Curves.easeInOut.transform(i / steps);
      tilt.value = Offset(x, x * -0.3);
      await _wait(16);
    }
  }

  Future<void> run() async {
    await _wait(1000);
    await _sweep(0, 1, 40);
    await _sweep(1, -1, 70);
    await _sweep(-1, 0, 40);
    final List<VoidCallback> steps = <VoidCallback>[
      () => garage.selectPaint(PaintFinish.afterburnAmber),
      () => garage.selectWheels(WheelSet.forgedBronze),
      () => garage.selectPaint(PaintFinish.ionBlue),
      () => garage.selectTrim(Trim.apex),
      () => garage.selectTrim(Trim.zenith),
      () => garage.selectInterior(Interior.carbonIon),
    ];
    for (final VoidCallback step in steps) {
      await _wait(950);
      if (!isActive()) {
        return;
      }
      step();
    }
    await _wait(1400);
    if (isActive()) {
      onDone();
    }
  }
}
