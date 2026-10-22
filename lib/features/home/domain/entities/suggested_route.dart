import 'package:flutter/foundation.dart';

import '../../../driver/domain/entities/route_preference.dart';

@immutable
class SuggestedRoute {
  const SuggestedRoute({
    required this.id,
    required this.title,
    required this.detail,
    required this.preference,
  });

  final String id;
  final String title;
  final String detail;
  final RoutePreference preference;
}
