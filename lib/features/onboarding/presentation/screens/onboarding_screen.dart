import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../navigation/presentation/screens/main_scaffold_screen.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de progresso discreta em pílulas
              Row(
                children: List.generate(5, (index) {
                  final isDone = index <= state.currentStep;
                  return Expanded(
                    child: Container(
                      height: 5,
                      margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.actionGreen : AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Conteúdo do Step Ativo
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _buildStepContent(context, state, controller),
                ),
              ),

              // Botões de Navegação Inferior
              Row(
                children: [
                  if (state.currentStep > 0) ...[
                    PillButton(
                      label: 'VOLTAR',
                      variant: PillButtonVariant.outline,
                      onPressed: () => controller.previousStep(),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: PillButton(
                      label: state.currentStep == 4
                          ? (state.isSaving ? 'INICIANDO...' : 'COMEÇAR A ESTUDAR')
                          : 'CONTINUAR',
                      isExpanded: true,
                      onPressed: state.isSaving
                          ? null
                          : () async {
                              if (state.currentStep < 4) {
                                controller.nextStep();
                              } else {
                                await controller.submitProfile();
                                if (context.mounted) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const MainScaffoldScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
  ) {
    switch (state.currentStep) {
      case 0:
        return _buildObjectiveStep(state, controller);
      case 1:
        return _buildSpanishLevelStep(state, controller);
      case 2:
        return _buildDailyTimeStep(state, controller);
      case 3:
        return _buildCurrentKnowledgeStep(state, controller);
      case 4:
        return _buildMusicPreferencesStep(state, controller);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildObjectiveStep(OnboardingState state, OnboardingController controller) {
    final options = [
      'Aprender por Música e Cultura',
      'Viagem para a Argentina / Buenos Aires',
      'Estudo, Trabalho ou Negócios',
      'Fluência no Espanhol Rioplatense',
    ];

    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuintetIcon(type: QuintetType.slang, size: 48),
        const SizedBox(height: 16),
        Text('QUAL É O SEU\nOBJETIVO?', style: AppTypography.titleLarge()),
        const SizedBox(height: 8),
        Text(
          'Personalizaremos o tom e as dicas da IA de acordo com a sua meta.',
          style: AppTypography.bodySmall(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: options.map((opt) {
              final isSelected = state.objective == opt;
              return _buildSelectablePill(
                label: opt,
                isSelected: isSelected,
                onTap: () => controller.setObjective(opt),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSpanishLevelStep(OnboardingState state, OnboardingController controller) {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuintetIcon(type: QuintetType.grammar, size: 48),
        const SizedBox(height: 16),
        Text('QUAL SEU NÍVEL\nDE ESPANHOL?', style: AppTypography.titleLarge()),
        const SizedBox(height: 8),
        Text(
          'De 0 (zero absoluto) a 10 (compreensão avançada).',
          style: AppTypography.bodySmall(color: AppColors.textMuted),
        ),
        const SizedBox(height: 36),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.actionGreen, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              '${state.spanishLevel}',
              style: AppTypography.titleHuge(color: AppColors.actionGreen).copyWith(fontSize: 56),
            ),
          ),
        ),
        const SizedBox(height: 32),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.actionGreen,
            inactiveTrackColor: AppColors.darkSurface,
            thumbColor: AppColors.actionGreen,
            overlayColor: AppColors.actionGreen.withValues(alpha: 0.2),
            trackHeight: 8,
          ),
          child: Slider(
            value: state.spanishLevel.toDouble(),
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (val) => controller.setSpanishLevel(val.round()),
          ),
        ),
        Center(
          child: Text(
            state.spanishLevel <= 2
                ? 'Iniciante absoluto (partindo do português)'
                : state.spanishLevel <= 5
                    ? 'Básico (conhece palavras soltas e portunhol)'
                    : state.spanishLevel <= 7
                        ? 'Intermediário (entende parte das letras)'
                        : 'Avançado (foco em gírias, voseo e sotaque)',
            style: AppTypography.bodySmall(color: AppColors.supportPurple),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyTimeStep(OnboardingState state, OnboardingController controller) {
    final times = [10, 15, 20, 30];

    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuintetIcon(type: QuintetType.vocab, size: 48),
        const SizedBox(height: 16),
        Text('TEMPO DIÁRIO\nDISPONÍVEL?', style: AppTypography.titleLarge()),
        const SizedBox(height: 8),
        Text(
          'O Acorde divide a música em dias conforme o seu tempo.',
          style: AppTypography.bodySmall(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: times.map((mins) {
              final isSelected = state.dailyMinutes == mins;
              return _buildSelectablePill(
                label: '$mins minutos por dia',
                isSelected: isSelected,
                onTap: () => controller.setDailyMinutes(mins),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentKnowledgeStep(OnboardingState state, OnboardingController controller) {
    final knowledgeOptions = [
      'Não entendo nada além do português',
      'Entendo um pouco de portunhol e leio algumas palavras',
      'Já estudei o básico de espanhol tradicional',
      'Entendo bem, mas quero dominar o espanhol argentino e gírias',
    ];

    return Column(
      key: const ValueKey(3),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuintetIcon(type: QuintetType.falseFriends, size: 48),
        const SizedBox(height: 16),
        Text('O QUE VOCÊ\nJÁ COMPREENDE?', style: AppTypography.titleLarge()),
        const SizedBox(height: 8),
        Text(
          'A IA partirá do que o português já te ajuda, alertando sobre falsos amigos.',
          style: AppTypography.bodySmall(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: knowledgeOptions.map((opt) {
              final isSelected = state.currentKnowledge == opt;
              return _buildSelectablePill(
                label: opt,
                isSelected: isSelected,
                onTap: () => controller.setCurrentKnowledge(opt),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMusicPreferencesStep(OnboardingState state, OnboardingController controller) {
    final genres = [
      'Rock Nacional Argentino (Charly García, Fito Páez, Spinetta)',
      'Tango & Lunfardo (Gardel, Piazzolla, Goyeneche)',
      'Trap & Música Urbana (Duki, Bizarrap, Nicki Nicole, Milo J)',
      'Cumbia & Cuarteto (Los Palmeras, Rodrigo, Damas Gratis)',
      'Pop Latino & Indie Argentino (Bandalos Chinos, Conociendo Rusia)',
    ];

    return Column(
      key: const ValueKey(4),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const QuintetIcon(type: QuintetType.pronunciation, size: 48),
        const SizedBox(height: 16),
        Text('SEUS GOSTOS\nMUSICAIS?', style: AppTypography.titleLarge()),
        const SizedBox(height: 8),
        Text(
          'Selecione um ou mais estilos que você mais quer escutar.',
          style: AppTypography.bodySmall(color: AppColors.textMuted),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: genres.map((genre) {
              final isSelected = state.musicPreferences.contains(genre);
              return _buildSelectablePill(
                label: genre,
                isSelected: isSelected,
                onTap: () => controller.toggleMusicPreference(genre),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectablePill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.actionGreen : AppColors.darkSurface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isSelected ? AppColors.actionGreen : AppColors.borderSubtle,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.bodyMedium(
                    color: isSelected ? AppColors.actionText : AppColors.textLight,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.actionText,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
