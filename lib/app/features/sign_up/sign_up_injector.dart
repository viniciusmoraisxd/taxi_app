// import 'package:get_it/get_it.dart';
// import 'package:taxi_app/app/features/sign_up/domain/domain.dart';

// import 'data/data.dart';
// import 'presentation/presentation.dart';

// final GetIt signUpInjector = GetIt.instance;

// void registerModule1Dependencies() {
//   signUpInjector.registerSingleton<SignUp>(
//       RemoteSignUp(firebaseAuthClient: signUpInjector.get()));
//   signUpInjector.registerSingleton<AddUser>(
//       RemoteAddUser(databaseClient: signUpInjector.get()));
//   signUpInjector.registerSingleton<ValueNotifierSignUpPresenter>(
//       ValueNotifierSignUpPresenter(
//           addUser: signUpInjector.get<AddUser>(),
//           signUp: signUpInjector.get<SignUp>()));
// }

import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../../core/module.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

class SignUpModule extends Module {
  @override
  void register(GetIt getIt) {
    getIt.registerSingleton<SignUp>(
        RemoteSignUp(firebaseAuthClient: getIt.get<FirebaseAuthClient>()));
    getIt.registerSingleton<AddUser>(
        RemoteAddUser(databaseClient: getIt.get<FirebaseFirestoreClient>()));
    getIt.registerSingleton<ValueNotifierSignUpPresenter>(
        ValueNotifierSignUpPresenter(
            addUser: getIt.get<AddUser>(), signUp: getIt.get<SignUp>()));
  }
}
