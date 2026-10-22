import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../driver/presentation/controllers/driver_controller.dart';
import '../../../garage/presentation/controllers/garage_controller.dart';
import '../../domain/entities/home_briefing.dart';
import '../../domain/repositories/route_repository.dart';
import '../../domain/services/home_personaliser.dart';
import '../widgets/action_tiles.dart';
import '../widgets/build_chips.dart';
import '../widgets/greeting_block.dart';
import '../widgets/hero_car_card.dart';
import '../widgets/home_header.dart';
import '../widgets/reserve_panel.dart';
import '../widgets/route_list.dart';
import '../widgets/section_label.dart';

class HomeView extends StatelessWidget {
  const HomeView({required this.scroll, super.key});

  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    final RouteRepository routes = context.read<RouteRepository>();
    // The briefing is recomputed only when the profile or paint changes,
    // and HomeBriefing equality stops identical results from rebuilding.
    return Selector2<DriverController, GarageController, HomeBriefing>(
      selector: (_, DriverController driver, GarageController garage) =>
          HomePersonaliser.brief(
            profile: driver.profile,
            build: garage.build,
            routes: routes.routes(),
            hour: DateTime.now().hour,
          ),
      builder: (BuildContext context, HomeBriefing briefing, _) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            controller: scroll,
            slivers: <Widget>[
              const SliverToBoxAdapter(child: HomeHeader()),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverList.list(
                  children: <Widget>[
                    GreetingBlock(briefing: briefing),
                    const SizedBox(height: AppSpacing.md),
                    HeroCarCard(badge: briefing.badge),
                    const SizedBox(height: AppSpacing.md),
                    const ActionTiles(),
                    const SizedBox(height: AppSpacing.lg),
                    const SectionLabel(AppStrings.suggested),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: RouteList(routes: briefing.routes)),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(<Widget>[
                    SectionLabel(AppStrings.yourBuild),
                    BuildChips(),
                    SizedBox(height: AppSpacing.lg),
                    ReservePanel(),
                    SizedBox(height: AppSpacing.lg),
                    AppText(
                      AppStrings.disclaimer,
                      variant: AppTextVariant.caption,
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
