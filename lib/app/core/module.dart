import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class Module {
  void register(GetIt getIt);
  void dispose();
  Map<String, WidgetBuilder> get routes;
}
