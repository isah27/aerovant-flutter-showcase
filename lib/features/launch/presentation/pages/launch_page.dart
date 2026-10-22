import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../driver/presentation/controllers/driver_controller.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../controllers/launch_controller.dart';
import 'launch_view.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LaunchController>(
      // The launch mode starts from the onboarding answer
      // (Serene → Glide, Spirited → Sport, Unhinged → Afterburn).
      create: (BuildContext context) => LaunchController(
        build: context.read<GarageController>().build,
        initialMode: context.read<DriverController>().profile.style.launchMode,
      ),
      child: const LaunchView(),
    );
  }
}
