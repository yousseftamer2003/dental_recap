import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/core/helpers/mock_session.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:dental_recap/features/auth/domain/repositories/auth_repository.dart';

/// Fake auth for UI preview — any email/password works.
class AuthMockRepoImpl implements AuthRepository {
  @override
  Future<FirebaseResult<UserEntity>> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final name = email.split('@').first;
    final user = UserEntity(
      id: 'mock-user',
      name: name,
      handle: '@$name',
      email: email.trim(),
    );
    MockSession.setUser(user);
    return FirebaseResult.success(user);
  }

  @override
  Future<FirebaseResult<UserEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final handle = '@${name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '')}';
    final user = UserEntity(
      id: 'mock-user',
      name: name.trim(),
      handle: handle,
      email: email.trim(),
    );
    MockSession.setUser(user);
    return FirebaseResult.success(user);
  }

  @override
  Future<FirebaseResult<void>> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    MockSession.clear();
    return FirebaseResult.success(null);
  }
}
