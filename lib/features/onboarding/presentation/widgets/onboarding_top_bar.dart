import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/brand_wordmark.dart';
import '../../domain/entities/onboarding_step.dart';
import '../controllers/onboarding_controller.dart';
import 'step_progress.dart';

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({required this.onSkip, super.key});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final int index = context.select<OnboardingController, int>(
      (OnboardingController c) => c.step.index,
    );
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const BrandWordmark(),
              const Spacer(),
              TextButton(
                onPressed: onSkip,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.plasmaWhite,
                ),
                child: const AppText(
                  AppStrings.skip,
                  variant: AppTextVariant.title,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: <Widget>[
              AppText(
                '0${index + 1} / 0${OnboardingStep.values.length}',
                variant: AppTextVariant.label,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: StepProgress(index: index)),
            ],
          ),
        ],
      ),
    );
  }
}
