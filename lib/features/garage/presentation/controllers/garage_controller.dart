import 'package:flutter/foundation.dart';

import '../../domain/entities/car_build.dart';
import '../../domain/entities/interior.dart';
import '../../domain/entities/paint_finish.dart';
import '../../domain/entities/spec_sheet.dart';
import '../../domain/entities/trim.dart';
import '../../domain/entities/wheel_set.dart';
import '../../domain/services/spec_calculator.dart';

/// The user's car, shared app-wide: onboarding sets the paint, the
/// configurator changes everything, and home shows the result.
class GarageController extends ChangeNotifier {
  GarageController({CarBuild initial = const CarBuild()})
    : _build = initial,
      _spec = SpecCalculator.forBuild(initial);

  CarBuild _build;
  SpecSheet _spec;

  CarBuild get build => _build;
  SpecSheet get spec => _spec;

  void selectPaint(PaintFinish paint) => _update(_build.copyWith(paint: paint));
  void selectWheels(WheelSet wheels) =>
      _update(_build.copyWith(wheels: wheels));
  void selectInterior(Interior interior) =>
      _update(_build.copyWith(interior: interior));
  void selectTrim(Trim trim) => _update(_build.copyWith(trim: trim));

  void _update(CarBuild next) {
    if (next == _build) {
      return;
    }
    _build = next;
    _spec = SpecCalculator.forBuild(next);
    notifyListeners();
  }
}
