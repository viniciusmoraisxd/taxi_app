import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/core/core.dart';
import 'package:taxi_app/app/features/features.dart';
import 'package:taxi_app/app/features/sign_in/domain/domain.dart';
import 'package:taxi_app/app/features/sign_in/presentation/presentation.dart';
import 'package:taxi_app/app/shared/helpers/errors/errors.dart';

class SignInSpy extends Mock implements SignIn {
  When mockSignInCall() => when(
      () => call(email: any(named: "email"), password: any(named: "password")));

  void mockSignInResponse() => mockSignInCall().thenAnswer(
        (_) async {
          await Future.delayed(const Duration(seconds: 1));
        },
      );

  void mockSignInResponseError(DomainError error) =>
      mockSignInCall().thenThrow(error);
}

class SignInPresenterSpy extends Mock implements SignInPresenter {
  @override
  final SignIn signIn;

  SignInPresenterSpy(this.signIn);

  When mockSignInPresenterCall() => when(
      () => call(email: any(named: "email"), password: any(named: "password")));

  void mockSignInPresenterResponse() =>
      mockSignInPresenterCall().thenAnswer((_) async => _);

  void mockState({SignInState? value}) =>
      when(() => state).thenReturn(ValueNotifier(value ?? SignInInitial()));
}

void main() {
  late SignInSpy signInSpy;
  late SignInPresenterSpy presenter;

  late String email;
  late String password;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    signInSpy = SignInSpy();
    presenter = SignInPresenterSpy(signInSpy);

    email = faker.internet.email();
    password = faker.internet.password();
    presenter.mockSignInPresenterResponse();
    presenter.mockState();
  });

  loadPage() {
    return MaterialApp(
      home: SignInPage(presenter: presenter),
    );
  }

  testWidgets('Should display widgets correctly', (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());

    expect(find.byKey(const Key("signInAsset")), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'E-mail'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Senha'), findsOneWidget);
    expect(find.text('Esqueceu a senha?'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);
    expect(find.byKey(const Key("signUpLink")), findsOneWidget);
  });

  testWidgets('Should present InvalidCredentialsError',
      (WidgetTester tester) async {
    signInSpy.mockSignInResponseError(DomainError.invalidCredentials);
    presenter.mockState(
        value: SignInFailed(uiError: UIError.invalidCredentials));

    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'), password);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));

    await tester.pumpAndSettle();
    expect(find.text("Credenciais inválidas"), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.text("Credenciais inválidas"), findsNothing);
  });
}
