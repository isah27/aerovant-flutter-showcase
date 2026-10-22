import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../controllers/onboarding_controller.dart';
import 'onboarding_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingController>(
      create: (_) => OnboardingController(),
      child: const OnboardingView(),
    );
  }
}
