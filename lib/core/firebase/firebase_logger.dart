import 'package:flutter/foundation.dart';

/// Debug-only logger for Firebase operations — similar role to PrettyDioLogger.
class FirebaseLogger {
  static void logRequest(String operation, {Map<String, dynamic>? data}) {
    if (!kDebugMode) return;
    debugPrint('🔥 Firebase REQUEST | $operation');
    if (data != null) {
      debugPrint('   Payload: $data');
    }
  }

  static void logResponse(String operation, Object? result) {
    if (!kDebugMode) return;
    debugPrint('✅ Firebase RESPONSE | $operation');
    debugPrint('   Result: $result');
  }

  static void logError(String operation, String message) {
    if (!kDebugMode) return;
    debugPrint('❌ Firebase ERROR | $operation');
    debugPrint('   Message: $message');
  }
}
