import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// A wide geometric display face (Michroma), used sparingly, over a neutral
/// sans (Inter). Telemetry numbers use tabular figures so they never jitter.
abstract final class AppTypography {
  static const String _display = 'Michroma';
  static const String _sans = 'Inter';
  static const List<FontFeature> _tabular = <FontFeature>[
    FontFeature.tabularFigures(),
  ];

  static const TextStyle display = TextStyle(
    fontFamily: _display,
    fontSize: 26,
    height: 1.25,
    letterSpacing: 1.2,
    color: AppColors.plasmaWhite,
  );
  static const TextStyle headline = TextStyle(
    fontFamily: _sans,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.3,
    color: AppColors.plasmaWhite,
  );
  static const TextStyle title = TextStyle(
    fontFamily: _sans,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.plasmaWhite,
  );
  static const TextStyle body = TextStyle(
    fontFamily: _sans,
    fontSize: 14,
    height: 1.45,
    color: AppColors.steel,
  );
  static const TextStyle label = TextStyle(
    fontFamily: _sans,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.2,
    color: AppColors.ionBlue,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: _sans,
    fontSize: 12,
    letterSpacing: 0.2,
    color: AppColors.steel,
  );
  static const TextStyle telemetry = TextStyle(
    fontFamily: _display,
    fontSize: 64,
    height: 1,
    color: AppColors.plasmaWhite,
    fontFeatures: _tabular,
  );
  static const TextStyle stat = TextStyle(
    fontFamily: _display,
    fontSize: 18,
    height: 1.1,
    color: AppColors.plasmaWhite,
    fontFeatures: _tabular,
  );
  static const TextStyle wordmark = TextStyle(
    fontFamily: _display,
    fontSize: 15,
    letterSpacing: 6,
    color: AppColors.plasmaWhite,
  );
}
