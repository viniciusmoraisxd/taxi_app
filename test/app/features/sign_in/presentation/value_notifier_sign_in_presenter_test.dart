import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/features/features.dart';
import 'package:taxi_app/app/features/sign_in/domain/domain.dart';
import 'package:taxi_app/app/features/sign_in/presentation/presentation.dart';

import '../../mocks/mocks.dart';

void main() {
  late SignInSpy signInSpy;
  late ValueNotifierSignInPresenter sut;
  late String email;
  late String password;
  List<SignInState> states = [];

  setUp(() {
    signInSpy = SignInSpy();
    sut = ValueNotifierSignInPresenter(signIn: signInSpy);
    email = faker.internet.email();
    password = faker.internet.password();
    signInSpy.mockSignInResponse();

    sut.addListener(() {
      states.add(sut.value);
    });
  });

  test('Should call SignIn with correct values', () async {
    await sut(email: email, password: password);

    verify(() => signInSpy(email: email, password: password));
  });

  test('Should emit correct states on success', () async {
    await sut(email: email, password: password);

    expect(states[0], isA<SignInLoading>());
    expect(states[1], isA<SignInSuccess>());
    expect(states[2], isA<SignInInitial>());
  });

  test(
      'Should emit UIInvalidCredentialsError if SignIn throws invalidCredentials',
      () async {
    states = [];
    signInSpy.mockSignInResponseError(DomainError.invalidCredentials);
    await sut(email: email, password: password);

    expect(states[0], isA<SignInLoading>());
    expect(
        states[1],
        isA<SignInFailed>().having((p0) => p0.uiError,
            "Should contain unexpected error", UIError.invalidCredentials));
    expect(states[2], isA<SignInInitial>());
  });

  test('Should emit userDisabled if SignIn throws invalidCredentials',
      () async {
    states = [];
    signInSpy.mockSignInResponseError(DomainError.userDisabled);

    await sut(email: email, password: password);

    expect(states[0], isA<SignInLoading>());
    expect(
        states[1],
        isA<SignInFailed>().having((p0) => p0.uiError,
            "Should contain userDisabled error", UIError.userDisabled));
    expect(states[2], isA<SignInInitial>());
  });

  test('Should emit userNotFoundError if SignIn throws userNotFound', () async {
    states = [];
    signInSpy.mockSignInResponseError(DomainError.userNotFound);

    await sut(email: email, password: password);

    expect(states[0], isA<SignInLoading>());
    expect(
        states[1],
        isA<SignInFailed>().having((p0) => p0.uiError,
            "Should contain userNotFound error", UIError.userNotFound));
    expect(states[2], isA<SignInInitial>());
  });

  test('Should emit UIUnexpectedError if SignIn throws unexpected', () async {
    states = [];
    signInSpy.mockSignInResponseError(DomainError.unexpected);
    await sut(email: email, password: password);

    expect(states[0], isA<SignInLoading>());
    expect(
        states[1],
        isA<SignInFailed>().having((p0) => p0.uiError,
            "Should contain unexpected error", UIError.unexpected));
    expect(states[2], isA<SignInInitial>());
  });
}
