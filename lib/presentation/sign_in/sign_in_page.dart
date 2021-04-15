import 'package:flutter/material.dart';
import 'package:notes_firebse_ddd/presentation/core/responsive.dart';
import 'package:notes_firebse_ddd/presentation/sign_in/widgets/sign_in_decor.dart';
import 'package:notes_firebse_ddd/presentation/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
