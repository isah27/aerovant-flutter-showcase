import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../garage/domain/entities/paint_finish.dart';

/// A round paint chip, shared by onboarding and the configurator.
class PaintSwatch extends StatelessWidget {
  const PaintSwatch({
    required this.finish,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final PaintFinish finish;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: finish.label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: AppSizes.swatch,
          height: AppSizes.swatch,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? AppColors.plasmaWhite : AppColors.hairline,
              width: selected ? 2 : 1,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.4, -0.4),
                colors: <Color>[
                  Color.lerp(finish.swatch, AppColors.plasmaWhite, 0.4)!,
                  finish.swatch,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
