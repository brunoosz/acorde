import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/tts/tts_service.dart';
import '../../data/repositories/vocab_repository.dart';

final dueReviewsFutureProvider = FutureProvider.autoDispose<List<ReviewItem>>((ref) async {
  final repo = ref.watch(vocabRepositoryProvider);
  return repo.getDueReviews();
});

class VocabReviewScreen extends ConsumerStatefulWidget {
  const VocabReviewScreen({super.key});

  @override
  ConsumerState<VocabReviewScreen> createState() => _VocabReviewScreenState();
}

class _VocabReviewScreenState extends ConsumerState<VocabReviewScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isFlipped = false;
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFlipped) {
      _animController.reverse();
    } else {
      _animController.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  Future<void> _answer(ReviewItem item, bool wasCorrect) async {
    final repo = ref.read(vocabRepositoryProvider);
    await repo.answerReview(vocabId: item.vocabId, wasCorrect: wasCorrect);

    _animController.reset();
    setState(() {
      _isFlipped = false;
      _currentIndex++;
    });

    // Se acabou, atualiza o provedor
    ref.invalidate(dueReviewsFutureProvider);
  }

  @override
  Widget build(BuildContext context) {
    final dueAsync = ref.watch(dueReviewsFutureProvider);
    final tts = ref.watch(ttsServiceProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('REVISÃO', style: AppTypography.titleLarge()),
            const SizedBox(height: 6),
            Text(
              'Repetição espaçada simples: 1, 3, 7 e 14 dias.',
              style: AppTypography.bodySmall(color: AppColors.textMuted),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: dueAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.actionGreen),
                ),
                error: (err, _) => Center(child: Text('Erro ao carregar: $err')),
                data: (dueList) {
                  if (dueList.isEmpty || _currentIndex >= dueList.length) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const QuintetIcon(type: QuintetType.vocab, size: 72),
                          const SizedBox(height: 20),
                          Text('TUDO EM DIA!', style: AppTypography.titleMedium()),
                          const SizedBox(height: 8),
                          Text(
                            'Você concluiu todas as revisões agendadas para hoje.\nVolte amanhã para manter o vocabulário afiado!',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodySmall(color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 24),
                          PillButton(
                            label: 'ATUALIZAR REVISÕES',
                            variant: PillButtonVariant.outline,
                            onPressed: () {
                              setState(() => _currentIndex = 0);
                              ref.invalidate(dueReviewsFutureProvider);
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  final item = dueList[_currentIndex];
                  final totalDue = dueList.length;

                  return Column(
                    children: [
                      // Contador de progresso da sessão
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CARD ${_currentIndex + 1} DE $totalDue',
                            style: AppTypography.label(color: AppColors.textMuted),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.darkSurface,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              'NÍVEL ${item.level} (${_intervalLabel(item.level)})',
                              style: AppTypography.label(color: AppColors.iconVocab),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Card que Vira
                      Expanded(
                        child: GestureDetector(
                          onTap: _flipCard,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              final angle = _animation.value * pi;
                              final isUnder = angle > pi / 2;

                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle),
                                alignment: Alignment.center,
                                child: isUnder
                                    ? Transform(
                                        transform: Matrix4.identity()..rotateY(pi),
                                        alignment: Alignment.center,
                                        child: _buildBackCard(item, tts),
                                      )
                                    : _buildFrontCard(item, tts),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Botões de Resposta da Revisão Espaçada
                      if (_isFlipped)
                        Row(
                          children: [
                            Expanded(
                              child: PillButton(
                                label: 'NÃO LEMBREI (VOLTA DIA 1)',
                                variant: PillButtonVariant.outline,
                                onPressed: () => _answer(item, false),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: PillButton(
                                label: 'ACERTEI (+1 NÍVEL)',
                                onPressed: () => _answer(item, true),
                              ),
                            ),
                          ],
                        )
                      else
                        PillButton(
                          label: 'VER TRADUÇÃO (VIRAR CARD)',
                          isExpanded: true,
                          onPressed: _flipCard,
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCard(ReviewItem item, TtsService tts) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.borderSubtle, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 36,
            icon: const Icon(Icons.volume_up_rounded, color: AppColors.iconVocab),
            onPressed: () => tts.speak(item.word),
          ),
          const SizedBox(height: 12),
          Text(
            item.word,
            textAlign: TextAlign.center,
            style: AppTypography.titleLarge(),
          ),
          const SizedBox(height: 8),
          Text(
            item.origin,
            style: AppTypography.label(color: AppColors.textMuted),
          ),
          const Spacer(),
          Text(
            'Toque para virar e conferir a resposta ↺',
            style: AppTypography.bodySmall(color: AppColors.supportPurple),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(ReviewItem item, TtsService tts) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.actionGreen, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TRADUÇÃO',
            style: AppTypography.label(color: AppColors.actionGreen),
          ),
          const SizedBox(height: 8),
          Text(
            item.translation,
            textAlign: TextAlign.center,
            style: AppTypography.titleMedium(color: AppColors.textLight),
          ),
          if (item.example.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              '"${item.example}"',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(color: AppColors.supportGrey),
            ),
          ],
          const Spacer(),
          Text(
            'Lembrou do significado?',
            style: AppTypography.label(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }

  String _intervalLabel(int level) {
    switch (level) {
      case 1:
        return '1 dia';
      case 2:
        return '3 dias';
      case 3:
        return '7 dias';
      default:
        return '14 dias';
    }
  }
}
