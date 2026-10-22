import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../configurator/presentation/widgets/choice_pill.dart';
import '../../../garage/domain/entities/launch_mode.dart';
import '../controllers/launch_controller.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final LaunchMode mode = context.select<LaunchController, LaunchMode>(
      (LaunchController c) => c.mode,
    );
    return Row(
      children: <Widget>[
        for (final LaunchMode m in LaunchMode.values) ...<Widget>[
          if (m.index > 0) const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: ChoicePill(
              key: ValueKey<LaunchMode>(m),
              label: m.label,
              selected: m == mode,
              onTap: () => context.read<LaunchController>().selectMode(m),
            ),
          ),
        ],
      ],
    );
  }
}
