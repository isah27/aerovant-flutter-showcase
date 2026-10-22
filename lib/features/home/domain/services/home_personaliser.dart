import '../../../driver/domain/entities/driver_profile.dart';
import '../../../garage/domain/entities/car_build.dart';
import '../entities/home_briefing.dart';
import '../entities/suggested_route.dart';

/// Pure personalisation logic: answers in, home screen copy out.
abstract final class HomePersonaliser {
  static String greetingFor(int hour) {
    if (hour < 5 || hour >= 17) {
      return 'Evening';
    }
    return hour < 12 ? 'Morning' : 'Afternoon';
  }

  static HomeBriefing brief({
    required DriverProfile profile,
    required CarBuild build,
    required List<SuggestedRoute> routes,
    required int hour,
  }) {
    final List<SuggestedRoute> ordered = <SuggestedRoute>[
      ...routes.where((SuggestedRoute r) => r.preference == profile.route),
      ...routes.where((SuggestedRoute r) => r.preference != profile.route),
    ];
    return HomeBriefing(
      greeting: '${greetingFor(hour)}, ${profile.name}.',
      headline: 'Your ${build.paint.label} AEROVANT is ready.',
      badge:
          '${profile.style.label.toUpperCase()} · '
          '${profile.style.launchMode.label.toUpperCase()} LAUNCH',
      routes: List<SuggestedRoute>.unmodifiable(ordered),
    );
  }
}
