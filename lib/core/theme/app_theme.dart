import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.actionGreen,
        onPrimary: AppColors.actionText,
        surface: AppColors.darkSurface,
        onSurface: AppColors.textLight,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.titleHuge(),
        headlineMedium: AppTypography.titleLarge(),
        headlineSmall: AppTypography.titleMedium(),
        bodyLarge: AppTypography.bodyLarge(),
        bodyMedium: AppTypography.bodyMedium(),
        bodySmall: AppTypography.bodySmall(),
        labelSmall: AppTypography.label(),
      ),
      // Sem elevação ou sombras padrão
      cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }
}
