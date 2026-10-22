/// Fictional trims. Every figure here is invented for the demo.
enum Trim {
  touring('Touring', 2.6, 640, 305, 780),
  apex('Apex', 2.2, 590, 330, 980),
  zenith('Zenith', 1.9, 540, 350, 1150);

  const Trim(
    this.label,
    this.zeroTo100Seconds,
    this.rangeKm,
    this.topSpeedKmh,
    this.powerKw,
  );

  final String label;
  final double zeroTo100Seconds;
  final int rangeKm;
  final int topSpeedKmh;
  final int powerKw;
}
