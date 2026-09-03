// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseErrorModel _$FirebaseErrorModelFromJson(Map<String, dynamic> json) =>
    FirebaseErrorModel(
      message: json['message'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$FirebaseErrorModelToJson(FirebaseErrorModel instance) =>
    <String, dynamic>{'message': instance.message, 'code': instance.code};
