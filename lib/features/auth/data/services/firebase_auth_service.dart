import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/core/firebase/firebase_logger.dart';
import 'package:dental_recap/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;


  Future<UserModel> login({required String email, required String password}) async {
    FirebaseLogger.logRequest(
      'Auth - Login',
      data: {
        email: email.trim(),
        password: password,
      },
    );

    final credentials = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

    return _loadUserProfile(credentials.user!);
  }

  Future<UserModel> _loadUserProfile(User user) async{
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }

    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  Future logout() async{
    FirebaseLogger.logRequest('Auth - Logout');
    await _auth.signOut();
  }

  Future<UserModel> signUp({required String name, required String email, required String password}) async{
    FirebaseLogger.logRequest(
      'Auth - Sign Up',
      data: {
        name: name.trim(),
        email: email.trim(),
        password: password,
      },
    );
    final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = UserModel(
      id: credentials.user!.uid,
      name: name.trim(),
      email: email.trim(),
    );

    await _firestore.collection('users').doc(user.id).set(user.toJson());

    return user;
  }
}
