import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppText(text, variant: AppTextVariant.label),
    );
  }
}
