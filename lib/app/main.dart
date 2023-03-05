import 'package:flutter/material.dart';
import 'package:taxi_app/app/features/onboarding/ui/pages/onboarding_page.dart';

import 'shared/themes/themes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const OnboardingPage(),
    );
  }
}
