import '../entities/driver_profile.dart';

abstract interface class ProfileRepository {
  DriverProfile? load();
  void save(DriverProfile profile);
}
