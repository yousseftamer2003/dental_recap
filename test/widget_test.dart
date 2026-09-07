import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dental_recap/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_auth_repository.dart';
import 'helpers/test_surface.dart';

void main() {
  testWidgets('Login screen loads', (WidgetTester tester) async {
    useTallPhone(tester);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => AuthCubit(authRepository: FakeAuthRepository()),
          child: const LoginScreen(),
        ),
      ),
    );

    expect(find.text('Twitter Clone'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
