// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _LoginLoading value)?  loginLoading,TResult Function( _LoginSuccess value)?  loginSuccess,TResult Function( _LoginFailure value)?  loginFailure,TResult Function( _SignupLoading value)?  signupLoading,TResult Function( _SignupSuccess value)?  signupSuccess,TResult Function( _SignupFailure value)?  signupFailure,TResult Function( _LogoutLoading value)?  logoutLoading,TResult Function( _LogoutSuccess value)?  logoutSuccess,TResult Function( _LogoutFailure value)?  logoutFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoginLoading() when loginLoading != null:
return loginLoading(_that);case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _LoginFailure() when loginFailure != null:
return loginFailure(_that);case _SignupLoading() when signupLoading != null:
return signupLoading(_that);case _SignupSuccess() when signupSuccess != null:
return signupSuccess(_that);case _SignupFailure() when signupFailure != null:
return signupFailure(_that);case _LogoutLoading() when logoutLoading != null:
return logoutLoading(_that);case _LogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case _LogoutFailure() when logoutFailure != null:
return logoutFailure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _LoginLoading value)  loginLoading,required TResult Function( _LoginSuccess value)  loginSuccess,required TResult Function( _LoginFailure value)  loginFailure,required TResult Function( _SignupLoading value)  signupLoading,required TResult Function( _SignupSuccess value)  signupSuccess,required TResult Function( _SignupFailure value)  signupFailure,required TResult Function( _LogoutLoading value)  logoutLoading,required TResult Function( _LogoutSuccess value)  logoutSuccess,required TResult Function( _LogoutFailure value)  logoutFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _LoginLoading():
return loginLoading(_that);case _LoginSuccess():
return loginSuccess(_that);case _LoginFailure():
return loginFailure(_that);case _SignupLoading():
return signupLoading(_that);case _SignupSuccess():
return signupSuccess(_that);case _SignupFailure():
return signupFailure(_that);case _LogoutLoading():
return logoutLoading(_that);case _LogoutSuccess():
return logoutSuccess(_that);case _LogoutFailure():
return logoutFailure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _LoginLoading value)?  loginLoading,TResult? Function( _LoginSuccess value)?  loginSuccess,TResult? Function( _LoginFailure value)?  loginFailure,TResult? Function( _SignupLoading value)?  signupLoading,TResult? Function( _SignupSuccess value)?  signupSuccess,TResult? Function( _SignupFailure value)?  signupFailure,TResult? Function( _LogoutLoading value)?  logoutLoading,TResult? Function( _LogoutSuccess value)?  logoutSuccess,TResult? Function( _LogoutFailure value)?  logoutFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoginLoading() when loginLoading != null:
return loginLoading(_that);case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that);case _LoginFailure() when loginFailure != null:
return loginFailure(_that);case _SignupLoading() when signupLoading != null:
return signupLoading(_that);case _SignupSuccess() when signupSuccess != null:
return signupSuccess(_that);case _SignupFailure() when signupFailure != null:
return signupFailure(_that);case _LogoutLoading() when logoutLoading != null:
return logoutLoading(_that);case _LogoutSuccess() when logoutSuccess != null:
return logoutSuccess(_that);case _LogoutFailure() when logoutFailure != null:
return logoutFailure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loginLoading,TResult Function( UserEntity user)?  loginSuccess,TResult Function( String message)?  loginFailure,TResult Function()?  signupLoading,TResult Function( UserEntity user)?  signupSuccess,TResult Function( String message)?  signupFailure,TResult Function()?  logoutLoading,TResult Function()?  logoutSuccess,TResult Function( String message)?  logoutFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoginLoading() when loginLoading != null:
return loginLoading();case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that.user);case _LoginFailure() when loginFailure != null:
return loginFailure(_that.message);case _SignupLoading() when signupLoading != null:
return signupLoading();case _SignupSuccess() when signupSuccess != null:
return signupSuccess(_that.user);case _SignupFailure() when signupFailure != null:
return signupFailure(_that.message);case _LogoutLoading() when logoutLoading != null:
return logoutLoading();case _LogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case _LogoutFailure() when logoutFailure != null:
return logoutFailure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loginLoading,required TResult Function( UserEntity user)  loginSuccess,required TResult Function( String message)  loginFailure,required TResult Function()  signupLoading,required TResult Function( UserEntity user)  signupSuccess,required TResult Function( String message)  signupFailure,required TResult Function()  logoutLoading,required TResult Function()  logoutSuccess,required TResult Function( String message)  logoutFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _LoginLoading():
return loginLoading();case _LoginSuccess():
return loginSuccess(_that.user);case _LoginFailure():
return loginFailure(_that.message);case _SignupLoading():
return signupLoading();case _SignupSuccess():
return signupSuccess(_that.user);case _SignupFailure():
return signupFailure(_that.message);case _LogoutLoading():
return logoutLoading();case _LogoutSuccess():
return logoutSuccess();case _LogoutFailure():
return logoutFailure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loginLoading,TResult? Function( UserEntity user)?  loginSuccess,TResult? Function( String message)?  loginFailure,TResult? Function()?  signupLoading,TResult? Function( UserEntity user)?  signupSuccess,TResult? Function( String message)?  signupFailure,TResult? Function()?  logoutLoading,TResult? Function()?  logoutSuccess,TResult? Function( String message)?  logoutFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoginLoading() when loginLoading != null:
return loginLoading();case _LoginSuccess() when loginSuccess != null:
return loginSuccess(_that.user);case _LoginFailure() when loginFailure != null:
return loginFailure(_that.message);case _SignupLoading() when signupLoading != null:
return signupLoading();case _SignupSuccess() when signupSuccess != null:
return signupSuccess(_that.user);case _SignupFailure() when signupFailure != null:
return signupFailure(_that.message);case _LogoutLoading() when logoutLoading != null:
return logoutLoading();case _LogoutSuccess() when logoutSuccess != null:
return logoutSuccess();case _LogoutFailure() when logoutFailure != null:
return logoutFailure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AuthState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _LoginLoading implements AuthState {
  const _LoginLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loginLoading()';
}


}




