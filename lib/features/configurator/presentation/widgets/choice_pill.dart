import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class ChoicePill extends StatelessWidget {
  const ChoicePill({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.plasmaWhite : AppColors.glass,
          borderRadius: AppRadii.chip,
          border: Border.all(
            color: selected ? AppColors.plasmaWhite : AppColors.hairline,
          ),
        ),
        child: AppText(
          label,
          variant: AppTextVariant.title,
          color: selected ? AppColors.voidBlack : AppColors.plasmaWhite,
          maxLines: 1,
        ),
      ),
    );
  }
}
