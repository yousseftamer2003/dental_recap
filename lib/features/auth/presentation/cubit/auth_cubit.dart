import 'package:bloc/bloc.dart';
import 'package:dental_recap/core/constants/strings.dart';
import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial());

  final AuthRepository _authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const AuthState.loginFailure('Please enter email and password.'));
      return;
    }

    emit(const AuthState.loginLoading());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    result.when(
      success: (user) => emit(AuthState.loginSuccess(user)),
      failure: (error) => emit(
        AuthState.loginFailure(
          error.displayMessage.isNotEmpty
              ? error.displayMessage
              : FirebaseErrorConstants.defaultError,
        ),
      ),
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (name.trim().isEmpty) {
      emit(const AuthState.signupFailure('Please enter your name.'));
      return;
    }
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const AuthState.signupFailure('Please enter email and password.'));
      return;
    }
    if (password.length < 6) {
      emit(const AuthState.signupFailure('Password must be at least 6 characters.'));
      return;
    }
    if (password != confirmPassword) {
      emit(const AuthState.signupFailure('Passwords do not match.'));
      return;
    }

    emit(const AuthState.signupLoading());
    final result = await _authRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    result.when(
      success: (user) => emit(AuthState.signupSuccess(user)),
      failure: (error) => emit(
        AuthState.signupFailure(
          error.displayMessage.isNotEmpty
              ? error.displayMessage
              : FirebaseErrorConstants.defaultError,
        ),
      ),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.logoutLoading());
    final result = await _authRepository.logout();
    result.when(
      success: (_) => emit(const AuthState.logoutSuccess()),
      failure: (error) => emit(
        AuthState.logoutFailure(
          error.displayMessage.isNotEmpty
              ? error.displayMessage
              : FirebaseErrorConstants.defaultError,
        ),
      ),
    );
  }
}
