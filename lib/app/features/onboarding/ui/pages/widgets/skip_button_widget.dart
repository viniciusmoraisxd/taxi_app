import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';

class SkipButtonWidget extends StatelessWidget {
  final int page;
  final PageController pageController;

  const SkipButtonWidget({
    super.key,
    required this.pageController,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Text("Pular",
            style: AppTypography.customLabelLarge(context,
                color: AppColors.primaryColor)),
      ),
    );
  }
}
