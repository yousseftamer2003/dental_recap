import 'package:dental_recap/features/auth/data/auth_repo.dart';
import 'package:dental_recap/features/auth/data/user_model.dart';
import 'package:dental_recap/features/auth/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(const LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _submit(
      () => _authRepo.login(LoginRequest(email: email, password: password)),
      email: email,
      password: password,
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _submit(
      () => _authRepo.register(LoginRequest(email: email, password: password)),
      email: email,
      password: password,
    );
  }

  Future<void> _submit(
    Future<LoginResponse> Function() action, {
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(const LoginFailure('Please enter email and password.'));
      return;
    }

    emit(const LoginLoading());

    try {
      final response = await action();
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
