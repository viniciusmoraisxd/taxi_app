import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/shared.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  const CustomDraggableScrollableSheet({
    super.key,
    required this.minChildSize,
    required this.maxChildSize,
  });

  final double minChildSize;
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: minChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (context, scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: AppColors.grey,
                      ),
                      width: 64,
                      height: 4,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Para onde vamos?",
                          style: AppTypography.customTitleLarge(context),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SavedAddressButtonWidget(
                              asset: AppImages.lottieHomeBuilding,
                            ),
                            SavedAddressButtonWidget(
                              asset: AppImages.lottieCityOfficeBuilding,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class SavedAddressButtonWidget extends StatelessWidget {
  final String asset;
  const SavedAddressButtonWidget({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.cardBackgroundColor,
        boxShadow: const [
          BoxShadow(
              blurRadius: 10.0,
              color: Color.fromARGB(50, 0, 0, 0),
              offset: Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 80,
              color: Colors.black,
              child: Lottie.asset(asset, fit: BoxFit.fitHeight, repeat: false)),
          const Text("Casa"),
        ],
      ),
    );
  }
}





// ListView(controller: scrollController, children:  [
//             Container(
//               color: AppColors.accentColor,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               height: 50,
//               width: 80,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                       color: AppColors.grey,
//                     ),
//                     width: 64,
//                     height: 4,
//                   ),
//                   const Text(
//                     "Para onde vamos?",
//                     textAlign: TextAlign.right,
//                   )
//                 ],
//               ),
//             ),
//           ]),