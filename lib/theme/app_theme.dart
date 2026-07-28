import 'package:flutter/material.dart';
import 'package:pocket_mate/theme/app_text_styles.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
    ),

  textTheme: TextTheme(
    headlineLarge: AppTextStyles.headline,
    titleLarge: AppTextStyles.title,
    bodyLarge: AppTextStyles.body,
    bodyMedium: AppTextStyles.subtitle,
    bodySmall: AppTextStyles.small,

  ),
  cardColor: AppColors.card,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
  ),

  );
}