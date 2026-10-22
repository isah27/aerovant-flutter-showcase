import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import 'app_text.dart';

enum AppButtonVariant { primary, ghost, launch }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.expanded = true,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool expanded;
  final IconData? icon;

  Color get _fill => switch (variant) {
    AppButtonVariant.primary => AppColors.plasmaWhite,
    AppButtonVariant.launch => AppColors.afterburnAmber,
    AppButtonVariant.ghost => AppColors.transparent,
  };

  Color get _ink => switch (variant) {
    AppButtonVariant.ghost => AppColors.plasmaWhite,
    _ => AppColors.voidBlack,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeight,
      width: expanded ? double.infinity : null,
      child: Material(
        color: _fill,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.pill,
          side: variant == AppButtonVariant.ghost
              ? const BorderSide(color: AppColors.hairline)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppText(
                  label.toUpperCase(),
                  variant: AppTextVariant.label,
                  color: _ink,
                ),
                if (icon != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.xs),
                  Icon(icon, size: 18, color: _ink),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
