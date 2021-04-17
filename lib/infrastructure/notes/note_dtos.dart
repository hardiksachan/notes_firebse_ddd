import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebse_ddd/domain/core/value_object.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';
import 'package:notes_firebse_ddd/domain/notes/todo_item.dart';
import 'package:notes_firebse_ddd/domain/notes/value_objects.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

@freezed
abstract class NoteDTO implements _$NoteDTO {
  const factory NoteDTO({
    required String body,
    required int color,
    required List<TodoItemDTO> todos,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
    @JsonKey(ignore: true) String? id,
  }) = _NoteDTO;
  //@JsonKey(ignore: true) for id, if id in nullable
  const NoteDTO._();

  factory NoteDTO.fromDomain(Note note) => NoteDTO(
        id: note.id.getOrCrash(),
        body: note.body.getOrCrash(),
        color: note.color.getOrCrash().value,
        todos: note.todos
            .getOrCrash()
            .map(
              (todoItem) => TodoItemDTO.fromDomain(todoItem),
            )
            .asList(),
        serverTimeStamp: FieldValue.serverTimestamp(),
      );

  Note toDomain() => Note(
        id: UniqueID.fromUniqueString(id!),
        body: NoteBody(body),
        color: NoteColor(Color(color)),
        todos:
            List3(todos.map((todoTdo) => todoTdo.toDomain()).toImmutableList()),
      );

  factory NoteDTO.fromJson(Map<String, dynamic> json) =>
      _$NoteDTOFromJson(json);

  factory NoteDTO.fromFirestore(DocumentSnapshot doc) =>
      NoteDTO.fromJson(doc.data()!).copyWith(id: doc.id);

  Map<String, dynamic> toFirestoreJson() {
    final json = toJson();
    json.remove('id');
    return json;
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) => FieldValue.serverTimestamp();

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class TodoItemDTO implements _$TodoItemDTO {
  const factory TodoItemDTO({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDTO;

  const TodoItemDTO._();

  factory TodoItemDTO.fromDomain(TodoItem todoItem) => TodoItemDTO(
        id: todoItem.id.getOrCrash(),
        name: todoItem.name.getOrCrash(),
        done: todoItem.done,
      );

  TodoItem toDomain() => TodoItem(
        id: UniqueID.fromUniqueString(id),
        name: TodoName(name),
        done: done,
      );

  factory TodoItemDTO.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDTOFromJson(json);
}
