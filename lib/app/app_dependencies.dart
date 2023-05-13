import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/app_module.dart';
import 'package:taxi_app/app/core/module.dart';
import 'package:taxi_app/app/features/sign_in/sign_in_module.dart';

import 'features/sign_up/sign_up_module.dart';

class AppDependencies {
  static final getIt = GetIt.instance;

  final Map<Type, Function()> moduleFactories = {
    AppModule: () => AppModule(),
    SignInModule: () => SignInModule(),
    SignUpModule: () => SignUpModule(),
    // Adicione outros módulos aqui
  };

  final Map<Type, Module> _loadedModules = {};

  // Obtém ou cria uma instância de módulo
  Module getModuleInstance<T extends Module>() {
    final moduleFactory = moduleFactories[T];
    if (moduleFactory != null) {
      if (_loadedModules.containsKey(T)) {
        return _loadedModules[T]!;
      } else {
        final moduleInstance = moduleFactory() as Module;
        moduleInstance.register(getIt);
        _loadedModules[T] = moduleInstance;
        return moduleInstance;
      }
    }
    throw Exception();
  }

  Map<String, WidgetBuilder> generateRoutes() {
    final Map<String, WidgetBuilder> allRoutes = {};

    for (var module in _loadedModules.values) {
      allRoutes.addAll(module.routes);
    }

    return allRoutes;
  }

  // static void configure() {
  //   getIt.registerLazySingleton<FirebaseAuthClient>(
  //       () => FirebaseAuthAdapter(firebaseAuth: FirebaseAuth.instance));
  //   getIt.registerLazySingleton<FirebaseFirestoreClient>(
  //       () => FirebaseDatabaseAdapter());

  //   SignUpModule().register(getIt);
  //   SignInModule().register(getIt);
  // }
}
