import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';
import 'package:notes_firebse_ddd/domain/notes/note_failure.dart';

part 'note_form_state.freezed.dart';

@freezed
abstract class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    required Note note,
    required bool showErrorMessages,
    required bool isSaving,
    required Option<Either<NoteFailure, Unit>> saveFailureOrSuccessOption,
    required bool isEditing,
  }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
        note: Note.empty(),
        showErrorMessages: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
        isEditing: false,
      );
}
