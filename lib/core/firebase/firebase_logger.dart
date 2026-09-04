import 'package:dental_recap/core/firebase/firebase_error_model.dart';
import 'package:flutter/material.dart';

class FirebaseLogger {
  static void logRequest(String operation, {Map<String, dynamic>? data}){
    debugPrint('Firebase Request: $operation');
    if(data != null){
      debugPrint('Request Data: $data');
    }
  }


  static void logResponse(String operation, {dynamic data}){
    debugPrint('Firebase Response: $operation');
    if(data != null){
      debugPrint('Response Data: $data');
    }
  }


  static void logError(String operation, FirebaseErrorModel error){
    debugPrint('Firebase Error: $operation');
    debugPrint('Error: ${error.message}');
    debugPrint('Error Code: ${error.code}');
  }
}