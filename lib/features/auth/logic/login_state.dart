import 'package:dental_recap/features/auth/data/models/login_response.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  const LoginSuccess(this.response);
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}
