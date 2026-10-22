import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/brand_wordmark.dart';
import '../../../driver/presentation/controllers/driver_controller.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final String initial = context.select<DriverController, String>(
      (DriverController c) => c.profile.name.characters.first.toUpperCase(),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Row(
        children: <Widget>[
          const BrandWordmark(),
          const Spacer(),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.graphiteHigh,
            child: AppText(initial, variant: AppTextVariant.title),
          ),
        ],
      ),
    );
  }
}
