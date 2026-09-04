import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/core/firebase/safe_firebase_call.dart';
import 'package:dental_recap/features/auth/data/services/firebase_auth_service.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  AuthRepoImpl({required FirebaseAuthService authService})
    : _authService = authService;

  final FirebaseAuthService _authService;

  @override
  Future<FirebaseResult<UserEntity>> login({
    required String email,
    required String password,
  }) {
    return safeFirebaseCall('Auth - Login', () async {
      final user = await _authService.login(email: email, password: password);
      return user.toEntity();
    });
  }

  @override
  Future<FirebaseResult<void>> logout() {
    return safeFirebaseCall('Auth - Logout', () async {
      await _authService.logout();
    });
  }

  @override
  Future<FirebaseResult<UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return safeFirebaseCall('Auth - Sign Up', () async {
      final user = await _authService.signUp(
        name: name,
        email: email,
        password: password,
      );
      return user.toEntity();
    });
  }
}
