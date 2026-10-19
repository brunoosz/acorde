import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/floating_nav_bar.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/widgets/lesson_icon_row.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class MainScaffoldScreen extends StatefulWidget {
  const MainScaffoldScreen({super.key});

  @override
  State<MainScaffoldScreen> createState() => _MainScaffoldScreenState();
}

class _MainScaffoldScreenState extends State<MainScaffoldScreen> {
  int _currentIndex = 0;

  final List<FloatingNavBarItem> _navItems = const [
    FloatingNavBarItem(icon: Icons.music_note_rounded, label: 'Músicas'),
    FloatingNavBarItem(icon: Icons.bookmark_rounded, label: 'Revisão'),
    FloatingNavBarItem(icon: Icons.settings_rounded, label: 'Ajustes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              _SongsPreviewTab(),
              _VocabPreviewTab(),
              SettingsScreen(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: _navItems,
            ),
          ),
        ],
      ),
    );
  }
}

/// Aba 1: Prévia da listagem de músicas e identidade Navigate
class _SongsPreviewTab extends StatelessWidget {
  const _SongsPreviewTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Acorde: "a" minúsculo em creme com ponto laranja sobre fundo escuro
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'a',
                    style: AppTypography.titleHuge(color: AppColors.textLight).copyWith(
                      fontSize: 54,
                    ),
                    children: [
                      TextSpan(
                        text: '.',
                        style: AppTypography.titleHuge(color: AppColors.celebrationAccent).copyWith(
                          fontSize: 54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'ACORDE',
                  style: AppTypography.label(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Título enorme pôster
            Text(
              'APRENDA\nESPANHOL\nCOM MÚSICA.',
              style: AppTypography.titleHuge(),
            ),
            const SizedBox(height: 12),
            Text(
              'Espanhol rioplatense (Argentina) analisado estrofe por estrofe.',
              style: AppTypography.bodyMedium(color: AppColors.supportPurple),
            ),
            const SizedBox(height: 28),

            // Botão de ação (cor única autorizada #c7ff69)
            PillButton(
              label: 'COLAR NOVA LETRA',
              icon: const Icon(Icons.add, color: AppColors.actionText),
              isExpanded: true,
              onPressed: () {
                // Será conectado na etapa de colar letra
              },
            ),
            const SizedBox(height: 36),

            // Faixa com os 5 blocos da aula
            Text(
              'OS 5 PILARES DE CADA AULA',
              style: AppTypography.label(color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),
            const LessonIconRow(),
            const SizedBox(height: 36),

            // Exemplo de seção em faixa de cor cheia (Navigate style: preto -> creme -> laranja)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const QuintetIcon(
                        type: QuintetType.music,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NENHUMA MÚSICA AINDA',
                              style: AppTypography.bodyMedium(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Cole uma letra de tango, rock nacional ou trap argentino.',
                              style: AppTypography.bodySmall(
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Aba 2: Prévia de Vocabulário / Revisão
class _VocabPreviewTab extends StatelessWidget {
  const _VocabPreviewTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'REVISÃO',
              style: AppTypography.titleLarge(),
            ),
            const SizedBox(height: 8),
            Text(
              'Sistema de repetição espaçada: 1, 3, 7 e 14 dias.',
              style: AppTypography.bodyMedium(color: AppColors.textMuted),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const QuintetIcon(
                      type: QuintetType.vocab,
                      size: 72,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'TUDO EM DIA!',
                      style: AppTypography.titleMedium(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Novas palavras salvas durante as aulas aparecerão aqui.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmall(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Aba 3: Prévia de Configurações
