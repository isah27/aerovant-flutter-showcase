import 'package:flutter/widgets.dart';

import '../../../garage/domain/entities/launch_mode.dart';
import '../controllers/launch_controller.dart';

/// Recording-only: hold, launch in the default mode, then once more in
/// Afterburn, then back home.
class LaunchTour {
  LaunchTour({
    required this.launch,
    required this.press,
    required this.release,
    required this.again,
    required this.onDone,
    required this.isActive,
  });

  final LaunchController launch;
  final VoidCallback press;
  final VoidCallback release;
  final VoidCallback again;
  final VoidCallback onDone;
  final bool Function() isActive;

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  Future<void> run() async {
    await _wait(1000);
    if (launch.mode != LaunchMode.afterburn) {
      launch.selectMode(LaunchMode.afterburn);
      await _wait(800);
    }
    if (!isActive()) {
      return;
    }
    press();
    await _wait(1600);
    release();
    await _wait(3300);
    if (isActive()) {
      onDone();
    }
  }
}
