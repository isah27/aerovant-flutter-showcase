import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.voidBlack,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.ionBlue,
      onPrimary: AppColors.plasmaWhite,
      secondary: AppColors.afterburnAmber,
      surface: AppColors.graphite,
      onSurface: AppColors.plasmaWhite,
    ),
    textTheme: const TextTheme(
      displaySmall: AppTypography.display,
      headlineSmall: AppTypography.headline,
      titleMedium: AppTypography.title,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.label,
      bodySmall: AppTypography.caption,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.ionBlue,
      selectionColor: AppColors.ionGlow,
    ),
    splashFactory: InkRipple.splashFactory,
  );
}
