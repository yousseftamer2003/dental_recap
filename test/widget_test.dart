import 'package:flutter_test/flutter_test.dart';

import 'package:dental_recap/main.dart';

void main() {
  testWidgets('Login screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Chirp'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
