import 'package:flutter/foundation.dart';

import '../../../driver/domain/entities/driver_profile.dart';
import '../../../driver/domain/entities/driving_style.dart';
import '../../../driver/domain/entities/route_preference.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../../domain/entities/onboarding_step.dart';

/// Holds the answers while the three questions are on screen.
/// Widgets select single fields, so a chip tap never rebuilds the swatches.
class OnboardingController extends ChangeNotifier {
  OnboardingStep _step = OnboardingStep.name;
  String _name = '';
  RoutePreference _route = DriverProfile.skipped.route;
  DrivingStyle _style = DriverProfile.skipped.style;
  PaintFinish _paint = DriverProfile.skipped.paint;

  OnboardingStep get step => _step;
  String get name => _name;
  RoutePreference get route => _route;
  DrivingStyle get style => _style;
  PaintFinish get paint => _paint;

  /// The profile the answers add up to. A blank name becomes "Driver".
  DriverProfile get profile => DriverProfile(
    name: DriverProfile.cleanName(_name),
    route: _route,
    style: _style,
    paint: _paint,
  );

  void setName(String value) => _name = value;

  void selectRoute(RoutePreference value) {
    if (value == _route) {
      return;
    }
    _route = value;
    notifyListeners();
  }

  void selectStyle(DrivingStyle value) {
    if (value == _style) {
      return;
    }
    _style = value;
    notifyListeners();
  }

  void selectPaint(PaintFinish value) {
    if (value == _paint) {
      return;
    }
    _paint = value;
    notifyListeners();
  }

  /// Moves forward; returns false when already on the last step.
  bool next() {
    if (_step.isLast) {
      return false;
    }
    _step = OnboardingStep.values[_step.index + 1];
    notifyListeners();
    return true;
  }

  bool back() {
    if (_step == OnboardingStep.name) {
      return false;
    }
    _step = OnboardingStep.values[_step.index - 1];
    notifyListeners();
    return true;
  }
}
