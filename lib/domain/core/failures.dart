import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebse_ddd/domain/auth/value_failure.dart';
import 'package:notes_firebse_ddd/domain/notes/value_failure.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> authFailure) = _Auth<T>;
  const factory ValueFailure.note(NoteValueFailure<T> noteFailure) = _Note<T>;
}
