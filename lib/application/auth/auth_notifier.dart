import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_firebse_ddd/application/auth/auth_state.dart';
import 'package:notes_firebse_ddd/domain/auth/i_auth_facade.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthFacade _authFacade;

  AuthNotifier(this._authFacade) : super(const AuthState.initial());

  Future<void> checkAuth() async {
    final userOption = await _authFacade.getSignedInUser();
    state = userOption.fold(
      () => const AuthState.unauthenticated(),
      (_) => const AuthState.authenticated(),
    );
  }

  Future<void> signOut() async {
    await _authFacade.signOut();
    state = const AuthState.unauthenticated();
  }
}
