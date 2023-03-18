import '../../../../core/core.dart';
import '../../domain/usecases/usecases.dart';

class RemoteSignUp implements SignUp {
  final FirebaseAuthClient firebaseAuthClient;

  RemoteSignUp({required this.firebaseAuthClient});

  @override
  Future<void> call({required String email, required String password}) async {
    try {
      await firebaseAuthClient.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseSignUpError catch (e) {
      switch (e) {
        case FirebaseSignUpError.emailAlreadyInUse:
          throw DomainError.emailInUse;
        case FirebaseSignUpError.invalidEmail:
          throw DomainError.invalidEmail;
        case FirebaseSignUpError.operationNotAllowed:
          throw DomainError.userDisabled;
        case FirebaseSignUpError.weakPassword:
          throw DomainError.weakPassword;
      }
    }
  }
}
