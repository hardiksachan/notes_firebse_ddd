import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebse_ddd/domain/core/value_object.dart';
import 'package:notes_firebse_ddd/domain/notes/todo_item.dart';
import 'package:notes_firebse_ddd/domain/notes/value_objects.dart';

part 'todo_item_presentation_classes.freezed.dart';

@freezed
abstract class TodoItemPrimitive implements _$TodoItemPrimitive {
  const factory TodoItemPrimitive({
    required UniqueID id,
    required String name,
    required bool done,
  }) = _TodoItemPrimitive;

  const TodoItemPrimitive._();

  factory TodoItemPrimitive.empty() => TodoItemPrimitive(
        id: UniqueID(),
        name: '',
        done: false,
      );

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) => TodoItemPrimitive(
        id: todoItem.id,
        name: todoItem.name.getOrCrash(),
        done: todoItem.done,
      );

  TodoItem toDomain() => TodoItem(
        id: id,
        name: TodoName(name),
        done: done,
      );
}
