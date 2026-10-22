import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/car_silhouette_painter.dart';
import '../../../driver/domain/entities/driver_profile.dart';
import '../../../driver/presentation/controllers/driver_controller.dart';
import '../widgets/name_plate.dart';

/// "Building your AEROVANT…": the wireframe traces itself, fills with the
/// chosen paint, then the name is engraved on the plate. About 2.6 s.
class RevealPage extends StatefulWidget {
  const RevealPage({super.key});

  @override
  State<RevealPage> createState() => _RevealPageState();
}

class _RevealPageState extends State<RevealPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: AppDurations.reveal,
  )..addStatusListener(_onStatus);

  late final Animation<double> _trace = CurvedAnimation(
    parent: _c,
    curve: const Interval(0, 0.5, curve: Curves.easeInOutCubic),
  );
  late final Animation<double> _fill = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.42, 0.78, curve: Curves.easeOut),
  );
  late final Animation<double> _engrave = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.68, 0.95),
  );

  @override
  void initState() {
    super.initState();
    _c.forward();
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      });
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DriverProfile profile = context.read<DriverController>().profile;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AppText(
                AppStrings.revealTitle,
                variant: AppTextVariant.label,
              ),
              const SizedBox(height: AppSpacing.xxl),
              RepaintBoundary(
                child: AspectRatio(
                  aspectRatio: 1 / CarSilhouettePainter.aspect,
                  child: AnimatedBuilder(
                    animation: _c,
                    builder: (BuildContext context, _) => CustomPaint(
                      painter: CarSilhouettePainter(
                        color: profile.paint.swatch,
                        trace: _trace.value,
                        fill: _fill.value,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AnimatedBuilder(
                animation: _engrave,
                builder: (BuildContext context, _) =>
                    NamePlate(name: profile.name, progress: _engrave.value),
              ),
              const SizedBox(height: AppSpacing.lg),
              FadeTransition(
                opacity: _engrave,
                child: AppText(
                  '${profile.paint.label} · ${profile.style.label}',
                  variant: AppTextVariant.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
