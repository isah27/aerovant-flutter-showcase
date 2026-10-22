import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../domain/services/launch_math.dart';
import '../controllers/launch_controller.dart';
import 'speed_streaks_painter.dart';

/// The car and the motion-blur streaks. Driven by the run animation only,
/// so nothing here repaints while the screen is idle.
class LaunchStage extends StatelessWidget {
  const LaunchStage({required this.run, super.key});

  final Animation<double> run;

  @override
  Widget build(BuildContext context) {
    final String asset = context.read<LaunchController>().build.asset;
    final Widget car = Image(
      image: SizedAssetImage.of(
        asset,
        ImageCacheSize.forExtent(context, AppSizes.carImageWidth),
      ),
      fit: BoxFit.contain,
    );
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: run,
        child: car,
        builder: (BuildContext context, Widget? child) {
          final double speed = LaunchMath.speedAt(run.value);
          final double k = speed / 100;
          final bool running = run.isAnimating;
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.translate(
                offset: Offset(running ? -18 * k : 0, 0),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: running ? 0.01 + 6 * k : 0.01,
                    sigmaY: 0.01,
                  ),
                  child: child,
                ),
              ),
              CustomPaint(
                painter: SpeedStreaksPainter(
                  intensity: running ? k : 0,
                  phase: run.value,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
