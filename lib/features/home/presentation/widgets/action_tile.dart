import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/glass_panel.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    required this.title,
    required this.hint,
    required this.icon,
    required this.accent,
    required this.onTap,
    super.key,
  });

  final String title;
  final String hint;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      onTap: onTap,
      borderColor: accent.withValues(alpha: 0.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accent, size: 28),
          const SizedBox(height: AppSpacing.lg),
          AppText(title, variant: AppTextVariant.title),
          const SizedBox(height: AppSpacing.xxs),
          AppText(hint, variant: AppTextVariant.caption),
        ],
      ),
    );
  }
}
