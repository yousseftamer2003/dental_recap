import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/core/firebase/safe_firebase_call.dart';
import 'package:dental_recap/features/auth/data/services/auth_firebase_service.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  AuthRepoImpl({required AuthFirebaseService service}) : _service = service;

  final AuthFirebaseService _service;

  @override
  Future<FirebaseResult<UserEntity>> login({
    required String email,
    required String password,
  }) {
    return safeFirebaseCall(
      'AuthRepository.login',
      () async {
        final user = await _service.login(email: email, password: password);
        return user.toEntity();
      },
    );
  }

  @override
  Future<FirebaseResult<UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) {
    return safeFirebaseCall(
      'AuthRepository.signup',
      () async {
        final user = await _service.signup(
          name: name,
          email: email,
          password: password,
        );
        return user.toEntity();
      },
    );
  }

  @override
  Future<FirebaseResult<void>> logout() {
    return safeFirebaseCall('AuthRepository.logout', _service.logout);
  }
}
