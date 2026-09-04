part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;


  const factory AuthState.loginLoading() = _LoginLoading;
  const factory AuthState.loginSuccess(UserEntity user) = _LoginSuccess;
  const factory AuthState.loginFailure(String message) = _LoginFailure;

  const factory AuthState.signupLoading() = _SignupLoading;
  const factory AuthState.signupSuccess(UserEntity user) = _SignupSuccess;
  const factory AuthState.signupFailure(String message) = _SignupFailure;

  const factory AuthState.logoutLoading() = _LogoutLoading;
  const factory AuthState.logoutSuccess() = _LogoutSuccess;
  const factory AuthState.logoutFailure(String message) = _LogoutFailure;
}
