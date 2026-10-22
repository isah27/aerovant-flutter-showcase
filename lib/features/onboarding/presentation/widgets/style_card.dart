import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../driver/domain/entities/driving_style.dart';
import '../controllers/onboarding_controller.dart';

class StyleCard extends StatelessWidget {
  const StyleCard({
    required this.style,
    required this.index,
    required this.pages,
    super.key,
  });

  final DrivingStyle style;
  final int index;
  final PageController pages;

  static const Map<DrivingStyle, Color> _accent = <DrivingStyle, Color>{
    DrivingStyle.serene: AppColors.steel,
    DrivingStyle.spirited: AppColors.ionBlue,
    DrivingStyle.unhinged: AppColors.afterburnAmber,
  };

  @override
  Widget build(BuildContext context) {
    final Color accent = _accent[style]!;
    final bool selected = context.select<OnboardingController, bool>(
      (OnboardingController c) => c.style == style,
    );
    // Scale follows the scroll position directly, so only the transform
    // updates while swiping; the card's content is built once.
    return AnimatedBuilder(
      animation: pages,
      builder: (BuildContext context, Widget? child) {
        double page = index.toDouble();
        if (pages.hasClients && pages.position.haveDimensions) {
          page = pages.page ?? page;
        }
        final double distance = (page - index).abs().clamp(0.0, 1.0);
        return Transform.scale(scale: 1 - distance * 0.12, child: child);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppRadii.card,
            border: Border.all(
              color: selected ? accent : AppColors.hairline,
              width: selected ? 2 : 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                accent.withValues(alpha: 0.32),
                AppColors.graphite,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  '0${index + 1}',
                  variant: AppTextVariant.telemetry,
                  color: accent.withValues(alpha: 0.9),
                ),
                const Spacer(),
                AppText(
                  style.label.toUpperCase(),
                  variant: AppTextVariant.display,
                ),
                const SizedBox(height: AppSpacing.xs),
                AppText(style.tagline, variant: AppTextVariant.body),
                const SizedBox(height: AppSpacing.md),
                AppText(
                  'LAUNCH MODE · ${style.launchMode.label.toUpperCase()}',
                  variant: AppTextVariant.label,
                  color: accent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
