import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lab06/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AppEdad()); // ← cambiar aquí
  });
}