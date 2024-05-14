import 'package:example_package/example_package.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final classA = ClassA();

  group('ClassA', () {
    testWidgets('multiplyAndRoundAsFixed(5, 5, 5) should return 25.00000', (tester) async {
      final check = classA.multiplyAndRoundAsFixed(a: 5, b: 5, fractionDigits: 5);

      expect(check, '25.00000');
    });
  });
}
