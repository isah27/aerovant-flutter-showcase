import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'action_tile.dart';

class ActionTiles extends StatelessWidget {
  const ActionTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ActionTile(
            title: AppStrings.launchTile,
            hint: AppStrings.launchTileHint,
            icon: Icons.radio_button_checked,
            accent: AppColors.afterburnAmber,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.launch),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ActionTile(
            title: AppStrings.configTile,
            hint: AppStrings.configTileHint,
            icon: Icons.tune,
            accent: AppColors.ionBlue,
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.configurator),
          ),
        ),
      ],
    );
  }
}
