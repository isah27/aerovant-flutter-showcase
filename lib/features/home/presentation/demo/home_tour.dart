import 'package:flutter/material.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../reservation/presentation/widgets/reservation_sheet.dart';

/// Recording-only: shows the personalised home, opens the configurator,
/// then Hold-to-Launch, then the reservation mock.
class HomeTour {
  HomeTour({required this.context, required this.scroll});

  final BuildContext context;
  final ScrollController scroll;

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  Future<void> _scrollTo(double offset) => scroll.animateTo(
    offset,
    duration: const Duration(milliseconds: 1100),
    curve: Curves.easeInOutCubic,
  );

  Future<void> run() async {
    final NavigatorState nav = Navigator.of(context);
    await _wait(2600);
    await nav.pushNamed(AppRoutes.configurator);
    await _wait(1400);
    await nav.pushNamed(AppRoutes.launch);
    await _wait(1000);
    await _scrollTo(scroll.position.maxScrollExtent);
    await _wait(1200);
    if (!context.mounted) {
      return;
    }
    await ReservationSheet.show(context);
    await _wait(600);
    await _scrollTo(0);
  }
}
