enum WheelSet {
  turbine('turbine', 'Turbine', 0),
  forgedBronze('forged_bronze', 'Forged Bronze', 12);

  const WheelSet(this.id, this.label, this.rangeDeltaKm);

  final String id;
  final String label;

  /// Lighter forged wheels add a little range.
  final int rangeDeltaKm;
}
