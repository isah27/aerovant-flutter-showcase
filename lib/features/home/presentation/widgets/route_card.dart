import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../domain/entities/suggested_route.dart';
import 'route_painter.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({required this.route, required this.suggested, super.key});

  final SuggestedRoute route;
  final bool suggested;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.routeCardWidth,
      child: GlassPanel(
        borderColor: suggested ? AppColors.ionBlue : AppColors.hairline,
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 92,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: RoutePainter(preference: route.preference),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppText(
                    suggested
                        ? 'FOR YOU'
                        : route.preference.label.toUpperCase(),
                    variant: AppTextVariant.label,
                    color: suggested ? AppColors.ionBlue : AppColors.steel,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AppText(
                    route.title,
                    variant: AppTextVariant.title,
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  AppText(
                    route.detail,
                    variant: AppTextVariant.caption,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
