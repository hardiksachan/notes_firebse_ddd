import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebse_ddd/application/notes/note_form/note_form_state.dart';
import 'package:notes_firebse_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';
import 'package:notes_firebse_ddd/domain/notes/note_failure.dart';
import 'package:notes_firebse_ddd/domain/notes/value_objects.dart';
import 'package:notes_firebse_ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

class NoteFormNotifier extends StateNotifier<NoteFormState> {
  final INoteRepository _noteRepository;

  NoteFormNotifier(this._noteRepository) : super(NoteFormState.initial());

  Future<void> initialize(Note? note) async {
    if (note == null) return;
    state = state.copyWith(
      note: note,
      isEditing: true,
    );
  }

  Future<void> updateBody(String body) async {
    state = state.copyWith(
      note: state.note.copyWith(
        body: NoteBody(body),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  Future<void> updateColor(Color color) async {
    state = state.copyWith(
      note: state.note.copyWith(
        color: NoteColor(color),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  Future<void> updateTodos(KtList<TodoItemPrimitive> todos) async {
    state = state.copyWith(
      note: state.note.copyWith(
        todos: List3(
          todos.map((todo) => todo.toDomain()),
        ),
      ),
      saveFailureOrSuccessOption: none(),
    );
  }

  Future<void> save() async {
    state = state.copyWith(
      isSaving: true,
      saveFailureOrSuccessOption: none(),
    );

    Either<NoteFailure, Unit>? failureOrSuccess;

    if (state.note.failureOption.isNone()) {
      failureOrSuccess = state.isEditing
          ? await _noteRepository.update(state.note)
          : await _noteRepository.create(state.note);
    }

    state = state.copyWith(
      isSaving: false,
      showErrorMessages: true,
      saveFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
