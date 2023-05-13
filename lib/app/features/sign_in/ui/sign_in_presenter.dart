import 'package:flutter/material.dart';

import '../domain/domain.dart';
import '../presentation/presentation.dart';

abstract class SignInPresenter {
  final SignIn signIn;

  SignInPresenter(this.signIn);
  Future<void> call({required String email, required String password});

  late ValueNotifier<SignInState> state;
}
