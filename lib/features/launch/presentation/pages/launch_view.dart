import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/demo/demo_tour.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entities/launch_phase.dart';
import '../../domain/services/launch_math.dart';
import '../controllers/launch_controller.dart';
import '../demo/launch_tour.dart';
import '../widgets/launch_ring.dart';
import '../widgets/launch_stage.dart';
import '../widgets/mode_selector.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({super.key});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> with TickerProviderStateMixin {
  late final AnimationController _hold =
      AnimationController(vsync: this, duration: AppDurations.hold)
        ..addListener(_onHoldTick)
        ..addStatusListener(_onHoldStatus);
  late final AnimationController _run = AnimationController(vsync: this)
    ..addStatusListener(_onRunStatus);
  int _lastTick = 0;

  LaunchController get _launch => context.read<LaunchController>();

  @override
  void initState() {
    super.initState();
    if (DemoTour.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => LaunchTour(
          launch: _launch,
          press: _press,
          release: _release,
          again: _again,
          onDone: () => Navigator.of(context).maybePop(),
          isActive: () => mounted,
        ).run(),
      );
    }
  }

  void _onHoldTick() {
    final int tick = LaunchMath.tickFor(_hold.value);
    if (tick > _lastTick) {
      HapticFeedback.selectionClick();
    }
    _lastTick = tick;
  }

  void _onHoldStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    HapticFeedback.heavyImpact();
    _launch.start();
    _run.duration = LaunchMath.runDuration(_launch.seconds);
    _run.forward(from: 0);
  }

  void _onRunStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      HapticFeedback.mediumImpact();
      _launch.finish();
    }
  }

  void _press() {
    if (_launch.phase != LaunchPhase.idle) {
      return;
    }
    _launch.arm();
    _hold.forward(from: 0);
  }

  void _release() {
    if (_launch.phase == LaunchPhase.arming) {
      _launch.cancel();
      _hold.reverse();
    }
  }

  void _again() {
    _hold.value = 0;
    _run.value = 0;
    _lastTick = 0;
    _launch.reset();
  }

  @override
  void dispose() {
    _hold.dispose();
    _run.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.lg,
                0,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close),
                  ),
                  const AppText(
                    AppStrings.launchTitle,
                    variant: AppTextVariant.label,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ModeSelector(),
            ),
            Expanded(child: LaunchStage(run: _run)),
            Listener(
              onPointerDown: (_) => _press(),
              onPointerUp: (_) => _release(),
              onPointerCancel: (_) => _release(),
              child: LaunchRing(hold: _hold, run: _run),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 72,
              child: Selector<LaunchController, bool>(
                selector: (_, LaunchController c) =>
                    c.phase == LaunchPhase.finished,
                builder: (_, bool finished, _) => finished
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxl,
                        ),
                        child: Column(
                          children: <Widget>[
                            AppButton(
                              label: AppStrings.launchAgain,
                              onPressed: _again,
                              variant: AppButtonVariant.ghost,
                            ),
                          ],
                        ),
                      )
                    : const AppText(
                        AppStrings.fictional,
                        variant: AppTextVariant.caption,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
