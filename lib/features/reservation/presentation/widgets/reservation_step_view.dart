import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../configurator/presentation/widgets/choice_pill.dart';
import '../../../garage/domain/entities/car_build.dart';
import '../../../garage/domain/entities/trim.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../../domain/entities/reservation_step.dart';

class ReservationStepView extends StatelessWidget {
  const ReservationStepView({required this.step, super.key});

  final ReservationStep step;

  @override
  Widget build(BuildContext context) {
    final CarBuild build = context.select<GarageController, CarBuild>(
      (GarageController c) => c.build,
    );
    return switch (step) {
      ReservationStep.trim => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AppText(
            AppStrings.chooseTrim,
            variant: AppTextVariant.headline,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: <Widget>[
              for (final Trim trim in Trim.values) ...<Widget>[
                if (trim.index > 0) const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: ChoicePill(
                    label: trim.label,
                    selected: trim == build.trim,
                    onTap: () =>
                        context.read<GarageController>().selectTrim(trim),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      ReservationStep.summary => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AppText(AppStrings.summary, variant: AppTextVariant.headline),
          const SizedBox(height: AppSpacing.md),
          AppText(
            '${build.trim.label} · ${build.paint.label} · ${build.wheels.label}',
            variant: AppTextVariant.title,
          ),
          const SizedBox(height: AppSpacing.xs),
          AppText(build.interior.label),
          const Divider(height: AppSpacing.xl, color: AppColors.hairline),
          const Row(
            children: <Widget>[
              Expanded(child: AppText(AppStrings.depositLine)),
              AppText(
                AppStrings.depositValue,
                variant: AppTextVariant.title,
                color: AppColors.afterburnAmber,
              ),
            ],
          ),
        ],
      ),
      ReservationStep.confirmed => const Column(
        children: <Widget>[
          Icon(Icons.check_circle_outline, color: AppColors.ionBlue, size: 56),
          SizedBox(height: AppSpacing.md),
          AppText(AppStrings.reserved, variant: AppTextVariant.headline),
          SizedBox(height: AppSpacing.xs),
          AppText(AppStrings.reservedBody),
        ],
      ),
    };
  }
}
