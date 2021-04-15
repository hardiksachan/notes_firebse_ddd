// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ValueFailureTearOff {
  const _$ValueFailureTearOff();

  _Auth<T> auth<T>(AuthValueFailure<T> authFailure) {
    return _Auth<T>(
      authFailure,
    );
  }
}

/// @nodoc
const $ValueFailure = _$ValueFailureTearOff();

/// @nodoc
mixin _$ValueFailure<T> {
  AuthValueFailure<T> get authFailure => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthValueFailure<T> authFailure) auth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Auth<T> value) auth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Auth<T> value)? auth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValueFailureCopyWith<T, ValueFailure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValueFailureCopyWith<T, $Res> {
  factory $ValueFailureCopyWith(
          ValueFailure<T> value, $Res Function(ValueFailure<T>) then) =
      _$ValueFailureCopyWithImpl<T, $Res>;
  $Res call({AuthValueFailure<T> authFailure});

  $AuthValueFailureCopyWith<T, $Res> get authFailure;
}

/// @nodoc
class _$ValueFailureCopyWithImpl<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  _$ValueFailureCopyWithImpl(this._value, this._then);

  final ValueFailure<T> _value;
  // ignore: unused_field
  final $Res Function(ValueFailure<T>) _then;

  @override
  $Res call({
    Object? authFailure = freezed,
  }) {
    return _then(_value.copyWith(
      authFailure: authFailure == freezed
          ? _value.authFailure
          : authFailure // ignore: cast_nullable_to_non_nullable
              as AuthValueFailure<T>,
    ));
  }

  @override
  $AuthValueFailureCopyWith<T, $Res> get authFailure {
    return $AuthValueFailureCopyWith<T, $Res>(_value.authFailure, (value) {
      return _then(_value.copyWith(authFailure: value));
    });
  }
}

/// @nodoc
abstract class _$AuthCopyWith<T, $Res>
    implements $ValueFailureCopyWith<T, $Res> {
  factory _$AuthCopyWith(_Auth<T> value, $Res Function(_Auth<T>) then) =
      __$AuthCopyWithImpl<T, $Res>;
  @override
  $Res call({AuthValueFailure<T> authFailure});

  @override
  $AuthValueFailureCopyWith<T, $Res> get authFailure;
}

/// @nodoc
class __$AuthCopyWithImpl<T, $Res> extends _$ValueFailureCopyWithImpl<T, $Res>
    implements _$AuthCopyWith<T, $Res> {
  __$AuthCopyWithImpl(_Auth<T> _value, $Res Function(_Auth<T>) _then)
      : super(_value, (v) => _then(v as _Auth<T>));

  @override
  _Auth<T> get _value => super._value as _Auth<T>;

  @override
  $Res call({
    Object? authFailure = freezed,
  }) {
    return _then(_Auth<T>(
      authFailure == freezed
          ? _value.authFailure
          : authFailure // ignore: cast_nullable_to_non_nullable
              as AuthValueFailure<T>,
    ));
  }
}

/// @nodoc
class _$_Auth<T> implements _Auth<T> {
  const _$_Auth(this.authFailure);

  @override
  final AuthValueFailure<T> authFailure;

  @override
  String toString() {
    return 'ValueFailure<$T>.auth(authFailure: $authFailure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Auth<T> &&
            (identical(other.authFailure, authFailure) ||
                const DeepCollectionEquality()
                    .equals(other.authFailure, authFailure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(authFailure);

  @JsonKey(ignore: true)
  @override
  _$AuthCopyWith<T, _Auth<T>> get copyWith =>
      __$AuthCopyWithImpl<T, _Auth<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthValueFailure<T> authFailure) auth,
  }) {
    return auth(authFailure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthValueFailure<T> authFailure)? auth,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(authFailure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Auth<T> value) auth,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Auth<T> value)? auth,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class _Auth<T> implements ValueFailure<T> {
  const factory _Auth(AuthValueFailure<T> authFailure) = _$_Auth<T>;

  @override
  AuthValueFailure<T> get authFailure => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuthCopyWith<T, _Auth<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
