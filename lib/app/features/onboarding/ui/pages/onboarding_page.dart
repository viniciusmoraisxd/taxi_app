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
        title: "Chame uma corrida",
        description:
            "Chame uma corrida e seja buscado por um dos nossos motoristas nas proximidades",
        image: AppImages.orderRide),
    OnboardingModel(
        title: "Confirme seu motorista",
        description:
            "Uma enorme rede de motoristas ajuda você a encontrar viagens confortáveis, seguras e baratas",
        image: AppImages.confirmRide),
    OnboardingModel(
        title: "Acompanhe sua viagem",
        description:
            "Conheça o seu motorista com antecedência e visualize a localização atual em tempo real no mapa",
        image: AppImages.trackRide)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            children: [
              Visibility(
                visible: _currentIndex != onboardingContent.length - 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 42, horizontal: 32),
                  child: SkipButtonWidget(
                    pageController: pageController,
                    page: onboardingContent.length,
                  ),
                ),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 42, horizontal: 32),
                child: OnboardingNavigationWidget(
                  onboardingContent: onboardingContent,
                  pageController: pageController,
                  currentIndex: _currentIndex,
                  isFinalPage: _currentIndex == onboardingContent.length - 1,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
