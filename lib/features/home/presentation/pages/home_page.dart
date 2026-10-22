import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/demo/demo_tour.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/utils/image_cache_size.dart';
import '../../../../core/utils/sized_asset_image.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../demo/home_tour.dart';
import 'home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scroll = ScrollController();
  bool _precached = false;

  @override
  void initState() {
    super.initState();
    if (DemoTour.enabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => HomeTour(context: context, scroll: _scroll).run(),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) {
      return;
    }
    _precached = true;
    precacheImage(
      SizedAssetImage.of(
        context.read<GarageController>().build.asset,
        ImageCacheSize.forExtent(context, AppSizes.carImageWidth),
      ),
      context,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeView(scroll: _scroll);
  }
}
