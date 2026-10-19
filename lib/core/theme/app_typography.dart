import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Tipografia oficial no estilo "Navigate".
///
/// Regras:
/// - Títulos: Archivo Black, altura de linha 0.85–0.9, espaçamento negativo (-0.5 a -1.5).
/// - No celular: entre 40px e 64px.
/// - Texto e interface: DM Sans, pesos 400–700, entre 13px e 18px.
/// - Proibido: Texto de interface acima de 18px (acima de 36px apenas títulos).
class AppTypography {
  AppTypography._();

  // Títulos Pesados (Archivo Black)
  static TextStyle titleHuge({Color color = AppColors.textLight}) =>
      GoogleFonts.archivoBlack(
        fontSize: 48,
        height: 0.88,
        letterSpacing: -1.5,
        fontWeight: FontWeight.w900,
        color: color,
      );

  static TextStyle titleLarge({Color color = AppColors.textLight}) =>
      GoogleFonts.archivoBlack(
        fontSize: 40,
        height: 0.88,
        letterSpacing: -1.2,
        fontWeight: FontWeight.w900,
        color: color,
      );

  static TextStyle titleMedium({Color color = AppColors.textLight}) =>
      GoogleFonts.archivoBlack(
        fontSize: 32,
        height: 0.90,
        letterSpacing: -1.0,
        fontWeight: FontWeight.w900,
        color: color,
      );

  // Interface & Leitura (DM Sans, 13 a 18px)
  static TextStyle bodyLarge({
    Color color = AppColors.textLight,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.dmSans(
        fontSize: 18,
        height: 1.4,
        letterSpacing: 0.1,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodyMedium({
    Color color = AppColors.textLight,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.dmSans(
        fontSize: 16,
        height: 1.4,
        letterSpacing: 0.2,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle bodySmall({
    Color color = AppColors.textLight,
    FontWeight fontWeight = FontWeight.w400,
  }) =>
      GoogleFonts.dmSans(
        fontSize: 14,
        height: 1.35,
        letterSpacing: 0.3,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle label({
    Color color = AppColors.textLight,
    FontWeight fontWeight = FontWeight.w700,
  }) =>
      GoogleFonts.dmSans(
        fontSize: 13,
        height: 1.2,
        letterSpacing: 0.4,
        fontWeight: fontWeight,
        color: color,
      );

  static TextStyle button({
    Color color = AppColors.actionText,
    FontWeight fontWeight = FontWeight.w700,
  }) =>
      GoogleFonts.dmSans(
        fontSize: 15,
        height: 1.1,
        letterSpacing: 0.5,
        fontWeight: fontWeight,
        color: color,
      );
}
