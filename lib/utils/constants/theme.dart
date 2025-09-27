import 'package:flutter/material.dart';
import 'package:writer/utils/constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColorLight,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.textColorLight, fontSize: 24, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: AppColors.textColorLight, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: AppColors.textColorLight, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.textColorLight, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textColorLight, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.textColorLight, fontSize: 12),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColorLight,
      secondary: AppColors.secondaryColorLight,
      surface: AppColors.cardColorLight,
      error: AppColors.destructiveColorLight,
      onError: AppColors.onErrorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorLight,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textColorLight),
      titleTextStyle: TextStyle(color: AppColors.textColorLight, fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardColorLight,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColorLight,
      foregroundColor: AppColors.backgroundColorLight,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorDark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.textColorDark, fontSize: 24, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: AppColors.textColorDark, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: AppColors.textColorDark, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: AppColors.textColorDark, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.textColorDark, fontSize: 14),
      bodySmall: TextStyle(color: AppColors.textColorDark, fontSize: 12),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColorDark,
      secondary: AppColors.secondaryColorDark,
      surface: AppColors.cardColorDark,
      error: AppColors.destructiveColorDark,
      onError: AppColors.onErrorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textColorDark),
      titleTextStyle: TextStyle(color: AppColors.textColorDark, fontSize: 22, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardColorDark,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColorDark,
      foregroundColor: AppColors.backgroundColorDark,
    ),
  );
}
