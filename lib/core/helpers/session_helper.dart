import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserEntity? getCurrentUser() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;

  final email = user.email ?? 'No email';
  final name = user.displayName ?? user.email?.split('@')[0] ?? 'Unknown';
  final uid = user.uid;

  return UserEntity(email: email, name: name, id: uid);
}
