import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
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
              // Logo compacto
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'a',
                      style: AppTypography.titleHuge(color: AppColors.textLight).copyWith(fontSize: 48),
                      children: [
                        TextSpan(
                          text: '.',
                          style: AppTypography.titleHuge(color: AppColors.celebrationAccent).copyWith(fontSize: 48),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ACORDE',
                    style: AppTypography.label(color: AppColors.textMuted, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Título principal
              Text('APRENDA\nESPANHOL\nCOM MÚSICA.', style: AppTypography.titleHuge()),
              const SizedBox(height: 12),
              Text(
                'Espanhol rioplatense (Argentina) analisado estrofe por estrofe pela IA.',
                style: AppTypography.bodyMedium(color: AppColors.supportPurple),
              ),
              const SizedBox(height: 28),

              // Botão principal
              PillButton(
                label: 'COLAR NOVA LETRA',
                icon: const Icon(Icons.add_rounded, color: AppColors.actionText),
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

              // 5 pilares
              Text('OS 5 PILARES DE CADA AULA', style: AppTypography.label(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              const LessonIconRow(),
              const SizedBox(height: 36),

              // Lista de músicas
              Text('MINHAS MÚSICAS', style: AppTypography.label(color: AppColors.textMuted)),
              const SizedBox(height: 16),

              songsAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(color: AppColors.actionGreen),
                  ),
                ),
                error: (err, _) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline_rounded, color: AppColors.celebrationAccent, size: 32),
                      const SizedBox(height: 12),
                      Text(
                        'Erro ao carregar músicas',
                        style: AppTypography.bodyMedium(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$err',
                        style: AppTypography.bodySmall(color: AppColors.textMuted),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                data: (songs) {
                  if (songs.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          const QuintetIcon(type: QuintetType.music, size: 56),
                          const SizedBox(height: 16),
                          Text(
                            'NENHUMA MÚSICA AINDA',
                            style: AppTypography.label(color: AppColors.textLight),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Cole uma letra de tango, rock nacional ou trap argentino para começar.',
                            style: AppTypography.bodySmall(color: AppColors.textMuted),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: songs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final song = entry.value;
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 200 + (index * 60).clamp(0, 300)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 12 * (1 - value)),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: _SongCard(song: song),
                      );
                    }).toList(),
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
            border: Border.all(
              color: isCompleted ? AppColors.iconSlang.withValues(alpha: 0.4) : AppColors.borderSubtle,
              width: 1.5,
            ),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          song.artist,
                          style: AppTypography.bodySmall(color: AppColors.textMuted),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.iconSlang : AppColors.actionGreen,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      isCompleted ? 'CONCLUÍDO' : 'DIA $currentDay/$totalDays',
                      style: AppTypography.label(
                        color: AppColors.actionText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Barra de progresso visual
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: isCompleted ? 1.0 : (currentDay - 1) / totalDays,
                  minHeight: 4,
                  backgroundColor: AppColors.darkBackground,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCompleted ? AppColors.iconSlang : AppColors.actionGreen,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  _AudioButton(
                    song: song,
                    repo: repo,
                    onAudioAttached: () => ref.invalidate(allSongsFutureProvider),
                  ),
                  Expanded(
                    child: PillButton(
                      label: isCompleted ? 'REVER AULA' : 'CONTINUAR DIA $currentDay',
                      isExpanded: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => LessonScreen(song: song, lessonPlan: plan),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AudioButton extends StatefulWidget {
  final Song song;
  final MusicRepository repo;
  final VoidCallback onAudioAttached;

  const _AudioButton({
    required this.song,
    required this.repo,
    required this.onAudioAttached,
  });

  @override
  State<_AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<_AudioButton> {
  AudioPlayer? _player;
  bool _isPlaying = false;

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    final path = widget.song.audioPath;
    if (path == null) return;

    if (_player == null) {
      _player = AudioPlayer();
      _player!.playerStateStream.listen((state) {
        if (!mounted) return;
        final playing = state.playing && state.processingState != ProcessingState.completed;
        if (_isPlaying != playing) {
          setState(() => _isPlaying = playing);
        }
        if (state.processingState == ProcessingState.completed) {
          _player!.seek(Duration.zero);
          _player!.pause();
        }
      });
    }

    if (_isPlaying) {
      await _player!.pause();
    } else {
      final file = File(path);
      if (!await file.exists()) return;
      if (_player!.processingState == ProcessingState.idle ||
          _player!.processingState == ProcessingState.completed) {
        await _player!.setFilePath(path);
      }
      await _player!.play();
    }
  }

  Future<void> _attachAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final audioDir = Directory(p.join(appDir.path, 'audio'));
      if (!await audioDir.exists()) await audioDir.create(recursive: true);
      final ext = p.extension(result.files.single.path!);
      final dest = p.join(audioDir.path, '${DateTime.now().millisecondsSinceEpoch}$ext');
      await File(result.files.single.path!).copy(dest);
      await widget.repo.updateSongAudio(widget.song.id, dest);
      widget.onAudioAttached();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAudio = widget.song.audioPath != null;

    return GestureDetector(
      onTap: hasAudio ? _togglePlayback : _attachAudio,
      onLongPress: hasAudio ? _attachAudio : null,
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: hasAudio
              ? (_isPlaying ? AppColors.iconMusic.withValues(alpha: 0.3) : AppColors.iconMusic.withValues(alpha: 0.15))
              : AppColors.darkBackground,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: hasAudio ? AppColors.iconMusic : AppColors.borderSubtle,
            width: 1.5,
          ),
        ),
        child: Icon(
          hasAudio
              ? (_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded)
              : Icons.add_rounded,
          color: hasAudio ? AppColors.iconMusic : AppColors.textMuted,
          size: 22,
        ),
      ),
    );
  }
}
