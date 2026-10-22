import '../../domain/entities/driver_profile.dart';
import '../../domain/repositories/profile_repository.dart';

/// Answers live in app state for the session. Swapping this for a
/// shared_preferences implementation would not touch any widget.
class InMemoryProfileRepository implements ProfileRepository {
  DriverProfile? _profile;

  @override
  DriverProfile? load() => _profile;

  @override
  void save(DriverProfile profile) => _profile = profile;
}
