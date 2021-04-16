import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/notes/note_actor/note_actor_state.dart';
import 'package:notes_firebse_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';

class NoteActorNotifier extends StateNotifier<NoteActorState> {
  final INoteRepository _noteRepository;

  NoteActorNotifier(this._noteRepository)
      : super(const NoteActorState.initial());

  Future<void> deleteNote(Note note) async {
    state = const NoteActorState.actionInProgress();
    final possibleFailure = await _noteRepository.delete(note);
    state = possibleFailure.fold(
      (f) => NoteActorState.deleteFailure(f),
      (_) => const NoteActorState.deleteSuccess(),
    );
  }
}
