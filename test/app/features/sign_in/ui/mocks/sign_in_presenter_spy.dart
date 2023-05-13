import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/features/sign_in/domain/domain.dart';
import 'package:taxi_app/app/features/sign_in/presentation/presentation.dart';
import 'package:taxi_app/app/features/sign_in/sign_in.dart';

class SignInPresenterSpy extends Mock implements SignInPresenter {
  @override
  final SignIn signIn;

  SignInPresenterSpy(this.signIn) {
    mockSignInPresenterCall().thenAnswer((_) async => _);
    mockState();
  }

  When mockSignInPresenterCall() => when(
      () => call(email: any(named: "email"), password: any(named: "password")));

  void mockState({SignInState? value}) =>
      when(() => state).thenReturn(ValueNotifier(value ?? SignInInitial()));
}
