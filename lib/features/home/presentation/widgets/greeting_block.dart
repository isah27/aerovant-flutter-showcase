import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/home_briefing.dart';

class GreetingBlock extends StatelessWidget {
  const GreetingBlock({required this.briefing, super.key});

  final HomeBriefing briefing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(briefing.greeting, variant: AppTextVariant.title),
        const SizedBox(height: AppSpacing.xxs),
        AppText(briefing.headline, variant: AppTextVariant.headline),
      ],
    );
  }
}
