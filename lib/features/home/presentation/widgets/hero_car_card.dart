import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import 'style_badge.dart';

/// The driver's own car, in the paint they picked. Crossfades when the
/// configurator changes it.
class HeroCarCard extends StatelessWidget {
  const HeroCarCard({required this.badge, super.key});

  final String badge;

  @override
  Widget build(BuildContext context) {
    final String asset = context.select<GarageController, String>(
      (GarageController c) => c.build.asset,
    );
    final int cacheWidth = ImageCacheSize.forExtent(
      context,
      AppSizes.carImageWidth,
    );
    return ClipRRect(
      borderRadius: AppRadii.card,
      child: ColoredBox(
        color: AppColors.voidBlack,
        child: SizedBox(
          height: AppSizes.heroHeight,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              RepaintBoundary(
                child: AnimatedSwitcher(
                  duration: AppDurations.crossfade,
                  child: Image(
                    key: ValueKey<String>(asset),
                    image: SizedAssetImage.of(asset, cacheWidth),
                    fit: BoxFit.cover,
                    alignment: const Alignment(0, 0.2),
                  ),
                ),
              ),
              Positioned(
                left: AppSpacing.md,
                top: AppSpacing.md,
                child: StyleBadge(text: badge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
