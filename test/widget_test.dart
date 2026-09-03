import 'package:dental_recap/twitter_clone_app.dart';
import 'package:dental_recap/core/routing/app_router.dart';
import 'package:dental_recap/core/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      TwitterCloneApp(
        appRouter: AppRouter(),
        initialRoute: Routes.login,
      ),
    );

    expect(find.text('Twitter Clone'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
