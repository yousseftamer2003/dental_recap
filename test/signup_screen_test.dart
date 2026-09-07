import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_auth_repository.dart';
import 'helpers/test_surface.dart';

void main() {
  Widget buildSignupApp() {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthCubit(authRepository: FakeAuthRepository()),
        child: const SignupScreen(),
      ),
    );
  }

  testWidgets('signup screen shows title and Signup button', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildSignupApp());

    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('Join Twitter Clone'), findsOneWidget);
    await tester.ensureVisible(find.text('Signup'));
    expect(find.text('Signup'), findsOneWidget);
  });

  testWidgets('empty signup shows a snackbar', (tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(buildSignupApp());

    await tester.ensureVisible(find.text('Signup'));
    await tester.tap(find.text('Signup'));
    await tester.pump();

    expect(
      find.text('Name, email and password are required'),
      findsOneWidget,
    );
  });
}
