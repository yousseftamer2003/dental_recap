import 'package:dental_recap/core/firebase/firebase_error_model.dart';
import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';

/// Stand-in for Firebase. Widget/unit tests must not call the real backend.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.shouldFail = false});

  final bool shouldFail;

  @override
  Future<FirebaseResult<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (shouldFail) {
      return FirebaseResult.failure(
        FirebaseErrorModel(message: 'Invalid credentials'),
      );
    }
    return FirebaseResult.success(
      UserEntity(id: '1', email: email, name: 'Test User'),
    );
  }

  @override
  Future<FirebaseResult<UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    if (shouldFail) {
      return FirebaseResult.failure(
        FirebaseErrorModel(message: 'Email already in use'),
      );
    }
    return FirebaseResult.success(
      UserEntity(id: '1', email: email, name: name),
    );
  }

  @override
  Future<FirebaseResult<void>> logout() async {
    if (shouldFail) {
      return FirebaseResult.failure(
        FirebaseErrorModel(message: 'Logout failed'),
      );
    }
    return FirebaseResult.success(null);
  }
}
