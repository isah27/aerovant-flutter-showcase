import '../../../garage/domain/entities/launch_mode.dart';

enum DrivingStyle {
  serene('Serene', 'Quiet cabin, long horizons.', LaunchMode.glide),
  spirited('Spirited', 'Sharp on the back roads.', LaunchMode.sport),
  unhinged('Unhinged', 'Everything, all at once.', LaunchMode.afterburn);

  const DrivingStyle(this.label, this.tagline, this.launchMode);

  final String label;
  final String tagline;

  /// The launch mode Hold-to-Launch opens with.
  final LaunchMode launchMode;
}
