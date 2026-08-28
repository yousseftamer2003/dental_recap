import 'package:dental_recap/features/auth/data/models/login_request.dart';
import 'package:dental_recap/features/auth/data/repos/auth_repo.dart';
import 'package:dental_recap/features/auth/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(const LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login({
    required String emailOrPhone,
    required String password,
  }) async {
    if (emailOrPhone.trim().isEmpty || password.isEmpty) {
      emit(const LoginFailure('Please enter email/phone and password.'));
      return;
    }

    emit(const LoginLoading());

    final identifier = emailOrPhone.trim();
    final isEmail = identifier.contains('@');

    try {
      final response = await _authRepo.login(
        LoginRequest(
          email: isEmail ? identifier : null,
          phone: isEmail ? null : identifier,
          password: password,
        ),
      );
      emit(LoginSuccess(response));
    } catch (e) {
      emit(LoginFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
