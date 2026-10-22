import 'package:flutter/foundation.dart';

import '../../../garage/domain/entities/car_build.dart';
import '../../../garage/domain/entities/launch_mode.dart';
import '../../../garage/domain/services/spec_calculator.dart';
import '../../domain/entities/launch_phase.dart';

/// Phase and mode only. The per-frame values (ring, speed) live in
/// AnimationControllers in the view, so the provider never notifies
/// 60 times a second.
class LaunchController extends ChangeNotifier {
  LaunchController({required this.build, required LaunchMode initialMode})
    : _mode = initialMode;

  final CarBuild build;
  LaunchMode _mode;
  LaunchPhase _phase = LaunchPhase.idle;

  LaunchMode get mode => _mode;
  LaunchPhase get phase => _phase;
  double get seconds => SpecCalculator.launchSeconds(build, _mode);

  void selectMode(LaunchMode mode) {
    if (mode == _mode || _phase == LaunchPhase.running) {
      return;
    }
    _mode = mode;
    _phase = LaunchPhase.idle;
    notifyListeners();
  }

  void arm() => _set(LaunchPhase.arming);
  void cancel() {
    if (_phase == LaunchPhase.arming) {
      _set(LaunchPhase.idle);
    }
  }

  void start() => _set(LaunchPhase.running);
  void finish() => _set(LaunchPhase.finished);
  void reset() => _set(LaunchPhase.idle);

  void _set(LaunchPhase next) {
    if (next == _phase) {
      return;
    }
    _phase = next;
    notifyListeners();
  }
}
