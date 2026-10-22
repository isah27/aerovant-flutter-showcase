import 'package:aerovant/features/driver/domain/entities/driver_profile.dart';
import 'package:aerovant/features/driver/domain/entities/driving_style.dart';
import 'package:aerovant/features/driver/domain/entities/route_preference.dart';
import 'package:aerovant/features/garage/domain/entities/launch_mode.dart';
import 'package:aerovant/features/garage/domain/entities/paint_finish.dart';
import 'package:aerovant/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:aerovant/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('skip defaults are Driver, Spirited, Plasma White', () {
    expect(DriverProfile.skipped.name, 'Driver');
    expect(DriverProfile.skipped.style, DrivingStyle.spirited);
    expect(DriverProfile.skipped.paint, PaintFinish.plasmaWhite);
  });

  test('answers add up to the profile, names are cleaned', () {
    final OnboardingController c = OnboardingController()
      ..setName('  isah neziru ')
      ..selectRoute(RoutePreference.track)
      ..selectStyle(DrivingStyle.unhinged)
      ..selectPaint(PaintFinish.ionBlue);
    expect(
      c.profile,
      const DriverProfile(
        name: 'Isah',
        route: RoutePreference.track,
        style: DrivingStyle.unhinged,
        paint: PaintFinish.ionBlue,
      ),
    );
  });

  test('a blank name falls back to Driver', () {
    expect((OnboardingController()..setName('   ')).profile.name, 'Driver');
  });

  test('driving style sets the default launch mode', () {
    expect(DrivingStyle.serene.launchMode, LaunchMode.glide);
    expect(DrivingStyle.spirited.launchMode, LaunchMode.sport);
    expect(DrivingStyle.unhinged.launchMode, LaunchMode.afterburn);
  });

  test('steps move forward and back within bounds, notifying once each', () {
    final OnboardingController c = OnboardingController();
    int notified = 0;
    c.addListener(() => notified++);
    expect(c.back(), isFalse);
    expect(c.next(), isTrue);
    expect(c.next(), isTrue);
    expect(c.step, OnboardingStep.finish);
    expect(c.next(), isFalse);
    c.selectPaint(PaintFinish.plasmaWhite); // unchanged, no notify
    expect(notified, 2);
  });
}
