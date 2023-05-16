import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';
import '../model/model.dart';

class OnboardingNavigationWidget extends StatelessWidget {
  final List<OnboardingModel> onboardingContent;
  final PageController pageController;
  final int currentIndex;
  final bool isFinalPage;
  const OnboardingNavigationWidget(
      {super.key,
      required this.onboardingContent,
      required this.pageController,
      required this.currentIndex,
      required this.isFinalPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: onboardingContent.map(
            (item) {
              int index = onboardingContent.indexOf(item);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: currentIndex == index ? 16 : 6.0,
                height: currentIndex == index ? 8.0 : 6.0,
                margin: const EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: currentIndex == index
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.5),
                ),
              );
            },
          ).toList(),
        ),
        SizedBox(
          height: 62,
          width: 62,
          child: ElevatedButton(
            onPressed: () {
              if (isFinalPage) {
                Navigator.of(context).pushReplacementNamed('/sign_in');
              } else {}
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            child: const Icon(Icons.arrow_forward, color: AppColors.white),
          ),
        )
      ],
    );
  }
}
