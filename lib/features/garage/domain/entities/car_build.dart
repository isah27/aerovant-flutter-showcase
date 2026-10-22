import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_assets.dart';
import 'interior.dart';
import 'paint_finish.dart';
import 'trim.dart';
import 'wheel_set.dart';

@immutable
class CarBuild {
  const CarBuild({
    this.paint = PaintFinish.plasmaWhite,
    this.wheels = WheelSet.turbine,
    this.interior = Interior.graphite,
    this.trim = Trim.zenith,
  });

  final PaintFinish paint;
  final WheelSet wheels;
  final Interior interior;
  final Trim trim;

  String get asset => AppAssets.car(paint.id, wheels.id);

  CarBuild copyWith({
    PaintFinish? paint,
    WheelSet? wheels,
    Interior? interior,
    Trim? trim,
  }) => CarBuild(
    paint: paint ?? this.paint,
    wheels: wheels ?? this.wheels,
    interior: interior ?? this.interior,
    trim: trim ?? this.trim,
  );

  @override
  bool operator ==(Object other) =>
      other is CarBuild &&
      other.paint == paint &&
      other.wheels == wheels &&
      other.interior == interior &&
      other.trim == trim;

  @override
  int get hashCode => Object.hash(paint, wheels, interior, trim);
}
