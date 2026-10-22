import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/demo/demo_tour.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/reservation_step.dart';
import '../controllers/reservation_controller.dart';
import 'reservation_step_view.dart';

class ReservationSheet extends StatelessWidget {
  const ReservationSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.graphite,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.sheet),
      builder: (_) => ChangeNotifierProvider<ReservationController>(
        create: (_) {
          final ReservationController c = ReservationController();
          if (DemoTour.enabled) {
            _demo(context, c);
          }
          return c;
        },
        child: const ReservationSheet(),
      ),
    );
  }

  static Future<void> _demo(
    BuildContext context,
    ReservationController c,
  ) async {
    final NavigatorState nav = Navigator.of(context);
    for (int i = 0; i < 2; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1500));
      c.advance();
    }
    await Future<void>.delayed(const Duration(milliseconds: 1900));
    nav.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final ReservationStep step = context
        .select<ReservationController, ReservationStep>(
          (ReservationController c) => c.step,
        );
    final bool done = step == ReservationStep.confirmed;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            '${AppStrings.reservation} · ${step.index + 1}/3',
            variant: AppTextVariant.label,
          ),
          const SizedBox(height: AppSpacing.md),
          AnimatedSize(
            duration: AppDurations.medium,
            child: AnimatedSwitcher(
              duration: AppDurations.medium,
              child: ReservationStepView(
                key: ValueKey<ReservationStep>(step),
                step: step,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: switch (step) {
              ReservationStep.trim => AppStrings.next,
              ReservationStep.summary => AppStrings.confirm,
              ReservationStep.confirmed => AppStrings.close,
            },
            variant: done ? AppButtonVariant.ghost : AppButtonVariant.primary,
            onPressed: done
                ? () => Navigator.of(context).maybePop()
                : context.read<ReservationController>().advance,
          ),
        ],
      ),
    );
  }
}
