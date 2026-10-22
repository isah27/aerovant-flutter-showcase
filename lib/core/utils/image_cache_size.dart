import 'package:flutter/widgets.dart';

/// Converts a logical extent into decoded pixels so images are never
/// decoded larger than they are drawn.
abstract final class ImageCacheSize {
  static int forExtent(BuildContext context, double logical) {
    final double ratio = MediaQuery.devicePixelRatioOf(context);
    return (logical * ratio).round();
  }
}
