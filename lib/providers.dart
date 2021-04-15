import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_firebse_ddd/application/auth/sign_in_form/sign_in_form_notifier.dart';
import 'package:notes_firebse_ddd/infrastructure/auth/firebase_auth_facade.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider((ref) => GoogleSignIn(
    clientId:
        "689405323672-sehrbt7gd3gjuisbdd4v2nc0keua0kof.apps.googleusercontent.com"));

final firebaseAuthFacadeProvider = Provider<FirebaseAuthFacade>(
  (ref) => FirebaseAuthFacade(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInProvider),
  ),
);

final signInFormNotifierProvider = StateNotifierProvider(
    (ref) => SignInFormNotifier(ref.watch(firebaseAuthFacadeProvider)));
