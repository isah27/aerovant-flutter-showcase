import 'package:flutter/foundation.dart';

import '../../../garage/domain/entities/paint_finish.dart';
import 'driving_style.dart';
import 'route_preference.dart';

@immutable
class DriverProfile {
  const DriverProfile({
    this.name = defaultName,
    this.route = RoutePreference.coastal,
    this.style = DrivingStyle.spirited,
    this.paint = PaintFinish.plasmaWhite,
  });

  /// What Skip gives you: "Driver", Spirited, Plasma White.
  static const DriverProfile skipped = DriverProfile();
  static const String defaultName = 'Driver';

  final String name;
  final RoutePreference route;
  final DrivingStyle style;
  final PaintFinish paint;

  /// Blank or whitespace names fall back to "Driver".
  static String cleanName(String raw) {
    final String trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return defaultName;
    }
    final String first = trimmed.split(RegExp(r'\s+')).first;
    final String capped = first.length > 14 ? first.substring(0, 14) : first;
    return capped[0].toUpperCase() + capped.substring(1);
  }

  DriverProfile copyWith({
    String? name,
    RoutePreference? route,
    DrivingStyle? style,
    PaintFinish? paint,
  }) => DriverProfile(
    name: name ?? this.name,
    route: route ?? this.route,
    style: style ?? this.style,
    paint: paint ?? this.paint,
  );

  @override
  bool operator ==(Object other) =>
      other is DriverProfile &&
      other.name == name &&
      other.route == route &&
      other.style == style &&
      other.paint == paint;

  @override
  int get hashCode => Object.hash(name, route, style, paint);
}
