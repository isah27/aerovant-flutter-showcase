import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class BuildChip extends StatelessWidget {
  const BuildChip({required this.label, this.dot, super.key});

  final String label;
  final Color? dot;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: AppRadii.chip,
        border: Border.all(color: AppColors.hairline),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (dot != null) ...<Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
                child: const SizedBox(width: 10, height: 10),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            AppText(
              label,
              variant: AppTextVariant.caption,
              color: AppColors.plasmaWhite,
            ),
          ],
        ),
      ),
    );
  }
}
