import 'package:dental_recap/core/firebase/firebase_result.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<FirebaseResult<UserEntity>> login({required String email, required String password});

  Future<FirebaseResult<UserEntity>> signup({required String name,required String email, required String password});

  Future<FirebaseResult<void>> logout();
}