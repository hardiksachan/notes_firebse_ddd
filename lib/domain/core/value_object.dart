import 'package:dartz/dartz.dart';
import 'package:notes_firebse_ddd/domain/core/failures.dart';

import 'errors.dart';

abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), (r) => r);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Value($value)';
  }
}
