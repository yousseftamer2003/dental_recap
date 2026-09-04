import 'dart:developer';

import 'package:dental_recap/core/firebase/firebase_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static FirebaseErrorModel handleError(dynamic e) {
    if (e is FirebaseAuthException) {
      return FirebaseErrorModel(message: _authMessage(e), code: e.code);
    }

    if (e is FirebaseException) {
      return FirebaseErrorModel(message: _firestoreMessage(e), code: e.code);
    }

    log('Error logging: ${e.toString()}');
    return FirebaseErrorModel(message: 'Something went wrong', code: 'unknown');
  }

  static String _authMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        return "User not found";
      case "wrong-password":
        return "Wrong password";
      case "invalid-email":
        return "Invalid email";
      case "user-disabled":
        return "User disabled";
      case "too-many-requests":
        return "Too many requests";
      case "network-request-failed":
        return "Network Error";
      case "email-already-in-use":
        return "Email already in use";
      default:
        return "Something went wrong";
    }
  }

  static String _firestoreMessage(FirebaseException e) {
    switch (e.code) {
      case "not-found":
        return "Not found";
      case "permission-denied":
        return "Permission denied";
      case "aborted":
        return "Aborted";
      default:
        return "Something went wrong";
    }
  }
}
