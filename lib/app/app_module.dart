import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/features/features.dart';

import 'app_dependencies.dart';
import 'core/core.dart';
import 'core/module.dart';
import 'features/sign_in/sign_in_module.dart';

class AppModule extends Module {
  final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/': (context) {
          getIt.get<AppDependencies>().getModuleInstance<SignInModule>();
          return SignInPage(presenter: getIt.get());
        }
      };

  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<FirebaseAuthClient>(
        () => FirebaseAuthAdapter(firebaseAuth: FirebaseAuth.instance));

    getIt.registerLazySingleton<FirebaseFirestoreClient>(
        () => FirebaseDatabaseAdapter());
  }

  @override
  void dispose() {}
}
