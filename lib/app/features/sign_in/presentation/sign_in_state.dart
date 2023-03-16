part of 'value_notifier_sign_in_presenter.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class UncompleteAccess extends SignInState {}

class SignInFailed extends SignInState {
  final UIError uiError;
  SignInFailed({required this.uiError});
}
