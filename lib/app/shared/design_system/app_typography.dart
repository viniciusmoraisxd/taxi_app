import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle? customHeadlineMedium(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
  static TextStyle? customHeadlinelarge(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customHeaderSmall(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customTitleLarge(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customTitleMedium(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
  static TextStyle? customTitleSmall(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customLabelLarge(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customLabelMedium(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
  static TextStyle? customLabelSmall(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );

  static TextStyle? customBodyLarge(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
  static TextStyle? customBodyMedium(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
  static TextStyle? customBodySmall(BuildContext context,
          {Color? color, FontWeight? fontWeight}) =>
      Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: fontWeight,
          );
}
