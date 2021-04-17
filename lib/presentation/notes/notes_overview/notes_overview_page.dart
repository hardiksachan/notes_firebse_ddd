import 'package:another_flushbar/flushbar_helper.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/auth/auth_state.dart';
import 'package:notes_firebse_ddd/application/notes/note_actor/note_actor_state.dart';
import 'package:notes_firebse_ddd/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:notes_firebse_ddd/presentation/routes/beam_locations.dart';
import 'package:notes_firebse_ddd/providers.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: authNotifierProvider,
      onChange: (BuildContext context, authState) {
        if (authState == null) return;
        authState as AuthState;
        authState.maybeMap(
            unauthenticated: (_) {
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                context.beamTo(SignInLocation());
              });
            },
            orElse: () {});
      },
      child: ProviderListener(
        provider: noteActorNotifierProvider,
        onChange: (BuildContext context, noteActorState) {
          if (noteActorState == null) return;
          noteActorState as NoteActorState;
          noteActorState.maybeMap(
            deleteFailure: (f) {
              FlushbarHelper.createError(
                message: f.noteFailure.map(
                  unexpected: (_) =>
                      'Unexpected error occurred while deleting, please contact support.',
                  insufficientPermission: (_) => 'Insufficient permissions ❌',
                  unableToUpdate: (_) => 'Impossible error',
                ),
              ).show(context);
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes Overview'),
            actions: [
              IconButton(
                  icon: const Icon(Icons.indeterminate_check_box),
                  onPressed: () {})
            ],
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read(authNotifierProvider.notifier).signOut();
              },
            ),
          ),
          body: NotesOverviewBodyWidgets(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: Navigate to note form
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
