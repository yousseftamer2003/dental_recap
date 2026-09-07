import 'package:dental_recap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_auth_repository.dart';

void main() {
  group('AuthCubit.login', () {
    test('emits failure when email or password is empty', () async {
      final cubit = AuthCubit(authRepository: FakeAuthRepository());

      await cubit.login('  ', '');

      expect(
        cubit.state,
        const AuthState.loginFailure('Email and password are required'),
      );
      await cubit.close();
    });

    test('emits success when the repository returns a user', () async {
      final cubit = AuthCubit(authRepository: FakeAuthRepository());

      await cubit.login('a@b.com', '123456');

      cubit.state.maybeWhen(
        loginSuccess: (user) {
          expect(user.email, 'a@b.com');
        },
        orElse: () => fail('Expected loginSuccess, got ${cubit.state}'),
      );
      await cubit.close();
    });

    test('emits failure when the repository fails', () async {
      final cubit = AuthCubit(
        authRepository: FakeAuthRepository(shouldFail: true),
      );

      await cubit.login('a@b.com', 'wrong');

      expect(cubit.state, const AuthState.loginFailure('Invalid credentials'));
      await cubit.close();
    });
  });

  group('AuthCubit.signup', () {
    test('emits failure when required fields are empty', () async {
      final cubit = AuthCubit(authRepository: FakeAuthRepository());

      await cubit.signup('', 'a@b.com', '123456', '123456');

      expect(
        cubit.state,
        const AuthState.signupFailure('Name, email and password are required'),
      );
      await cubit.close();
    });
  });
}
