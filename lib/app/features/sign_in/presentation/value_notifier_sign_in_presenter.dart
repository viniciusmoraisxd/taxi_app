import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../shared/shared.dart';
import '../domain/domain.dart';
import '../ui/ui.dart';

part 'sign_in_state.dart';

class ValueNotifierSignInPresenter implements SignInPresenter {
  @override
  final SignIn signIn;

  ValueNotifierSignInPresenter({required this.signIn});

  @override
  Future<void> call({required String email, required String password}) async {
    state.value = SignInLoading();

    try {
      await signIn.call(email: email, password: password);

      state.value = SignInSuccess();
    } on DomainError catch (e) {
      switch (e) {
        case DomainError.userDisabled:
          state.value = SignInFailed(uiError: UIError.userDisabled);
          break;
        case DomainError.userNotFound:
          state.value = SignInFailed(uiError: UIError.userNotFound);
          break;
        case DomainError.invalidCredentials:
          state.value = SignInFailed(uiError: UIError.invalidCredentials);
          break;
        default:
          state.value = SignInFailed(uiError: UIError.unexpected);
          break;
      }
    }

    await Future.delayed(const Duration(seconds: 1));
    state.value = SignInInitial();
  }

  @override
  ValueNotifier<SignInState> state = ValueNotifier(SignInInitial());
}
