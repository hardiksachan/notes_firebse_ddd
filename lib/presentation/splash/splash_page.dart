import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/auth/auth_state.dart';
import 'package:notes_firebse_ddd/presentation/routes/beam_locations.dart';
import 'package:notes_firebse_ddd/providers.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final notifier = watch(authNotifierProvider.notifier);
          final state = watch(authNotifierProvider) as AuthState;

          WidgetsBinding.instance!.addPostFrameCallback((_) {
            state.map(
                initial: (_) => notifier.checkAuth(),
                authenticated: (_) {
                  context.beamTo(NotesLocation());
                },
                unauthenticated: (_) => context.beamTo(SignInLocation()));
          });
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
