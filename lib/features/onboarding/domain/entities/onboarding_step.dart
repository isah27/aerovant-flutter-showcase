enum OnboardingStep {
  name,
  style,
  finish;

  bool get isLast => this == OnboardingStep.finish;
}
