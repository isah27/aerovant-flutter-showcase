import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_durations.dart';
import '../../../driver/domain/entities/driving_style.dart';
import '../../../driver/domain/entities/route_preference.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../controllers/onboarding_controller.dart';

/// Hands-free answers for screen recordings (only when `DemoTour.enabled`):
/// types a name, picks Track, swipes to Unhinged and tries the paints.
class OnboardingTour {
  OnboardingTour({
    required this.controller,
    required this.nameField,
    required this.styles,
    required this.onFinish,
    required this.isActive,
  });

  final OnboardingController controller;
  final TextEditingController nameField;
  final PageController styles;
  final VoidCallback onFinish;
  final bool Function() isActive;

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  Future<void> run() async {
    await _wait(1300);
    for (final String ch in 'Isah'.split('')) {
      if (!isActive()) {
        return;
      }
      nameField.text += ch;
      controller.setName(nameField.text);
      await _wait(220);
    }
    await _wait(700);
    controller.selectRoute(RoutePreference.track);
    await _wait(1200);
    if (!isActive()) {
      return;
    }
    controller.next();
    await _wait(1300);
    for (final DrivingStyle style in <DrivingStyle>[DrivingStyle.unhinged]) {
      if (!isActive() || !styles.hasClients) {
        return;
      }
      await styles.animateToPage(
        style.index,
        duration: AppDurations.route,
        curve: Curves.easeInOutCubic,
      );
      await _wait(1300);
    }
    controller.next();
    await _wait(1500);
    for (final PaintFinish paint in <PaintFinish>[
      PaintFinish.afterburnAmber,
      PaintFinish.ionBlue,
    ]) {
      if (!isActive()) {
        return;
      }
      controller.selectPaint(paint);
      await _wait(1000);
    }
    await _wait(700);
    if (isActive()) {
      onFinish();
    }
  }
}
