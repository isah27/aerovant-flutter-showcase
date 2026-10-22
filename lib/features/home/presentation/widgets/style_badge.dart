import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class StyleBadge extends StatelessWidget {
  const StyleBadge({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.scrim,
        borderRadius: AppRadii.pill,
        border: Border.all(color: AppColors.ionBlue),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs + 2,
        ),
        child: AppText(
          text,
          variant: AppTextVariant.label,
          color: AppColors.plasmaWhite,
        ),
      ),
    );
  }
}
