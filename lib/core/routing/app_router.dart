import 'package:flutter/material.dart';

import '../../features/configurator/presentation/pages/configurator_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/launch/presentation/pages/launch_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/reveal_page.dart';
import '../theme/app_durations.dart';
import 'app_routes.dart';

/// Each destination has its own motion: the configurator rises like a
/// garage door, the launch screen zooms in, everything else fades.
abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppRoutes.reveal => _fade(const RevealPage(), settings),
      AppRoutes.home => _fade(const HomePage(), settings),
      AppRoutes.configurator => _rise(const ConfiguratorPage(), settings),
      AppRoutes.launch => _zoom(const LaunchPage(), settings),
      _ => _fade(const OnboardingPage(), settings),
    };
  }

  static PageRouteBuilder<void> _build(
    Widget page,
    RouteSettings settings,
    RouteTransitionsBuilder transitions,
  ) {
    return PageRouteBuilder<void>(
      settings: settings,
      transitionDuration: AppDurations.route,
      reverseTransitionDuration: AppDurations.route,
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: transitions,
    );
  }

  static Route<void> _fade(Widget page, RouteSettings settings) => _build(
    page,
    settings,
    (_, Animation<double> a, _, Widget child) =>
        FadeTransition(opacity: a, child: child),
  );

  static Route<void> _rise(Widget page, RouteSettings settings) => _build(
    page,
    settings,
    (_, Animation<double> a, _, Widget child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
      child: child,
    ),
  );

  static Route<void> _zoom(Widget page, RouteSettings settings) =>
      _build(page, settings, (_, Animation<double> a, _, Widget child) {
        final Animation<double> curved = CurvedAnimation(
          parent: a,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.86, end: 1).animate(curved),
            child: child,
          ),
        );
      });
}
