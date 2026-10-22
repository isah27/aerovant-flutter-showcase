import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/demo/demo_tour.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../garage/domain/entities/paint_finish.dart';
import '../../../garage/domain/entities/wheel_set.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../demo/configurator_tour.dart';
import '../widgets/option_panel.dart';
import '../widgets/spec_readout.dart';
import '../widgets/tilt_stage.dart';

class ConfiguratorPage extends StatefulWidget {
  const ConfiguratorPage({super.key});

  @override
  State<ConfiguratorPage> createState() => _ConfiguratorPageState();
}

class _ConfiguratorPageState extends State<ConfiguratorPage> {
  final ValueNotifier<Offset> _tilt = ValueNotifier<Offset>(Offset.zero);
  bool _precached = false;

  @override
  void initState() {
    super.initState();
    if (DemoTour.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ConfiguratorTour(
          garage: context.read<GarageController>(),
          tilt: _tilt,
          onDone: _close,
          isActive: () => mounted,
        ).run(),
      );
    }
  }

  /// All eight renders are decoded up front at display size, so a swatch
  /// tap crossfades instantly instead of waiting for a decode.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) {
      return;
    }
    _precached = true;
    final int width = ImageCacheSize.forExtent(context, AppSizes.carImageWidth);
    for (final PaintFinish paint in PaintFinish.values) {
      for (final WheelSet wheels in WheelSet.values) {
        precacheImage(
          SizedAssetImage.of(AppAssets.car(paint.id, wheels.id), width),
          context,
        );
      }
    }
  }

  @override
  void dispose() {
    _tilt.dispose();
    super.dispose();
  }

  void _close() {
    if (mounted) {
      Navigator.of(context).maybePop();
    }
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
                    onPressed: _close,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 30),
                  ),
                  const AppText(
                    AppStrings.configurator,
                    variant: AppTextVariant.label,
                  ),
                ],
              ),
            ),
            TiltStage(tilt: _tilt),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SpecReadout(),
            ),
            const SizedBox(height: AppSpacing.md),
            const Expanded(child: OptionPanel()),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: AppButton(label: AppStrings.done, onPressed: _close),
            ),
          ],
        ),
      ),
    );
  }
}
