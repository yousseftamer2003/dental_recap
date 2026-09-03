import 'package:dental_recap/core/constants/app_config.dart';
import 'package:dental_recap/core/helpers/mock_session.dart';
import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserEntity? currentUserEntity() {
  if (kUseMockData) return MockSession.currentUser;

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;

  final email = user.email ?? '';
  final name = email.split('@').first;
  return UserEntity(
    id: user.uid,
    name: name,
    handle: '@$name',
    email: email,
  );
}
