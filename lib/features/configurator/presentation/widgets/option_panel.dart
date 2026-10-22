import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../garage/domain/entities/interior.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../../../garage/domain/entities/trim.dart';
import '../../../garage/domain/entities/wheel_set.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../../../onboarding/presentation/widgets/paint_swatch.dart';
import 'choice_pill.dart';
import 'option_section.dart';

class OptionPanel extends StatelessWidget {
  const OptionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final GarageController garage = context.read<GarageController>();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      children: <Widget>[
        OptionSection(
          title: AppStrings.trim,
          child: Selector<GarageController, Trim>(
            selector: (_, GarageController c) => c.build.trim,
            builder: (_, Trim selected, _) => Row(
              children: <Widget>[
                for (final Trim trim in Trim.values) ...<Widget>[
                  if (trim.index > 0) const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: ChoicePill(
                      label: trim.label,
                      selected: trim == selected,
                      onTap: () => garage.selectTrim(trim),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        OptionSection(
          title: AppStrings.paint,
          child: Selector<GarageController, PaintFinish>(
            selector: (_, GarageController c) => c.build.paint,
            builder: (_, PaintFinish selected, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (final PaintFinish paint in PaintFinish.values)
                  PaintSwatch(
                    key: ValueKey<PaintFinish>(paint),
                    finish: paint,
                    selected: paint == selected,
                    onTap: () => garage.selectPaint(paint),
                  ),
              ],
            ),
          ),
        ),
        OptionSection(
          title: AppStrings.wheels,
          child: Selector<GarageController, WheelSet>(
            selector: (_, GarageController c) => c.build.wheels,
            builder: (_, WheelSet selected, _) => Row(
              children: <Widget>[
                for (final WheelSet wheels in WheelSet.values) ...<Widget>[
                  if (wheels.index > 0) const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: ChoicePill(
                      label: wheels.label,
                      selected: wheels == selected,
                      onTap: () => garage.selectWheels(wheels),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        OptionSection(
          title: AppStrings.interior,
          child: Selector<GarageController, Interior>(
            selector: (_, GarageController c) => c.build.interior,
            builder: (_, Interior selected, _) => Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: <Widget>[
                for (final Interior interior in Interior.values)
                  ChoicePill(
                    label: interior.label,
                    selected: interior == selected,
                    onTap: () => garage.selectInterior(interior),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
