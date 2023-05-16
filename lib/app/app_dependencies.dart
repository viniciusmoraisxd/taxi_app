import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/app_module.dart';
import 'package:taxi_app/app/core/module.dart';
import 'features/features.dart';

class AppDependencies {
  static final getIt = GetIt.instance;

  final Map<Type, Function()> moduleFactories = {
    AppModule: () => AppModule(),
    OnboardingModule: () => OnboardingModule(),
    SignInModule: () => SignInModule(),
    SignUpModule: () => SignUpModule(),
    HomeModule: () => HomeModule(),
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
}
