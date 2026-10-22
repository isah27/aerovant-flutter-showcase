import 'package:flutter/widgets.dart';

/// One place that builds the decode-at-display-size provider, so the image
/// that is precached and the image that is drawn share the same cache key.
abstract final class SizedAssetImage {
  static ImageProvider<Object> of(String asset, int cacheWidth) =>
      ResizeImage(AssetImage(asset), width: cacheWidth);
}
