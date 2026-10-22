import 'package:flutter/foundation.dart';

import '../../domain/entities/driver_profile.dart';
import '../../domain/repositories/profile_repository.dart';

class DriverController extends ChangeNotifier {
  DriverController(this._repository)
    : _profile = _repository.load() ?? DriverProfile.skipped;

  final ProfileRepository _repository;
  DriverProfile _profile;

  DriverProfile get profile => _profile;

  void complete(DriverProfile profile) {
    _repository.save(profile);
    if (profile == _profile) {
      return;
    }
    _profile = profile;
    notifyListeners();
  }
}
