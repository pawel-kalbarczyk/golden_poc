class ClassB {
  const ClassB._();
  factory ClassB() => instance;
  static const instance = ClassB._();

  String _reverseText(String text) {
    return text.split('').toList().reversed.join();
  }

  bool isStringPalindrome(String text) {
    final reversed = _reverseText(text);
    return text == reversed;
  }
}
