part of 'value_notifier_sign_up_presenter.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {
  final UIError uiError;

  const SignUpFailed({required this.uiError});
}
