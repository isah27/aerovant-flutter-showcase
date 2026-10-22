import 'package:flutter/foundation.dart';

import 'suggested_route.dart';

/// Everything on the home screen that depends on the onboarding answers.
@immutable
class HomeBriefing {
  const HomeBriefing({
    required this.greeting,
    required this.headline,
    required this.badge,
    required this.routes,
  });

  final String greeting;
  final String headline;
  final String badge;

  /// The route that matches the driver's answer comes first.
  final List<SuggestedRoute> routes;

  @override
  bool operator ==(Object other) =>
      other is HomeBriefing &&
      other.greeting == greeting &&
      other.headline == headline &&
      other.badge == badge &&
      listEquals(other.routes, routes);

  @override
  int get hashCode =>
      Object.hash(greeting, headline, badge, Object.hashAll(routes));
}
