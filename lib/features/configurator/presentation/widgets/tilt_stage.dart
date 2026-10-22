import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../../domain/services/tilt_math.dart';

/// The hero render: drag to tilt (with parallax between the car and its
/// glow), release and it settles back. Changing a paint or wheel
/// crossfades between renders shot from the same angle.
class TiltStage extends StatefulWidget {
  const TiltStage({required this.tilt, super.key});

  final ValueNotifier<Offset> tilt;

  @override
  State<TiltStage> createState() => _TiltStageState();
}

class _TiltStageState extends State<TiltStage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _settle = AnimationController(
    vsync: this,
    duration: AppDurations.tiltSettle,
  )..addListener(_onSettle);
  Offset _from = Offset.zero;

  void _onSettle() {
    final double t = Curves.easeOutBack.transform(_settle.value);
    widget.tilt.value = Offset.lerp(_from, Offset.zero, t)!;
  }

  void _drag(DragUpdateDetails d) {
    _settle.stop();
    widget.tilt.value = TiltMath.applyDrag(widget.tilt.value, d.delta);
  }

  void _release(DragEndDetails _) {
    _from = widget.tilt.value;
    _settle.forward(from: 0);
  }

  @override
  void dispose() {
    _settle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String asset = context.select<GarageController, String>(
      (GarageController c) => c.build.asset,
    );
    final Color glow = context.select<GarageController, Color>(
      (GarageController c) => c.build.paint.swatch,
    );
    final int cacheWidth = ImageCacheSize.forExtent(
      context,
      AppSizes.carImageWidth,
    );
    return GestureDetector(
      onPanUpdate: _drag,
      onPanEnd: _release,
      child: SizedBox(
        height: 250,
        child: RepaintBoundary(
          child: ValueListenableBuilder<Offset>(
            valueListenable: widget.tilt,
            // The image subtree is built once per asset and reused as
            // `child`, so a drag only updates two transforms.
            child: AnimatedSwitcher(
              duration: AppDurations.crossfade,
              child: Image(
                key: ValueKey<String>(asset),
                image: SizedAssetImage.of(asset, cacheWidth),
                fit: BoxFit.contain,
                gaplessPlayback: true,
              ),
            ),
            builder: (BuildContext context, Offset tilt, Widget? car) => Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: TiltMath.glowShift(tilt),
                  child: _Glow(color: glow),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012)
                    ..rotateY(TiltMath.yaw(tilt))
                    ..rotateX(TiltMath.pitch(tilt)),
                  child: Transform.translate(
                    offset: TiltMath.carShift(tilt),
                    child: car,
                  ),
                ),
                const Positioned(
                  bottom: 6,
                  child: AppText(
                    AppStrings.dragHint,
                    variant: AppTextVariant.caption,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: color),
      duration: AppDurations.crossfade,
      builder: (BuildContext context, Color? c, _) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.7,
            colors: <Color>[
              (c ?? color).withValues(alpha: 0.28),
              AppColors.transparent,
            ],
          ),
        ),
        child: const SizedBox(width: 380, height: 220),
      ),
    );
  }
}
