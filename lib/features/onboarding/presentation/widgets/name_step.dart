import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../driver/domain/entities/route_preference.dart';
import '../controllers/onboarding_controller.dart';
import 'route_chip.dart';

class NameStep extends StatelessWidget {
  const NameStep({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final OnboardingController onboarding = context
        .read<OnboardingController>();
    return ListView(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      children: <Widget>[
        RepaintBoundary(
          child: Image(
            image: SizedAssetImage.of(
              AppAssets.heroStudio,
              ImageCacheSize.forExtent(context, AppSizes.carImageWidth),
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const AppText(AppStrings.nameTitle, variant: AppTextVariant.headline),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          hint: AppStrings.nameHint,
          controller: controller,
          onChanged: onboarding.setName,
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: AppSpacing.lg),
        const AppText(AppStrings.routeTitle, variant: AppTextVariant.label),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: <Widget>[
            for (final RoutePreference route
                in RoutePreference.values) ...<Widget>[
              if (route.index > 0) const SizedBox(width: AppSpacing.xs),
              Expanded(child: RouteChip(route: route)),
            ],
          ],
        ),
      ],
    );
  }
}
