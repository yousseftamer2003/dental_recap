import 'package:dental_recap/features/auth/domain/entities/user_entity.dart';

/// In-memory session used when [kUseMockData] is true.
class MockSession {
  static UserEntity? currentUser;

  static void setUser(UserEntity user) => currentUser = user;

  static void clear() => currentUser = null;
}
