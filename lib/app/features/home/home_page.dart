import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBodyWidget(
        builder: (context, constraints) {
          return Column(
            children: const [],
          );
        },
      ),
    );
  }
}
