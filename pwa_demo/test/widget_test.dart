import 'package:flutter_test/flutter_test.dart';
import 'package:pwa_demo/main.dart';

void main() {
  testWidgets('Today screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const DaylineApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Good day'), findsOneWidget);
    expect(find.text('Today'), findsWidgets);
  });
}
