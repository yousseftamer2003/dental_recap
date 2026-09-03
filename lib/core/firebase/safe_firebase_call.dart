import 'package:dental_recap/core/firebase/firebase_error_handler.dart';
import 'package:dental_recap/core/firebase/firebase_logger.dart';
import 'package:dental_recap/core/firebase/firebase_result.dart';

/// Wraps an async Firebase call and returns [FirebaseResult.success] or
/// [FirebaseResult.failure]. Use this in repositories instead of manual try/catch.
Future<FirebaseResult<T>> safeFirebaseCall<T>(
  String operation,
  Future<T> Function() call,
) async {
  FirebaseLogger.logRequest(operation);
  try {
    final data = await call();
    FirebaseLogger.logResponse(operation, data);
    return FirebaseResult.success(data);
  } catch (error) {
    final mapped = FirebaseErrorHandler.handle(error);
    FirebaseLogger.logError(operation, mapped.displayMessage);
    return FirebaseResult.failure(mapped);
  }
}
