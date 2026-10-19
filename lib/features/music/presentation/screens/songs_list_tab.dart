import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/widgets/lesson_icon_row.dart';
import '../../data/repositories/music_repository.dart';
import '../../domain/models/song.dart';
import '../../../lesson/domain/models/lesson_plan.dart';
import 'add_song_screen.dart';
import '../../../lesson/presentation/screens/lesson_screen.dart';

final allSongsFutureProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  final repo = ref.watch(musicRepositoryProvider);
  return repo.getAllSongs();
});

class SongsListTab extends ConsumerWidget {
  const SongsListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songsAsync = ref.watch(allSongsFutureProvider);

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.actionGreen,
        backgroundColor: AppColors.darkSurface,
        onRefresh: () async {
          ref.invalidate(allSongsFutureProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
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

              // Título pôster Navigate
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
                onPressed: () async {
                  final added = await Navigator.of(context).push<bool>(
                    MaterialPageRoute(builder: (_) => const AddSongScreen()),
                  );
                  if (added == true) {
                    ref.invalidate(allSongsFutureProvider);
                  }
                },
              ),
              const SizedBox(height: 36),

              // Os 5 pilares fixos
              Text(
                'OS 5 PILARES DE CADA AULA',
                style: AppTypography.label(color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              const LessonIconRow(),
              const SizedBox(height: 36),

              // Lista de músicas salvas
              Text(
                'MINHAS MÚSICAS',
                style: AppTypography.label(color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),

              songsAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(color: AppColors.actionGreen),
                  ),
                ),
                error: (err, _) => Text('Erro ao listar músicas: $err'),
                data: (songs) {
                  if (songs.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const QuintetIcon(type: QuintetType.music, size: 40),
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
                                  style: AppTypography.bodySmall(color: AppColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: songs.map((song) => _SongCard(song: song)).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SongCard extends ConsumerWidget {
  final Song song;

  const _SongCard({required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(musicRepositoryProvider);

    return FutureBuilder<LessonPlan?>(
      future: repo.getLessonPlan(song.id),
      builder: (context, snapshot) {
        final plan = snapshot.data;
        final currentDay = plan?.currentDay ?? 1;
        final totalDays = plan?.totalDays ?? 1;
        final isCompleted = plan?.isCompleted ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.borderSubtle, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const QuintetIcon(type: QuintetType.music, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: AppTypography.bodyLarge(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song.artist,
                          style: AppTypography.bodySmall(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.iconSlang : AppColors.actionGreen,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      isCompleted ? 'CONCLUÍDO' : 'DIA $currentDay DE $totalDays',
                      style: AppTypography.label(
                        color: AppColors.actionText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Botão Continuar Aula
              PillButton(
                label: isCompleted ? 'REVER AULA' : 'CONTINUAR DIA $currentDay',
                isExpanded: true,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => LessonScreen(
                        song: song,
                        lessonPlan: plan,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
