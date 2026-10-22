import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

/// The name "engraved" letter by letter as [progress] goes 0 → 1.
class NamePlate extends StatelessWidget {
  const NamePlate({required this.name, required this.progress, super.key});

  final String name;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final String upper = name.toUpperCase();
    final int shown = (upper.length * progress).ceil().clamp(0, upper.length);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadii.chip,
        border: Border.all(color: AppColors.hairline),
        gradient: const LinearGradient(
          colors: <Color>[AppColors.graphiteHigh, AppColors.graphite],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AppText(
              upper,
              variant: AppTextVariant.wordmark,
              color: AppColors.transparent,
            ),
            AppText(
              upper.substring(0, shown),
              variant: AppTextVariant.wordmark,
            ),
          ],
        ),
      ),
    );
  }
}
