import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../garage/domain/entities/spec_sheet.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import 'spec_stat.dart';

/// Rebuilds only when the computed spec actually changes (paint does not
/// change the spec, so a paint tap never touches this row).
class SpecReadout extends StatelessWidget {
  const SpecReadout({super.key});

  @override
  Widget build(BuildContext context) {
    final SpecSheet spec = context.select<GarageController, SpecSheet>(
      (GarageController c) => c.spec,
    );
    return Row(
      children: <Widget>[
        Expanded(
          child: SpecStat(
            label: AppStrings.zeroTo100,
            value: spec.zeroTo100Seconds,
            unit: 's',
            decimals: 1,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: SpecStat(
            label: AppStrings.range,
            value: spec.rangeKm.toDouble(),
            unit: 'km',
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: SpecStat(
            label: AppStrings.topSpeed,
            value: spec.topSpeedKmh.toDouble(),
            unit: 'km/h',
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: SpecStat(
            label: AppStrings.power,
            value: spec.powerKw.toDouble(),
            unit: 'kW',
          ),
        ),
      ],
    );
  }
}
