import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../garage/domain/entities/car_build.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import 'build_chip.dart';

class BuildChips extends StatelessWidget {
  const BuildChips({super.key});

  @override
  Widget build(BuildContext context) {
    final CarBuild build = context.select<GarageController, CarBuild>(
      (GarageController c) => c.build,
    );
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: <Widget>[
        BuildChip(
          key: const ValueKey<String>('paint'),
          label: build.paint.label,
          dot: build.paint.swatch,
        ),
        BuildChip(key: const ValueKey<String>('trim'), label: build.trim.label),
        BuildChip(
          key: const ValueKey<String>('wheels'),
          label: build.wheels.label,
        ),
        BuildChip(
          key: const ValueKey<String>('interior'),
          label: build.interior.label,
        ),
      ],
    );
  }
}
