import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../driver/domain/entities/route_preference.dart';
import '../controllers/onboarding_controller.dart';

class RouteChip extends StatelessWidget {
  const RouteChip({required this.route, super.key});

  final RoutePreference route;

  static const Map<RoutePreference, IconData> _icons =
      <RoutePreference, IconData>{
        RoutePreference.coastal: Icons.waves,
        RoutePreference.city: Icons.location_city,
        RoutePreference.track: Icons.flag_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final bool selected = context.select<OnboardingController, bool>(
      (OnboardingController c) => c.route == route,
    );
    return GestureDetector(
      onTap: () => context.read<OnboardingController>().selectRoute(route),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.ionBlue : AppColors.glass,
          borderRadius: AppRadii.chip,
          border: Border.all(
            color: selected ? AppColors.ionBlue : AppColors.hairline,
          ),
        ),
        child: Column(
          children: <Widget>[
            Icon(_icons[route], color: AppColors.plasmaWhite, size: 20),
            const SizedBox(height: AppSpacing.xxs),
            AppText(route.label, variant: AppTextVariant.title),
          ],
        ),
      ),
    );
  }
}
