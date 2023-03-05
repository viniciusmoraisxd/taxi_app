import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/app/shared/design_system/design_system.dart';

class OnboardingContentWidget extends StatelessWidget {
  final double height;
  final String title;
  final String description;
  final String image;

  const OnboardingContentWidget(
      {super.key,
      required this.height,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image, height: height * 0.35),
        const SizedBox(height: 32),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Column(
              children: [
                Text(
                  title,
                  style: AppTypography.customHeaderSmall(context,),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(description,
                    style: AppTypography.customBodyMedium(context),
                    textAlign: TextAlign.center),
              ],
            )),
      ],
    );
  }
}
