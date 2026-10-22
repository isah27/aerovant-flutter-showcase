import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/onboarding_step.dart';

/// Three segments that fill like a fuel gauge as you answer.
class StepProgress extends StatelessWidget {
  const StepProgress({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < OnboardingStep.values.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: AppSpacing.xxs),
          Expanded(
            child: AnimatedContainer(
              duration: AppDurations.medium,
              height: AppSizes.progressHeight,
              color: i <= index ? AppColors.ionBlue : AppColors.hairline,
            ),
          ),
        ],
      ],
    );
  }
}
