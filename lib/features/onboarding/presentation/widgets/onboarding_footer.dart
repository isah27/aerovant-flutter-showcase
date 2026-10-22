import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({required this.onPrimary, super.key});

  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) {
    final bool last = context.select<OnboardingController, bool>(
      (OnboardingController c) => c.step.isLast,
    );
    return AppButton(
      label: last ? AppStrings.build : AppStrings.next,
      onPressed: onPrimary,
      variant: last ? AppButtonVariant.launch : AppButtonVariant.primary,
      icon: Icons.arrow_forward,
    );
  }
}
