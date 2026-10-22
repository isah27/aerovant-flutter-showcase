abstract final class AppAssets {
  static const String heroStudio = 'assets/scenes/hero_studio.webp';

  /// One render per paint × wheel pair, all from the same camera angle so
  /// the configurator can crossfade between them without the car jumping.
  static String car(String paintId, String wheelId) =>
      'assets/cars/${paintId}_$wheelId.webp';
}
