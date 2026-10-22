import 'package:flutter/foundation.dart';

import '../../domain/entities/reservation_step.dart';

/// A mock: it only moves between steps. No payment, no network.
class ReservationController extends ChangeNotifier {
  ReservationStep _step = ReservationStep.trim;

  ReservationStep get step => _step;

  void advance() {
    final ReservationStep? next = _step.next;
    if (next == null) {
      return;
    }
    _step = next;
    notifyListeners();
  }
}
