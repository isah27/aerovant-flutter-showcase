import 'package:flutter/widgets.dart';

import '../../../../core/theme/app_sizes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/suggested_route.dart';
import 'route_card.dart';

/// Lazy and keyed: cards are built as they scroll in.
class RouteList extends StatelessWidget {
  const RouteList({required this.routes, super.key});

  final List<SuggestedRoute> routes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.routeCardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: routes.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (BuildContext context, int i) => RouteCard(
          key: ValueKey<String>(routes[i].id),
          route: routes[i],
          suggested: i == 0,
        ),
      ),
    );
  }
}
