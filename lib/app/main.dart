import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/app/features/home/home_module.dart';

import '../firebase_options.dart';
import 'app_dependencies.dart';
import 'shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterConfig.loadEnvVariables();
  
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<AppDependencies>(() => AppDependencies());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme(context),
      initialRoute: "/home",
      onGenerateRoute: (settings) {
        final dependencies = GetIt.I.get<AppDependencies>();
        dependencies.getModuleInstance<HomeModule>();
        final routes = dependencies.generateRoutes();
        if (routes.containsKey(settings.name)) {
          return MaterialPageRoute(
            builder: routes[settings.name]!,
          );
        }

        return null;
      },
    );
  }
}