/// @nodoc


class _LoginSuccess implements AuthState {
  const _LoginSuccess(this.user);
  

 final  UserEntity user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginSuccessCopyWith<_LoginSuccess> get copyWith => __$LoginSuccessCopyWithImpl<_LoginSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.loginSuccess(user: $user)';
}


}

/// @nodoc
abstract mixin class _$LoginSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoginSuccessCopyWith(_LoginSuccess value, $Res Function(_LoginSuccess) _then) = __$LoginSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class __$LoginSuccessCopyWithImpl<$Res>
    implements _$LoginSuccessCopyWith<$Res> {
  __$LoginSuccessCopyWithImpl(this._self, this._then);

  final _LoginSuccess _self;
  final $Res Function(_LoginSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_LoginSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class _LoginFailure implements AuthState {
  const _LoginFailure(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFailureCopyWith<_LoginFailure> get copyWith => __$LoginFailureCopyWithImpl<_LoginFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.loginFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoginFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LoginFailureCopyWith(_LoginFailure value, $Res Function(_LoginFailure) _then) = __$LoginFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoginFailureCopyWithImpl<$Res>
    implements _$LoginFailureCopyWith<$Res> {
  __$LoginFailureCopyWithImpl(this._self, this._then);

  final _LoginFailure _self;
  final $Res Function(_LoginFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoginFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignupLoading implements AuthState {
  const _SignupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.signupLoading()';
}


}




/// @nodoc


class _SignupSuccess implements AuthState {
  const _SignupSuccess(this.user);
  

 final  UserEntity user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupSuccessCopyWith<_SignupSuccess> get copyWith => __$SignupSuccessCopyWithImpl<_SignupSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.signupSuccess(user: $user)';
}


}

/// @nodoc
abstract mixin class _$SignupSuccessCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$SignupSuccessCopyWith(_SignupSuccess value, $Res Function(_SignupSuccess) _then) = __$SignupSuccessCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});




}
/// @nodoc
class __$SignupSuccessCopyWithImpl<$Res>
    implements _$SignupSuccessCopyWith<$Res> {
  __$SignupSuccessCopyWithImpl(this._self, this._then);

  final _SignupSuccess _self;
  final $Res Function(_SignupSuccess) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_SignupSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}


}

/// @nodoc


class _SignupFailure implements AuthState {
  const _SignupFailure(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupFailureCopyWith<_SignupFailure> get copyWith => __$SignupFailureCopyWithImpl<_SignupFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.signupFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SignupFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$SignupFailureCopyWith(_SignupFailure value, $Res Function(_SignupFailure) _then) = __$SignupFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SignupFailureCopyWithImpl<$Res>
    implements _$SignupFailureCopyWith<$Res> {
  __$SignupFailureCopyWithImpl(this._self, this._then);

  final _SignupFailure _self;
  final $Res Function(_SignupFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SignupFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LogoutLoading implements AuthState {
  const _LogoutLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogoutLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.logoutLoading()';
}


}




/// @nodoc


class _LogoutSuccess implements AuthState {
  const _LogoutSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogoutSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.logoutSuccess()';
}


}




/// @nodoc


class _LogoutFailure implements AuthState {
  const _LogoutFailure(this.message);
  

 final  String message;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogoutFailureCopyWith<_LogoutFailure> get copyWith => __$LogoutFailureCopyWithImpl<_LogoutFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogoutFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AuthState.logoutFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LogoutFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$LogoutFailureCopyWith(_LogoutFailure value, $Res Function(_LogoutFailure) _then) = __$LogoutFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LogoutFailureCopyWithImpl<$Res>
    implements _$LogoutFailureCopyWith<$Res> {
  __$LogoutFailureCopyWithImpl(this._self, this._then);

  final _LogoutFailure _self;
  final $Res Function(_LogoutFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LogoutFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
