import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/onboarding/ui/pages/onboarding_page.dart';
import 'shared/design_system/design_system.dart';

void main() {
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
      theme: AppTheme.lightTheme,
      home: const OnboardingPage(),
    );
  }
}
