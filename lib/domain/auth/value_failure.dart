import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
abstract class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;
  const factory AuthValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;
}
