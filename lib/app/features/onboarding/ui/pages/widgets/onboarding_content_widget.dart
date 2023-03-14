import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/app/shared/design_system/design_system.dart';

class OnboardingContentWidget extends StatefulWidget {
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
  State<OnboardingContentWidget> createState() =>
      _OnboardingContentWidgetState();
}

class _OnboardingContentWidgetState extends State<OnboardingContentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();

    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.image, height: widget.height * 0.35),
          const SizedBox(height: 32),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: AppTypography.customHeaderSmall(
                      context,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(widget.description,
                      style: AppTypography.customBodyMedium(context),
                      textAlign: TextAlign.center),
                ],
              )),
        ],
      ),
    );
  }
}
