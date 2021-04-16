import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebse_ddd/domain/core/failures.dart';
import 'package:notes_firebse_ddd/domain/core/value_object.dart';
import 'package:notes_firebse_ddd/domain/notes/value_objects.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
  const TodoItem._();

  const factory TodoItem({
    required UniqueID id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueID(),
        name: TodoName(''),
        done: false,
      );

  Option<ValueFailure<dynamic>> get failureOption => name.value.fold(
        (f) => some(f),
        (_) => none(),
      );
}
