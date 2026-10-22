enum ReservationStep {
  trim,
  summary,
  confirmed;

  ReservationStep? get next => this == ReservationStep.confirmed
      ? null
      : ReservationStep.values[index + 1];
}
