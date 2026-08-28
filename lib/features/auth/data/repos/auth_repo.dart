import 'package:dental_recap/core/networking/api_constants.dart';
import 'package:dental_recap/features/auth/data/models/login_request.dart';
import 'package:dental_recap/features/auth/data/models/login_response.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  AuthRepo({Dio? dio})
    : _dio = dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              headers: {'Accept': 'application/json'},
            ),
          );

  final Dio _dio;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        ApiConstants.patientLogin,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        throw Exception(data['message']);
      }
      throw Exception('Login failed. Please try again.');
    }
  }
}
