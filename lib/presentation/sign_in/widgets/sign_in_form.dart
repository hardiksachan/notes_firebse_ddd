import 'package:another_flushbar/flushbar_helper.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_firebse_ddd/application/auth/sign_in_form/sign_in_form_state.dart';
import 'package:notes_firebse_ddd/presentation/core/responsive.dart';
import 'package:notes_firebse_ddd/presentation/routes/beam_locations.dart';
import 'package:notes_firebse_ddd/providers.dart';

class SignInForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(signInFormNotifierProvider) as SignInFormState;
    return ProviderListener(
      provider: signInFormNotifierProvider,
      onChange: (BuildContext context, value) {
        if (value == null) return;
        value as SignInFormState;
        value.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (l) {
              FlushbarHelper.createError(
                message: l.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
              ).show(context);
            },
            (r) {
              FlushbarHelper.createSuccess(
                message: 'Logged In successfully',
              ).show(context);
              context.beamTo(NotesLocation());
              context.read(authNotifierProvider.notifier).checkAuth();
            },
          ),
        );
      },
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: !Responsive.isDesktop(context)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email',
                errorText: state.showErrorMessages
                    ? state.emailAddress.value.fold(
                        (f) => f.maybeMap(
                              auth: (a) => a.authFailure.maybeMap(
                                  invalidEmail: (_) => 'Invalid Email',
                                  orElse: () => null),
                              orElse: () => null,
                            ),
                        (r) => null)
                    : null,
              ),
              autocorrect: false,
              onChanged: (value) => context
                  .read(signInFormNotifierProvider.notifier)
                  .updateEmail(value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Password',
                errorText: state.showErrorMessages
                    ? state.password.value.fold(
                        (f) => f.maybeMap(
                              auth: (a) => a.authFailure.maybeMap(
                                  shortPassword: (_) => 'Short Password',
                                  orElse: () => null),
                              orElse: () => null,
                            ),
                        (r) => null)
                    : null,
              ),
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => context
                  .read(signInFormNotifierProvider.notifier)
                  .updatePassword(value),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey.shade900,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    onPressed: () {
                      context
                          .read(signInFormNotifierProvider.notifier)
                          .signInWithEmailAndPassword();
                    },
                    child: const Text('SIGN IN'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey.shade900,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    onPressed: () {
                      context
                          .read(signInFormNotifierProvider.notifier)
                          .registerWithEmailAndPassword();
                    },
                    child: const Text('REGISTER'),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black87,
                padding: const EdgeInsets.all(16.0),
              ),
              onPressed: () {
                context
                    .read(signInFormNotifierProvider.notifier)
                    .signInWithGoogle();
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: FaIcon(FontAwesomeIcons.google),
                  ),
                  Expanded(
                    child: Text(
                      'SIGN IN WITH GOOGLE',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            if (state.isSubmitting) ...[
              const SizedBox(height: 8),
              const LinearProgressIndicator()
            ]
          ],
        ),
      ),
    );
  }
}
