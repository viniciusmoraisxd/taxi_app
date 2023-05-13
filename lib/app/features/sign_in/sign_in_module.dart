import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../app_dependencies.dart';
import '../../core/core.dart';
import '../../core/module.dart';
import '../features.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

class SignInModule extends Module {
  final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/sign_in': (context) =>
            SignInPage(presenter: getIt.get<SignInPresenter>()),
        '/forgot_password': (context) => Container(),
        '/sign_up': (context) {
          getIt.get<AppDependencies>().getModuleInstance<SignUpModule>();
          return SignUpPage(presenter: getIt.get());
        }
      };

  @override
  void register(GetIt getIt) {
    getIt.registerSingleton<SignIn>(
        RemoteSignIn(firebaseAuthClient: getIt.get<FirebaseAuthClient>()));

    getIt.registerFactory<SignInPresenter>(
        () => ValueNotifierSignInPresenter(signIn: getIt.get<SignIn>()));
  }

  @override
  void dispose() {}
}
