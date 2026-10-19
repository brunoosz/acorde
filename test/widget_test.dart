import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:acorde/core/theme/app_colors.dart';
import 'package:acorde/core/widgets/pill_button.dart';
import 'package:acorde/core/widgets/quintet_icon.dart';
import 'package:acorde/core/widgets/floating_nav_bar.dart';
import 'package:acorde/main.dart';

void main() {
  testWidgets('Acorde visual identity & components test', (WidgetTester tester) async {
    // Renderiza o app principal
    await tester.pumpWidget(const AcordeApp());
    await tester.pumpAndSettle();

    // Valida logo ("a" e ponto ".")
    expect(find.text('ACORDE'), findsOneWidget);
    expect(find.text('APRENDA\nESPANHOL\nCOM MÚSICA.'), findsOneWidget);

    // Valida botão principal no formato de pílula
    expect(find.text('COLAR NOVA LETRA'), findsOneWidget);
    final buttonFinder = find.byType(PillButton);
    expect(buttonFinder, findsOneWidget);

    // Valida presença da barra flutuante em pílula
    expect(find.byType(FloatingNavBar), findsOneWidget);
    expect(find.text('Músicas'), findsOneWidget);
    expect(find.text('Revisão'), findsNothing); // Apenas a aba ativa mostra o texto na navbar
  });

  testWidgets('QuintetIcon displays correct colors and symbols', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QuintetIcon(type: QuintetType.pronunciation),
        ),
      ),
    );

    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.color, AppColors.darkBackground);
    expect(iconWidget.icon, Icons.record_voice_over_rounded);
  });
}
