import 'package:mocktail/mocktail.dart';
import 'package:taxi_app/app/core/core.dart';
import 'package:taxi_app/app/features/sign_in/domain/domain.dart';

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
