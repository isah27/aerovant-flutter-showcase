import 'package:flutter/painting.dart';

abstract final class AppRadii {
  static const BorderRadius tile = BorderRadius.all(Radius.circular(22));
  static const BorderRadius card = BorderRadius.all(Radius.circular(28));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(10));
  static const BorderRadius field = BorderRadius.all(Radius.circular(14));
  static const BorderRadius pill = BorderRadius.all(Radius.circular(100));
  static const BorderRadius sheet = BorderRadius.vertical(
    top: Radius.circular(32),
  );
}
