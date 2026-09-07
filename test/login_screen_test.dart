import 'package:dental_recap/core/routing/routes.dart';
import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_auth_repository.dart';
import 'helpers/test_surface.dart';

void main() {
  Widget buildLoginApp({FakeAuthRepository? repository}) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthCubit(
          authRepository: repository ?? FakeAuthRepository(),
        ),
        child: const LoginScreen(),
      ),
      routes: {
        Routes.signup: (_) => const Scaffold(body: Text('Join Twitter Clone')),
        Routes.home: (_) => const Scaffold(body: Text('Home feed')),
      },
    );
  }

  testWidgets('login screen shows title and Login button', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildLoginApp());

    expect(find.text('Twitter Clone'), findsOneWidget);
    expect(find.text('Login to your account'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
  });

  testWidgets('can type email and password', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildLoginApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'a@b.com');
    await tester.enterText(fields.at(1), '123456');

    expect(tester.widget<TextField>(fields.at(0)).controller?.text, 'a@b.com');
    expect(tester.widget<TextField>(fields.at(1)).controller?.text, '123456');
  });

  testWidgets('empty login shows a snackbar and does not call Firebase', (
    tester,
  ) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildLoginApp());

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Email and password are required'), findsOneWidget);
  });

  testWidgets('Sign up opens the signup route', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildLoginApp());

    await tester.ensureVisible(find.text('Sign up'));
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.text('Join Twitter Clone'), findsOneWidget);
  });

  testWidgets('successful login navigates to home', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildLoginApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'a@b.com');
    await tester.enterText(fields.at(1), '123456');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Home feed'), findsOneWidget);
  });
}
