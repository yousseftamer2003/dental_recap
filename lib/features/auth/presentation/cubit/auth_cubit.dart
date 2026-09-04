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

  Future<void> login(String email, String password) async {
    if(email.trim().isEmpty || password.isEmpty) {
      emit(const AuthState.loginFailure('Email and password are required'));
      return;
    }

    emit(const AuthState.loginLoading());

    final result = await _authRepository.login(email: email, password: password);

    result.when(
      success: (user) => emit(AuthState.loginSuccess(user)), 
      failure: (error) => emit(AuthState.loginFailure(error.message ?? ApiConstants.defaultError)),
      );
  }

  Future<void> signup(String name, String email, String password, String confirmPassword) async {
    if(name.trim().isEmpty || email.trim().isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(const AuthState.signupFailure('Name, email and password are required'));
      return;
    }

    emit(const AuthState.signupLoading());
    
    final result = await _authRepository.signup(name: name, email: email, password: password);

    result.when(
      success: (user) => emit(AuthState.signupSuccess(user)), 
      failure: (error) => emit(AuthState.signupFailure(error.message ?? ApiConstants.defaultError)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.logoutLoading());
    final result = await _authRepository.logout();
    result.when(
      success: (_) => emit(const AuthState.logoutSuccess()), 
      failure: (error) => emit(AuthState.logoutFailure(error.message ?? ApiConstants.defaultError)),
    );
  }
}
