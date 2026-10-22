enum LaunchPhase {
  /// Waiting for a press.
  idle,

  /// Finger down, ring filling.
  arming,

  /// Counter running 0 → 100 km/h.
  running,

  /// Result on screen.
  finished,
}
