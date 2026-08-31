class UserModel {
  final String id;
  final String name;
  final String handle;
  final String email;

  const UserModel({
    required this.id,
    required this.name,
    required this.handle,
    required this.email,
  });
}

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});
}

class LoginResponse {
  final String message;
  final UserModel user;

  const LoginResponse({required this.message, required this.user});
}
