import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../driver/domain/entities/driving_style.dart';
import '../controllers/onboarding_controller.dart';
import 'style_card.dart';

/// Swipe-select: the card that settles in the centre is the answer.
class StyleStep extends StatelessWidget {
  const StyleStep({required this.pages, super.key});

  final PageController pages;

  @override
  Widget build(BuildContext context) {
    final OnboardingController onboarding = context
        .read<OnboardingController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: AppSpacing.xl),
        const AppText(AppStrings.styleTitle, variant: AppTextVariant.headline),
        const SizedBox(height: AppSpacing.xs),
        const AppText(AppStrings.styleHint),
        const SizedBox(height: AppSpacing.xl),
        SizedBox(
          height: AppSizes.styleCardHeight,
          child: OverflowBox(
            maxWidth: MediaQuery.sizeOf(context).width,
            child: PageView.builder(
              controller: pages,
              itemCount: DrivingStyle.values.length,
              onPageChanged: (int i) =>
                  onboarding.selectStyle(DrivingStyle.values[i]),
              itemBuilder: (BuildContext context, int i) => StyleCard(
                key: ValueKey<DrivingStyle>(DrivingStyle.values[i]),
                style: DrivingStyle.values[i],
                index: i,
                pages: pages,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
