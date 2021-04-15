import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SignInDecor extends StatelessWidget {
  const SignInDecor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebsafeSvg.asset('assets/svg/notes.svg', width: 180);
  }
}
