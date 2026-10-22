import 'package:aerovant/features/driver/domain/entities/driver_profile.dart';
import 'package:aerovant/features/driver/domain/entities/driving_style.dart';
import 'package:aerovant/features/driver/domain/entities/route_preference.dart';
import 'package:aerovant/features/garage/domain/entities/car_build.dart';
import 'package:aerovant/features/garage/domain/entities/paint_finish.dart';
import 'package:aerovant/features/home/data/repositories/local_route_repository.dart';
import 'package:aerovant/features/home/domain/entities/home_briefing.dart';
import 'package:aerovant/features/home/domain/services/home_personaliser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const LocalRouteRepository routes = LocalRouteRepository();

  HomeBriefing brief(DriverProfile profile, {int hour = 20}) =>
      HomePersonaliser.brief(
        profile: profile,
        build: CarBuild(paint: profile.paint),
        routes: routes.routes(),
        hour: hour,
      );

  test('greets by name and names the chosen paint', () {
    final HomeBriefing b = brief(
      const DriverProfile(name: 'Isah', paint: PaintFinish.ionBlue),
    );
    expect(b.greeting, 'Evening, Isah.');
    expect(b.headline, 'Your Ion Blue AEROVANT is ready.');
  });

  test('greeting follows the time of day', () {
    expect(HomePersonaliser.greetingFor(8), 'Morning');
    expect(HomePersonaliser.greetingFor(13), 'Afternoon');
    expect(HomePersonaliser.greetingFor(19), 'Evening');
    expect(HomePersonaliser.greetingFor(2), 'Evening');
  });

  test('the answered route preference is suggested first', () {
    for (final RoutePreference pref in RoutePreference.values) {
      final HomeBriefing b = brief(DriverProfile(route: pref));
      expect(b.routes.first.preference, pref);
      expect(b.routes, hasLength(3));
    }
  });

  test('badge shows the driving style and its launch mode', () {
    expect(
      brief(const DriverProfile(style: DrivingStyle.unhinged)).badge,
      'UNHINGED · AFTERBURN LAUNCH',
    );
    expect(brief(DriverProfile.skipped).badge, 'SPIRITED · SPORT LAUNCH');
  });
}
