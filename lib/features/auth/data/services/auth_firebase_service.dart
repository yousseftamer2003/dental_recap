import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/core/constants/firebase_collections.dart';
import 'package:dental_recap/core/firebase/firebase_logger.dart';
import 'package:dental_recap/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  AuthFirebaseService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    FirebaseLogger.logRequest(
      'Auth.signInWithEmailAndPassword',
      data: {'email': email},
    );
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return _loadUserProfile(credential.user!);
  }

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseLogger.logRequest(
      'Auth.createUserWithEmailAndPassword',
      data: {'email': email, 'name': name},
    );
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final handle = _buildHandle(name);
    final user = UserModel(
      id: credential.user!.uid,
      name: name.trim(),
      handle: handle,
      email: email.trim(),
    );
    await _firestore.collection(FirebaseCollections.users).doc(user.id).set(
      user.toJson(),
    );
    return user;
  }

  Future<void> logout() async {
    FirebaseLogger.logRequest('Auth.signOut');
    await _auth.signOut();
  }

  Future<UserModel> _loadUserProfile(User user) async {
    final doc = await _firestore
        .collection(FirebaseCollections.users)
        .doc(user.uid)
        .get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson({'id': user.uid, ...doc.data()!});
    }

    return _fallbackUserFromAuth(user);
  }

  UserModel _fallbackUserFromAuth(User user) {
    final email = user.email ?? '';
    final name = email.split('@').first;
    return UserModel(
      id: user.uid,
      name: name,
      handle: '@$name',
      email: email,
    );
  }

  String _buildHandle(String name) {
    final normalized = name.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return normalized.isEmpty ? '@user' : '@$normalized';
  }
}
