import 'package:flutter/foundation.dart';

@immutable
class SpecSheet {
  const SpecSheet({
    required this.zeroTo100Seconds,
    required this.rangeKm,
    required this.topSpeedKmh,
    required this.powerKw,
  });

  final double zeroTo100Seconds;
  final int rangeKm;
  final int topSpeedKmh;
  final int powerKw;

  @override
  bool operator ==(Object other) =>
      other is SpecSheet &&
      other.zeroTo100Seconds == zeroTo100Seconds &&
      other.rangeKm == rangeKm &&
      other.topSpeedKmh == topSpeedKmh &&
      other.powerKw == powerKw;

  @override
  int get hashCode =>
      Object.hash(zeroTo100Seconds, rangeKm, topSpeedKmh, powerKw);
}
