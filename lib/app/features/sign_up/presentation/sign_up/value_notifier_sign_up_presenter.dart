import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../shared/shared.dart';
import '../../domain/domain.dart';
import '../../domain/entities/entities.dart';

part 'sign_up_state.dart';

class ValueNotifierSignUpPresenter extends ValueNotifier<SignUpState> {
  final SignUp signUp;
  final AddUser addUser;

  ValueNotifierSignUpPresenter({
    required this.signUp,
    required this.addUser,
  }) : super(SignUpInitial());

  Future<void> call(
      {required String email,
      required String password,
      required UserEntity userEntity}) async {
    value = SignUpLoading();

    try {
      await signUp(email: email, password: password);

      await addUser(userEntity: userEntity);

      value = SignUpSuccess();
    } on DomainError catch (e) {
      switch (e) {
        case DomainError.emailInUse:
          value = const SignUpFailed(uiError: UIError.emailInUse);
          break;
        case DomainError.invalidEmail:
          value = const SignUpFailed(uiError: UIError.invalidEmail);
          break;
        case DomainError.userDisabled:
          value = const SignUpFailed(uiError: UIError.userDisabled);
          break;
        case DomainError.weakPassword:
          value = const SignUpFailed(uiError: UIError.weakPassword);
          break;
        default:
          value = const SignUpFailed(uiError: UIError.unexpected);
          break;
      }
    }

    await Future.delayed(const Duration(seconds: 1));
    value = SignUpInitial();
  }
}
