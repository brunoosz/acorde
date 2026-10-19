import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:acorde/core/theme/app_colors.dart';
import 'package:acorde/core/widgets/pill_button.dart';
import 'package:acorde/core/widgets/quintet_icon.dart';
import 'package:acorde/core/widgets/floating_nav_bar.dart';
import 'package:acorde/features/navigation/presentation/screens/main_scaffold_screen.dart';
import 'package:acorde/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:acorde/features/music/presentation/screens/songs_list_tab.dart';
import 'package:acorde/features/vocab/presentation/screens/vocab_review_screen.dart';
import 'package:acorde/main.dart';

void main() {
  testWidgets('Acorde startup gate shows splash logo and transitions to Onboarding', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hasProfileFutureProvider.overrideWith((ref) => Future.value(false)),
        ],
        child: const AcordeApp(),
      ),
    );
    await tester.pump();
    
    // Splash screen renders logo "a."
    expect(find.text('a'), findsOneWidget);
    expect(find.text('ESPANHOL RIOPLATENSE COM MÚSICA'), findsOneWidget);

    // Let splash finish and transition
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('QUAL É O SEU\nOBJETIVO?'), findsOneWidget);
    expect(find.text('CONTINUAR'), findsOneWidget);
  });

  testWidgets('MainScaffoldScreen renders Navigate identity and floating navbar', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          allSongsFutureProvider.overrideWith((ref) => Future.value([])),
          dueReviewsFutureProvider.overrideWith((ref) => Future.value([])),
        ],
        child: const MaterialApp(
          home: MainScaffoldScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Valida logo e pôster
    expect(find.text('ACORDE'), findsOneWidget);
    expect(find.text('APRENDA\nESPANHOL\nCOM MÚSICA.'), findsOneWidget);

    // Valida botão principal
    expect(find.text('COLAR NOVA LETRA'), findsOneWidget);
    expect(find.byType(PillButton), findsWidgets);

    // Valida presença da barra flutuante em pílula
    expect(find.byType(FloatingNavBar), findsOneWidget);
    expect(find.text('Músicas'), findsOneWidget);
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
