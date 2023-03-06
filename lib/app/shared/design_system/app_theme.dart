import 'package:flutter/material.dart';

import '../shared.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      fontFamily: "Gotham-SSm",
      useMaterial3: true,
      primarySwatch: AppColors.primaryCustomColor,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          iconTheme: const IconThemeData(color: AppColors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: AppTypography.customLabelLarge(context),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
        ),
      ),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //         backgroundColor: MaterialStateProperty.all<Color>(
      //   AppColors.primaryColor,
      // ))),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(
            color: AppColors.primaryColor,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      ));
}
