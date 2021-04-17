import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/notes/note_watcher/note_watcher_notifier.dart';
import 'package:notes_firebse_ddd/application/notes/note_watcher/note_watcher_state.dart';
import 'package:notes_firebse_ddd/providers.dart';

class NotesOverviewBodyWidgets extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('Rendering Notes Overview');
    final NoteWatcherState noteWatcherState =
        watch(noteWatcherNotifierProvider) as NoteWatcherState;
    final NoteWatcherNotifier noteWatcherNotifier =
        watch(noteWatcherNotifierProvider.notifier);
    return noteWatcherState.map(
      initial: (_) {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          noteWatcherNotifier.watchAll();
        });
        return Container(
          color: Colors.brown,
          width: 200,
          height: 200,
        );
      },
      loadInProgress: (_) => const Center(child: CircularProgressIndicator()),
      loadSuccess: (state) {
        return ListView.builder(
            itemCount: state.notes.size,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              if (note.failureOption.isSome()) {
                return Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                );
              } else {
                return Container(
                  color: Colors.green,
                  width: 100,
                  height: 100,
                );
              }
            });
      },
      loadFailure: (state) {
        print(state.noteFailure.toString());
        return Container(
          color: Colors.yellow,
          width: 200,
          height: 200,
        );
      },
    );
  }
}
