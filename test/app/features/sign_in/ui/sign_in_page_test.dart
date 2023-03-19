import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/core/core.dart';
import 'package:taxi_app/app/features/features.dart';
import 'package:taxi_app/app/features/sign_in/presentation/presentation.dart';
import 'package:taxi_app/app/shared/helpers/errors/errors.dart';

import '../../mocks/mocks.dart';
import 'mocks/sign_in_presenter_spy.dart';

void main() {
  late SignInSpy signInSpy;
  late SignInPresenterSpy presenter;

  late String email;
  late String password;

  setUp(() {
    signInSpy = SignInSpy();
    presenter = SignInPresenterSpy(signInSpy);

    email = faker.internet.email();
    password = faker.internet.password();
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

  //Teste de validação dos campos de email e senha
  testWidgets('Should not present ErrorMessage if Form is valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), '1234');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Campo obrigatório'), findsNothing);
    expect(find.text('E-mail inválido'), findsNothing);
  });

  testWidgets('Should present RequiredField if TextFormFields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), '');
    await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), '');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsNWidgets(2));
  });

  testWidgets('Should present error if email is invalid',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(
        find.widgetWithText(TextFormField, 'E-mail'), 'invalid_email');
    await tester.pump();

    expect(find.text('E-mail inválido'), findsOneWidget);
  });

  testWidgets('Should present error if email is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), "abc");
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), "");
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should present error if password is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), '1234');
    await tester.enterText(find.widgetWithText(TextFormField, 'Senha'), '');
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should call signIn on form submit', (WidgetTester tester) async {
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'), password);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    verify(() => presenter(email: email, password: password)).called(1);
  });

  // testWidgets('Should handle loading correctly', (WidgetTester tester) async {

  //   await tester.pumpWidget(loadPage());
  //   await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
  //   await tester.enterText(
  //       find.widgetWithText(TextFormField, 'Senha'), password);
  //   presenter.mockState(value: SignInLoading());
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
  //   await tester.pumpAndSettle();

  //   await tester.pumpAndSettle(const Duration(seconds: 1));
  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

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

  testWidgets('Should present UnexpectedError', (WidgetTester tester) async {
    signInSpy.mockSignInResponseError(DomainError.unexpected);
    presenter.mockState(value: SignInFailed(uiError: UIError.unexpected));

    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'), password);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));

    await tester.pumpAndSettle();

    expect(find.text("Algo deu errado! Tente novamente mais tarde"),
        findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(
        find.text("Algo deu errado! Tente novamente mais tarde"), findsNothing);
  });
}
