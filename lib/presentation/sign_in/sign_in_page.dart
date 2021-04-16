import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/auth/auth_state.dart';
import 'package:notes_firebse_ddd/presentation/core/responsive.dart';
import 'package:notes_firebse_ddd/presentation/routes/beam_locations.dart';
import 'package:notes_firebse_ddd/presentation/sign_in/widgets/sign_in_decor.dart';
import 'package:notes_firebse_ddd/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:notes_firebse_ddd/providers.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: authNotifierProvider,
      onChange: (BuildContext context, authState) {
        if (authState == null) return;
        authState as AuthState;
        authState.maybeMap(
            authenticated: (_) {
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                context.beamTo(NotesLocation());
              });
            },
            orElse: () {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: const Responsive(
            mobile: NarrowLayout(),
            tablet: WideLayout(),
            desktop: WideLayout(),
          ),
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 2,
          child: SignInDecor(),
        ),
        const SizedBox(height: 32),
        Expanded(
          flex: 5,
          child: SingleChildScrollView(child: SignInForm()),
        )
      ],
    );
  }
}

class WideLayout extends StatelessWidget {
  const WideLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: (MediaQuery.of(context).size.height > 600)
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        if (MediaQuery.of(context).size.height > 600)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 128),
            child: Text(
              'Notes App',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Expanded(
              flex: 5,
              child: SignInDecor(),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 120, maxWidth: 600),
                    child: Container(
                      child: SignInForm(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
