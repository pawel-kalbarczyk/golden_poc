class ClassA {
  const ClassA._();
  factory ClassA() => instance;
  static const instance = ClassA._();

  String multiplyAndRoundAsFixed({required double a, required double b, required int fractionDigits}) {
    return (a * b).toStringAsFixed(fractionDigits);
  }
}
