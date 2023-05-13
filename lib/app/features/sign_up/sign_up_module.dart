import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/features/sign_up/sign_up.dart';

import '../../app_dependencies.dart';
import '../../core/core.dart';
import '../../core/module.dart';
import '../sign_in/sign_in_module.dart';
import '../sign_in/ui/ui.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

class SignUpModule extends Module {
  static final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/sign_up': (context) => SignUpPage(presenter: getIt.get()),
        '/sign_in': (context) {
          getIt.get<AppDependencies>().getModuleInstance<SignInModule>();
          return SignInPage(presenter: getIt.get());
        }
      };

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

  @override
  void dispose() {}
}
