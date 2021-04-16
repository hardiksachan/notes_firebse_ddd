import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebse_ddd/domain/core/failures.dart';
import 'package:notes_firebse_ddd/domain/core/value_object.dart';
import 'package:notes_firebse_ddd/domain/notes/todo_item.dart';
import 'package:notes_firebse_ddd/domain/notes/value_objects.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const factory Note({
    required UniqueID id,
    required NoteBody body,
    required NoteColor color,
    required List3<TodoItem> todos,
  }) = _Note;

  const Note._();

  factory Note.empty() => Note(
        id: UniqueID(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors[0]),
        todos: List3(emptyList()),
      );

  Option<ValueFailure<dynamic>> get failureOption => body.failureOrUnit
      .andThen(todos.failureOrUnit)
      .andThen(
        todos
            .getOrCrash()
            .map((todoItem) => todoItem.failureOption)
            .filter((o) => o.isSome())
            .getOrElse(0, (_) => none())
            .fold(() => right(unit), (a) => left(a)),
      )
      .fold((f) => some(f), (_) => none());
}
