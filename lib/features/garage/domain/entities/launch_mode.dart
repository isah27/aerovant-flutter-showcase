/// How hard Hold-to-Launch pulls. The offset is added to the trim's best
/// 0-100 km/h time, so Afterburn on Zenith gives the headline 1.9 s.
enum LaunchMode {
  glide('Glide', 1.2),
  sport('Sport', 0.5),
  afterburn('Afterburn', 0);

  const LaunchMode(this.label, this.offsetSeconds);

  final String label;
  final double offsetSeconds;
}
