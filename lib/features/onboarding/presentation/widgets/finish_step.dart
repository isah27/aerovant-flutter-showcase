import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../controllers/onboarding_controller.dart';
import 'live_silhouette.dart';
import 'paint_swatch.dart';

class FinishStep extends StatelessWidget {
  const FinishStep({super.key});

  @override
  Widget build(BuildContext context) {
    final PaintFinish paint = context.select<OnboardingController, PaintFinish>(
      (OnboardingController c) => c.paint,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: AppSpacing.xl),
        const AppText(AppStrings.finishTitle, variant: AppTextVariant.headline),
        const SizedBox(height: AppSpacing.xs),
        const AppText(AppStrings.finishHint),
        const Spacer(),
        LiveSilhouette(paint: paint.swatch),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: AppText(
            paint.label.toUpperCase(),
            variant: AppTextVariant.wordmark,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (final PaintFinish finish in PaintFinish.values)
              PaintSwatch(
                key: ValueKey<PaintFinish>(finish),
                finish: finish,
                selected: finish == paint,
                onTap: () =>
                    context.read<OnboardingController>().selectPaint(finish),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
