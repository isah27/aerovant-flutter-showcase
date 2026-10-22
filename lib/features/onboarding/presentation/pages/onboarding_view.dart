import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/demo/demo_tour.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../driver/domain/entities/driver_profile.dart';
import '../../../driver/presentation/controllers/driver_controller.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../../domain/entities/onboarding_step.dart';
import '../controllers/onboarding_controller.dart';
import '../demo/onboarding_tour.dart';
import '../widgets/finish_step.dart';
import '../widgets/name_step.dart';
import '../widgets/onboarding_footer.dart';
import '../widgets/onboarding_top_bar.dart';
import '../widgets/style_step.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final TextEditingController _name = TextEditingController();
  final PageController _styles = PageController(
    viewportFraction: 0.74,
    initialPage: DriverProfile.skipped.style.index,
  );
  bool _precached = false;
  bool _left = false;

  @override
  void initState() {
    super.initState();
    if (DemoTour.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => OnboardingTour(
          controller: context.read<OnboardingController>(),
          nameField: _name,
          styles: _styles,
          onFinish: _finish,
          isActive: () => mounted && !_left,
        ).run(),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) {
      return;
    }
    _precached = true;
    final int width = ImageCacheSize.forExtent(context, AppSizes.carImageWidth);
    precacheImage(SizedAssetImage.of(AppAssets.heroStudio, width), context);
  }

  @override
  void dispose() {
    _name.dispose();
    _styles.dispose();
    super.dispose();
  }

  void _skip() => _leave(DriverProfile.skipped, AppRoutes.home);

  void _finish() =>
      _leave(context.read<OnboardingController>().profile, AppRoutes.reveal);

  void _leave(DriverProfile profile, String route) {
    if (_left) {
      return;
    }
    _left = true;
    context.read<DriverController>().complete(profile);
    context.read<GarageController>().selectPaint(profile.paint);
    Navigator.of(context).pushReplacementNamed(route);
  }

  void _primary() {
    final OnboardingController controller = context
        .read<OnboardingController>();
    controller.setName(_name.text);
    if (!controller.next()) {
      _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            children: <Widget>[
              OnboardingTopBar(onSkip: _skip),
              Expanded(
                child: Selector<OnboardingController, OnboardingStep>(
                  selector: (_, OnboardingController c) => c.step,
                  builder: (BuildContext context, OnboardingStep step, _) =>
                      AnimatedSwitcher(
                        duration: AppDurations.step,
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: _slide,
                        child: switch (step) {
                          OnboardingStep.name => NameStep(
                            key: const ValueKey<OnboardingStep>(
                              OnboardingStep.name,
                            ),
                            controller: _name,
                          ),
                          OnboardingStep.style => StyleStep(
                            key: const ValueKey<OnboardingStep>(
                              OnboardingStep.style,
                            ),
                            pages: _styles,
                          ),
                          OnboardingStep.finish => const FinishStep(
                            key: ValueKey<OnboardingStep>(
                              OnboardingStep.finish,
                            ),
                          ),
                        },
                      ),
                ),
              ),
              OnboardingFooter(onPrimary: _primary),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _slide(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.12, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
