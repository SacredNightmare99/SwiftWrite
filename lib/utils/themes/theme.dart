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
      headlineMedium: TextStyle(color: AppColors.textColorLight, fontSize: 22, fontWeight: FontWeight.bold),
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
    dividerColor: AppColors.dividerColorLight,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.cardColorDark,
      contentTextStyle: const TextStyle(color: AppColors.textColorDark),
      actionTextColor: AppColors.primaryColorLight,
      behavior: SnackBarBehavior.floating,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.cardColorLight,
      labelStyle: const TextStyle(color: AppColors.textColorLight, fontSize: 14, fontWeight: FontWeight.w500),
      selectedColor: AppColors.primaryColorLight,
      secondaryLabelStyle: const TextStyle(color: AppColors.backgroundColorLight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AppColors.cardColorDark,
          width: 2
        )
      ),
      deleteIconColor: AppColors.textColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardColorLight,
      hintStyle: TextStyle(color: AppColors.textColorLight.withValues(alpha: 0.5)),
      prefixIconColor: AppColors.textColorLight,
      suffixIconColor: AppColors.textColorLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textColorLight));

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorDark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: AppColors.textColorDark, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.textColorDark, fontSize: 22, fontWeight: FontWeight.bold),
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
    dividerColor: AppColors.dividerColorDark,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.cardColorLight, // or colorScheme.surface
      contentTextStyle: const TextStyle(color: AppColors.textColorLight),
      actionTextColor: AppColors.primaryColorLight,
      behavior: SnackBarBehavior.floating,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.cardColorDark,
      labelStyle: const TextStyle(color: AppColors.textColorDark, fontSize: 14, fontWeight: FontWeight.w500),
      selectedColor: AppColors.primaryColorDark,
      secondaryLabelStyle: const TextStyle(color: AppColors.backgroundColorDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AppColors.cardColorLight,
          width: 2
        )
      ),
      deleteIconColor: AppColors.textColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardColorDark,
      hintStyle: TextStyle(color: AppColors.textColorDark.withValues(alpha: 0.5)),
      prefixIconColor: AppColors.textColorDark,
      suffixIconColor: AppColors.textColorDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textColorDark));

}
