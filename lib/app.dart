import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/constants/app_strings.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_scroll_behavior.dart';
import 'core/theme/app_theme.dart';
import 'features/driver/data/repositories/in_memory_profile_repository.dart';
import 'features/driver/domain/repositories/profile_repository.dart';
import 'features/driver/presentation/controllers/driver_controller.dart';
import 'features/garage/presentation/controllers/garage_controller.dart';
import 'features/home/data/repositories/local_route_repository.dart';
import 'features/home/domain/repositories/route_repository.dart';

/// Composition root. The driver profile and the car build live above the
/// navigator because onboarding, home, the configurator and the launch
/// screen all read them. Tests can pass other repositories.
class AerovantApp extends StatelessWidget {
  const AerovantApp({
    this.profileRepository,
    this.routeRepository = const LocalRouteRepository(),
    super.key,
  });

  final ProfileRepository? profileRepository;
  final RouteRepository routeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<RouteRepository>.value(value: routeRepository),
        ChangeNotifierProvider<DriverController>(
          create: (_) => DriverController(
            profileRepository ?? InMemoryProfileRepository(),
          ),
        ),
        ChangeNotifierProvider<GarageController>(
          create: (_) => GarageController(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.brand,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        scrollBehavior: const AppScrollBehavior(),
        initialRoute: AppRoutes.onboarding,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
