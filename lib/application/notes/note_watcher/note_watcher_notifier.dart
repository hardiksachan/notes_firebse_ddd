import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebse_ddd/application/notes/note_watcher/note_watcher_state.dart';
import 'package:notes_firebse_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';
import 'package:notes_firebse_ddd/domain/notes/note_failure.dart';

class NoteWatcherNotifier extends StateNotifier<NoteWatcherState> {
  final INoteRepository _noteRepository;

  NoteWatcherNotifier(this._noteRepository)
      : super(const NoteWatcherState.initial());

  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _noteStreamSubscription;

  Future<void> watchAll() async {
    print('watching all');
    state = const NoteWatcherState.loadInProgress();
    await _noteStreamSubscription?.cancel();
    _noteStreamSubscription = _noteRepository
        .watchAll()
        .listen((failureOrNotes) => _notesReceived(failureOrNotes));
  }

  Future<void> watchUncompleted() async {
    print('watching uncompleted');
    state = const NoteWatcherState.loadInProgress();
    await _noteStreamSubscription?.cancel();
    _noteStreamSubscription = _noteRepository
        .watchUncompleted()
        .listen((failureOrNotes) => _notesReceived(failureOrNotes));
  }

  Future<void> _notesReceived(
      Either<NoteFailure, KtList<Note>> failureOrNotes) async {
    state = failureOrNotes.fold(
      (f) => NoteWatcherState.loadFailure(f),
      (r) => NoteWatcherState.loadSuccess(r),
    );
  }
}
