import 'package:flutter/material.dart';

import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';

/// A telemetry number that rolls to its new value.
class SpecStat extends StatelessWidget {
  const SpecStat({
    required this.label,
    required this.value,
    required this.unit,
    this.decimals = 0,
    super.key,
  });

  final String label;
  final double value;
  final String unit;
  final int decimals;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TweenAnimationBuilder<double>(
          tween: Tween<double>(end: value),
          duration: AppDurations.crossfade,
          curve: Curves.easeOutCubic,
          builder: (BuildContext context, double v, _) => FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AppText(
              '${v.toStringAsFixed(decimals)} $unit',
              variant: AppTextVariant.stat,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        AppText(label, variant: AppTextVariant.caption, maxLines: 1),
      ],
    );
  }
}
