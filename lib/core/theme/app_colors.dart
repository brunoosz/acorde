import 'package:flutter/material.dart';

/// Paleta de cores oficial do estilo "Navigate" para o Acorde.
/// 
/// Regras estritas:
/// - Fundo escuro principal: `#141414`
/// - Superfície escura elevada: `#232323`
/// - Fundo claro (leitura da aula): `#fdf9f0`
/// - Destaque / celebração: `#ff6d38`
/// - Única cor de botão de ação: `#c7ff69` com texto `#141414`
/// - Ícones (quinteto fixo): `#7a78ff`, `#00a652`, `#ff6d38`, `#ffc412`, `#478bff`
/// - Sem degradês ou sombras.
class AppColors {
  AppColors._();

  // Fundos & Superfícies
  static const Color darkBackground = Color(0xFF141414);
  static const Color darkSurface = Color(0xFF232323);
  static const Color lightLessonBackground = Color(0xFFFDF9F0);
  static const Color celebrationAccent = Color(0xFFFF6D38);

  // Botão de ação (cor única autorizada)
  static const Color actionGreen = Color(0xFFC7FF69);
  static const Color actionText = Color(0xFF141414);

  // Quinteto fixo dos 5 blocos da aula
  static const Color iconPronunciation = Color(0xFF7A78FF); // Violeta (também usado para música)
  static const Color iconMusic = Color(0xFF7A78FF);
  static const Color iconSlang = Color(0xFF00A652);         // Verde escuro vibrante
  static const Color iconGrammar = Color(0xFFFF6D38);       // Laranja
  static const Color iconFalseFriends = Color(0xFFFFC412);  // Amarelo dourado
  static const Color iconVocab = Color(0xFF478BFF);         // Azul cobalto

  // Cores de apoio e tipografia
  static const Color textLight = Color(0xFFFDF9F0);
  static const Color textDark = Color(0xFF141414);
  static const Color supportPurple = Color(0xFFCCCCFF);
  static const Color supportGrey = Color(0xFFEEEEEE);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color borderSubtle = Color(0xFF333333);

  // Terceiros
  static const Color spotifyGreen = Color(0xFF1DB954);
}
