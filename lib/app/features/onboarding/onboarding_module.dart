import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../app_dependencies.dart';
import '../../core/module.dart';
import '../features.dart';
import '../sign_in/sign_in_module.dart';

class OnboardingModule extends Module {
  final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/sign_in': (context) {
          getIt.get<AppDependencies>().getModuleInstance<SignInModule>();
          return SignUpPage(presenter: getIt.get());
        }
      };

  @override
  void register(GetIt getIt) {}

  @override
  void dispose() {}
}
