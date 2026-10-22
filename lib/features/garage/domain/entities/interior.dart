enum Interior {
  graphite('Graphite Alcantara', 0),
  ivory('Ivory Leather', 6),
  carbonIon('Carbon, Ion stitch', -9);

  const Interior(this.label, this.massDeltaKg);

  final String label;
  final int massDeltaKg;
}
