import 'package:example_package/example_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final classB = ClassB();

  group('ClassB', () {
    testWidgets('isStringPalindrome("word") should return false', (tester) async {
      final check = classB.isStringPalindrome('word');

      expect(check, false);
    });
    testWidgets('isStringPalindrome("radar") should return true', (tester) async {
      final check = classB.isStringPalindrome('radar');

      expect(check, false);
    });
  });
}
