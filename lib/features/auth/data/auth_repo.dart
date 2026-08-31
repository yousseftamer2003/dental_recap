import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/core/networking/apis_strings.dart';
import 'package:dental_recap/features/auth/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  AuthRepo({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: request.email.trim(),
        password: request.password,
      );
      return LoginResponse(
        message: 'Welcome back',
        user: _toUser(credential.user!),
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_authMessage(e));
    }
  }

  Future<LoginResponse> register(LoginRequest request) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: request.email.trim(),
        password: request.password,
      );
      final user = _toUser(credential.user!);
      await _firestore.collection(ApisStrings.users).doc(user.id).set({
        'name': user.name,
        'handle': user.handle,
        'email': user.email,
      });
      return LoginResponse(message: 'Account created', user: user);
    } on FirebaseAuthException catch (e) {
      throw Exception(_authMessage(e));
    }
  }

  Future<void> logout() => _auth.signOut();

  UserModel _toUser(User user) {
    final email = user.email ?? '';
    final name = email.split('@').first;
    return UserModel(
      id: user.uid,
      name: name,
      handle: '@$name',
      email: email,
    );
  }

  String _authMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Wrong email or password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'Enter a valid email.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}
