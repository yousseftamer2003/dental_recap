import 'package:dental_recap/core/firebase/firebase_error_handler.dart';
import 'package:dental_recap/core/firebase/firebase_logger.dart';
import 'package:dental_recap/core/firebase/firebase_result.dart';

Future<FirebaseResult<T>> safeFirebaseCall<T>(
  String operation,
  Future<T> Function() call,
) async {
  FirebaseLogger.logRequest(operation);
  try {
    final data = await call();
    FirebaseLogger.logResponse(operation, data: data);
    return FirebaseResult.success(data);
  } catch (e) {
    final mappedError = FirebaseErrorHandler.handleError(e);
    FirebaseLogger.logError(operation, mappedError);
    return FirebaseResult.failure(mappedError);
  }
}
