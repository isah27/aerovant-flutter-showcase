import 'package:flutter/material.dart';

import '../../../../core/theme/app_durations.dart';
import '../../../../core/widgets/car_silhouette_painter.dart';

/// The vector car, recoloured with an animated colour tween on each tap.
class LiveSilhouette extends StatelessWidget {
  const LiveSilhouette({required this.paint, super.key});

  final Color paint;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AspectRatio(
        aspectRatio: 1 / CarSilhouettePainter.aspect,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: paint),
          duration: AppDurations.crossfade,
          curve: Curves.easeOutCubic,
          builder: (BuildContext context, Color? color, _) =>
              CustomPaint(painter: CarSilhouettePainter(color: color ?? paint)),
        ),
      ),
    );
  }
}
