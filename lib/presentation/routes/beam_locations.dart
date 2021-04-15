import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:notes_firebse_ddd/presentation/notes/notes_placeholder.dart';
import 'package:notes_firebse_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:notes_firebse_ddd/presentation/splash/splash_page.dart';

class SignInLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('sign-in'),
          child: SignInPage(),
        )
      ];

  @override
  List<String> get pathBlueprints => ['/sign-in'];
}

class SplashLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('home'),
          child: SplashPage(),
        )
      ];

  @override
  List<String> get pathBlueprints => ['/'];
}

class NotesLocation extends BeamLocation {
  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('notes'),
          child: NotesPlaceholderPage(),
        )
      ];

  @override
  List<String> get pathBlueprints => ['/notes'];
}
