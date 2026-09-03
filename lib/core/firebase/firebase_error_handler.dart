import 'dart:developer';

import 'package:dental_recap/core/constants/strings.dart';
import 'package:dental_recap/core/firebase/firebase_error_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static FirebaseErrorModel handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return FirebaseErrorModel(
        code: error.code,
        message: _authMessage(error),
      );
    }

    if (error is FirebaseException) {
      return FirebaseErrorModel(
        code: error.code,
        message: _firestoreMessage(error),
      );
    }

    log(error.toString());
    return FirebaseErrorModel(message: FirebaseErrorConstants.defaultError);
  }

  static String _authMessage(FirebaseAuthException error) {
    switch (error.code) {
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
      case 'network-request-failed':
        return FirebaseErrorConstants.noInternetError;
      default:
        return error.message ?? FirebaseErrorConstants.defaultError;
    }
  }

  static String _firestoreMessage(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return FirebaseErrorConstants.permissionDenied;
      case 'not-found':
        return FirebaseErrorConstants.notFound;
      case 'unavailable':
        return FirebaseErrorConstants.noInternetError;
      default:
        return error.message ?? FirebaseErrorConstants.defaultError;
    }
  }
}
