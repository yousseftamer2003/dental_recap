class LoginResponse {
  final String status;
  final String message;
  final LoginData data;

  const LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class LoginData {
  final Patient patient;
  final String accessToken;

  const LoginData({
    required this.patient,
    required this.accessToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
    );
  }
}

class Patient {
  final int id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? city;
  final String? area;
  final num lat;
  final num lang;
  final String? avatar;
  final String status;
  final String role;
  final String createdAt;

  const Patient({
    required this.id,
    required this.fullName,
    this.phone,
    this.email,
    this.city,
    this.area,
    required this.lat,
    required this.lang,
    this.avatar,
    required this.status,
    required this.role,
    required this.createdAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      city: json['city'] as String?,
      area: json['area'] as String?,
      lat: json['lat'] as num,
      lang: json['lang'] as num,
      avatar: json['avatar'] as String?,
      status: json['status'] as String,
      role: json['role'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}
