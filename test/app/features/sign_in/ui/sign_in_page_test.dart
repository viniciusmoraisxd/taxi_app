import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/core/core.dart';
import 'package:taxi_app/app/features/features.dart';
import 'package:taxi_app/app/features/sign_in/presentation/presentation.dart';

import '../../mocks/mocks.dart';

class SignInPresenterSpy extends Mock implements SignInPresenter {
  // void mockSignInPresenterResponse() {
  //   when(() =>
  //           call(email: any(named: "email"), password: any(named: "password")))
  //       .thenAnswer((_) async => _);
  //   when(() => state).thenReturn(ValueNotifier(SignInInitial()));
  // }

  When mockSignInPresenterCall() => when(
      () => call(email: any(named: "email"), password: any(named: "password")));

  void mockSignInPresenterResponse() =>
      mockSignInPresenterCall().thenAnswer((_) async => _);

  void mockSignInPresenterError(DomainError error) =>
      mockSignInPresenterCall().thenThrow(error);

  void mockState() =>
      when(() => state).thenReturn(ValueNotifier(SignInInitial()));
}

void main() {
  late SignInSpy signInSpy;
  late SignInPresenterSpy presenter;

  late String email;
  late String password;

  setUp(() {
    signInSpy = SignInSpy();
    presenter = SignInPresenterSpy();

    email = faker.internet.email();
    password = faker.internet.password();
    presenter.mockSignInPresenterResponse();
    presenter.mockState();
    // presenter.mockState(SignInInitial());
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
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
  //   await tester.pump(const Duration(milliseconds: 500));

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);

  //   await tester.pumpAndSettle(const Duration(seconds: 1));

  //   expect(find.byType(CircularProgressIndicator), findsNothing);
  // });

  testWidgets('Should present InvalidCredentialsError',
      (WidgetTester tester) async {
    presenter.mockSignInPresenterError(DomainError.invalidCredentials);
    await tester.pumpWidget(loadPage());
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Senha'), password);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));

    expect(find.text("Credenciais inválidas"), findsNothing);

    // await tester.pump(const Duration(milliseconds: 500)); //começa a animação
    await tester.pumpAndSettle(const Duration(seconds: 1));

    presenter.state;
    expect(find.text("Credenciais inválidas"), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text("Credenciais inválidas"), findsNothing);
  });

  // testWidgets('Should present UnexpectedError', (WidgetTester tester) async {
  //   await tester.pumpWidget(loadPage());

  //   await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), email);
  //   await tester.enterText(
  //       find.widgetWithText(TextFormField, 'Senha'), password);
  //   await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));

  //   expect(
  //       find.text("Algo deu errado! Tente novamente mais tarde"), findsNothing);

  //   await tester.pump(const Duration(milliseconds: 500));
  //   await tester.pumpAndSettle(const Duration(seconds: 1));

  //   expect(find.text("Algo deu errado! Tente novamente mais tarde"),
  //       findsOneWidget);

  //   await tester.pumpAndSettle(const Duration(seconds: 5));

  //   expect(
  //       find.text("Algo deu errado! Tente novamente mais tarde"), findsNothing);
  // });
}
