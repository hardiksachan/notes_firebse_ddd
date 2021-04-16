import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_firebse_ddd/application/auth/auth_notifier.dart';
import 'package:notes_firebse_ddd/application/auth/sign_in_form/sign_in_form_notifier.dart';
import 'package:notes_firebse_ddd/application/notes/note_actor/note_actor_notifier.dart';
import 'package:notes_firebse_ddd/application/notes/note_form/note_form_notifier.dart';
import 'package:notes_firebse_ddd/application/notes/note_watcher/note_watcher_notifier.dart';
import 'package:notes_firebse_ddd/infrastructure/auth/firebase_auth_facade.dart';
import 'package:notes_firebse_ddd/infrastructure/notes/note_repository.dart';

/// To be used in dart only packages i.e Infrastructure Layer
final ProviderContainer providerContainer = ProviderContainer();

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final googleSignInProvider = Provider((ref) => GoogleSignIn(
    clientId:
        "689405323672-sehrbt7gd3gjuisbdd4v2nc0keua0kof.apps.googleusercontent.com"));

final firebaseAuthFacadeProvider = Provider<FirebaseAuthFacade>(
  (ref) => FirebaseAuthFacade(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInProvider),
  ),
);
final firestoreNoteRepository =
    Provider((ref) => NoteRepository(ref.watch(firestoreProvider)));

final signInFormNotifierProvider = StateNotifierProvider(
    (ref) => SignInFormNotifier(ref.watch(firebaseAuthFacadeProvider)));
final authNotifierProvider = StateNotifierProvider(
    (ref) => AuthNotifier(ref.watch(firebaseAuthFacadeProvider)));

final noteWatcherNotifierProvider = StateNotifierProvider(
    (ref) => NoteWatcherNotifier(ref.watch(firestoreNoteRepository)));
final noteActorNotifierProvider = StateNotifierProvider(
    (ref) => NoteActorNotifier(ref.watch(firestoreNoteRepository)));
final noteFormNotifierProvider = StateNotifierProvider(
    (ref) => NoteFormNotifier(ref.watch(firestoreNoteRepository)));
