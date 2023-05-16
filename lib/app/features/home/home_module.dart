import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/module.dart';
import 'home.dart';

class HomeModule extends Module {
  final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/home': (context) => const HomePage(),
      };

  @override
  void register(GetIt getIt) {}

  @override
  void dispose() {}
}
