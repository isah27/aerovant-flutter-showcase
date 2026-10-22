import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class OptionSection extends StatelessWidget {
  const OptionSection({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(title, variant: AppTextVariant.label),
          const SizedBox(height: AppSpacing.xs),
          child,
        ],
      ),
    );
  }
}
