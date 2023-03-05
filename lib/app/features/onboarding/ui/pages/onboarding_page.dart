import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            children: const [],
          ),
        ),
      );
    }));
  }
}
