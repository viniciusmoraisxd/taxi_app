import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'pages.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();

  int _currentIndex = 0;

  final List<OnboardingModel> onboardingContent = [
    OnboardingModel(
        title: "Let us give the best treatment",
        description: "Get the best treatment for your animal with us",
        image: AppImages.login),
    OnboardingModel(
        title: "Escolha sua rota", description: "Escolha seu destino e nós te levamos com conforto", image: AppImages.signUp),
    OnboardingModel(
        title: "Título 3",
        description: "Descrição 3",
        image: AppImages.enterOtp)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 32),
          child: Column(
            children: [
              SkipButtonWidget(
                pageController: pageController,
                page: onboardingContent.length,
              ),
              Flexible(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingContent.length,
                  onPageChanged: (value) => setState(() {
                    _currentIndex = value;
                  }),
                  itemBuilder: (context, index) => OnboardingContentWidget(
                    height: constraints.maxHeight,
                    title: onboardingContent[index].title,
                    description: onboardingContent[index].description,
                    image: onboardingContent[index].image,
                  ),
                ),
              ),
              OnboardingNavigationWidget(
                  onboardingContent: onboardingContent,
                  pageController: pageController,
                  currentIndex: _currentIndex),
            ],
          ),
        );
      }),
    );
  }
}
