import 'package:dental_recap/core/firebase/firebase_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_result.freezed.dart';

@freezed
abstract class FirebaseResult<T> with _$FirebaseResult<T> {
  factory FirebaseResult.success(T data) = Success<T>;
  const factory FirebaseResult.failure(FirebaseErrorModel error) = Failure<T>;
}
