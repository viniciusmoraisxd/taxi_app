import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../../core/module.dart';
import 'ui/home_page.dart';

class HomeModule extends Module {
  final getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> get routes => {
        '/home': (context) => const HomePage(),
      };

  @override
  void register(GetIt getIt) {
    getIt.registerLazySingleton<HttpClient>(() => HttpAdapter(
        client: Dio(BaseOptions(
            baseUrl: "https://maps.google.com/maps/api/",
            headers: {"content-type": "application/json"}))));
  }

  @override
  void dispose() {}
}
