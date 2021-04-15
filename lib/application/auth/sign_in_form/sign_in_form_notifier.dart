import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/auth/sign_in_form/sign_in_form_state.dart';
import 'package:notes_firebse_ddd/domain/auth/auth_failure.dart';
import 'package:notes_firebse_ddd/domain/auth/i_auth_facade.dart';
import 'package:notes_firebse_ddd/domain/auth/value_objects.dart';

class SignInFormNotifier extends StateNotifier<SignInFormState> {
  final IAuthFacade _authFacade;

  EmailAddress get emailAddressVO => state.emailAddress;

  Password get passwordVO => state.password;

  SignInFormNotifier(this._authFacade) : super(SignInFormState.initial());

  Future<void> updateEmail(String emailStr) async {
    state = state.copyWith(
      emailAddress: EmailAddress(emailStr),
      authFailureOrSuccessOption: none(),
    );
  }

  Future<void> updatePassword(String passwordStr) async {
    state = state.copyWith(
      password: Password(passwordStr),
      authFailureOrSuccessOption: none(),
    );
  }

  Future<void> registerWithEmailAndPassword() async {
    _performActionOnAuthFacadeWithEmailAndPassword(
      _authFacade.registerWithEmailAndPassword,
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    _performActionOnAuthFacadeWithEmailAndPassword(
      _authFacade.signInWithEmailAndPassword,
    );
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(
      isSubmitting: true,
      authFailureOrSuccessOption: none(),
    );

    final failureOrSuccess = await _authFacade.signInWithGoogle();

    state = state.copyWith(
      isSubmitting: false,
      authFailureOrSuccessOption: some(failureOrSuccess),
    );
  }

  Future<void> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  ) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    Either<AuthFailure, Unit>? _failureOrSuccess;

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      _failureOrSuccess = await forwardedCall(
          emailAddress: state.emailAddress, password: state.password);
    }
    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(_failureOrSuccess),
    );
  }
}
