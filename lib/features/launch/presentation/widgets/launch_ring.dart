import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/launch_phase.dart';
import '../../domain/services/launch_math.dart';
import '../controllers/launch_controller.dart';
import 'launch_ring_painter.dart';

class LaunchRing extends StatelessWidget {
  const LaunchRing({required this.hold, required this.run, super.key});

  final Animation<double> hold;
  final Animation<double> run;

  @override
  Widget build(BuildContext context) {
    final LaunchPhase phase = context.select<LaunchController, LaunchPhase>(
      (LaunchController c) => c.phase,
    );
    return SizedBox.square(
      dimension: AppSizes.launchRing,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: hold,
              builder: (BuildContext context, _) => CustomPaint(
                size: const Size.square(AppSizes.launchRing),
                painter: LaunchRingPainter(
                  progress: hold.value,
                  live:
                      phase == LaunchPhase.running ||
                      phase == LaunchPhase.finished,
                ),
              ),
            ),
          ),
          switch (phase) {
            LaunchPhase.idle => const AppText(
              AppStrings.hold,
              variant: AppTextVariant.display,
            ),
            LaunchPhase.arming => const AppText(
              AppStrings.keepHolding,
              variant: AppTextVariant.label,
              color: AppColors.afterburnAmber,
            ),
            LaunchPhase.running => AnimatedBuilder(
              animation: run,
              builder: (BuildContext context, _) => _Readout(
                big: LaunchMath.speedAt(run.value).floor().toString(),
                small: AppStrings.kmh,
              ),
            ),
            LaunchPhase.finished => _Readout(
              big:
                  '${context.read<LaunchController>().seconds.toStringAsFixed(1)} s',
              small:
                  '0–100 km/h · ${context.read<LaunchController>().mode.label}',
            ),
          },
        ],
      ),
    );
  }
}

class _Readout extends StatelessWidget {
  const _Readout({required this.big, required this.small});

  final String big;
  final String small;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: AppSizes.launchRing * 0.66,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AppText(big, variant: AppTextVariant.telemetry),
          ),
        ),
        AppText(small, variant: AppTextVariant.caption),
      ],
    );
  }
}
