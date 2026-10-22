import '../../../driver/domain/entities/route_preference.dart';
import '../../domain/entities/suggested_route.dart';
import '../../domain/repositories/route_repository.dart';

/// Invented drives. No real places or roads.
class LocalRouteRepository implements RouteRepository {
  const LocalRouteRepository();

  static const List<SuggestedRoute> _routes = <SuggestedRoute>[
    SuggestedRoute(
      id: 'cliffside',
      title: 'Cliffside Coast Run',
      detail: '84 km · sunrise · sea on your left',
      preference: RoutePreference.coastal,
    ),
    SuggestedRoute(
      id: 'midnight-loop',
      title: 'Midnight City Loop',
      detail: '32 km · empty boulevards after 1 am',
      preference: RoutePreference.city,
    ),
    SuggestedRoute(
      id: 'desert-circuit',
      title: 'Desert Test Circuit',
      detail: '5.2 km lap · launch strip open',
      preference: RoutePreference.track,
    ),
  ];

  @override
  List<SuggestedRoute> routes() => _routes;
}
