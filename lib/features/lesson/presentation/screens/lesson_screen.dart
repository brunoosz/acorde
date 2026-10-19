import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/widgets/lesson_icon_row.dart';
import '../../../../core/tts/tts_service.dart';
import '../../../../core/widgets/audio_player_bar.dart';
import '../../../../core/database/database_provider.dart';
import '../../../music/domain/models/song.dart';
import '../../../music/data/repositories/music_repository.dart';
import '../../../onboarding/data/repositories/profile_repository.dart';
import '../../../onboarding/domain/models/user_profile.dart';
import '../../data/services/lesson_ai_service.dart';
import '../../domain/models/lesson_plan.dart';
import '../../domain/models/lesson_day_content.dart';
import '../widgets/vocab_flip_card.dart';

class LessonScreen extends ConsumerStatefulWidget {
  final Song song;
  final LessonPlan? lessonPlan;

  const LessonScreen({
    super.key,
    required this.song,
    required this.lessonPlan,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  DayLessonContent? _dayContent;
  bool _isLoading = true;
  String? _errorMessage;
  QuintetType? _selectedFilter;
  final Set<String> _savedWords = {};

  @override
  void initState() {
    super.initState();
    _loadDayContent();
  }

  Future<void> _loadDayContent() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final musicRepo = ref.read(musicRepositoryProvider);
      final profileRepo = ref.read(profileRepositoryProvider);
      final lessonAi = ref.read(lessonAiServiceProvider);

      final profile = await profileRepo.getProfile() ??
          UserProfile(
            objective: 'Aprender por Música',
            spanishLevel: 3,
            dailyMinutes: 15,
            currentKnowledge: 'Básico',
            musicPreferences: 'Rock Argentino',
            createdAt: DateTime.now(),
          );

      final currentDay = widget.lessonPlan?.currentDay ?? 1;
      final planDay = widget.lessonPlan?.days.firstWhere(
            (d) => d.day == currentDay,
            orElse: () => PlanDay(day: currentDay, title: 'Dia $currentDay', sectionIds: [1]),
          ) ??
          PlanDay(day: currentDay, title: 'Dia $currentDay', sectionIds: [1]);

      // Buscar seções da música
      final allSections = await musicRepo.getSongSections(widget.song.id);
      final daySections = allSections.where((s) => planDay.sectionIds.contains(s.sectionOrder)).toList();

      final sectionsToUse = daySections.isNotEmpty ? daySections : allSections;

      final content = await lessonAi.getOrGenerateDayLesson(
        songId: widget.song.id,
        day: currentDay,
        dayTitle: planDay.title,
        daySections: sectionsToUse,
        profile: profile,
      );

      if (mounted) {
        setState(() {
          _dayContent = content;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _completeDay() async {
    final plan = widget.lessonPlan;
    if (plan == null) return;

    final musicRepo = ref.read(musicRepositoryProvider);
    final nextDay = plan.currentDay + 1;
    final isDone = nextDay > plan.totalDays;

    await musicRepo.updatePlanProgress(
      widget.song.id,
      isDone ? plan.totalDays : nextDay,
      isDone,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isDone
                ? '¡Felicitaciones! Você concluiu toda a música ${widget.song.title}!'
                : 'Dia ${plan.currentDay} concluído! Avançando para o Dia $nextDay.',
          ),
          backgroundColor: AppColors.actionGreen,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveWord(LessonVocabItem item) async {
    final db = ref.read(appDatabaseProvider);
    await db.saveWordWithInitialReview(
      word: item.word,
      translation: item.translation,
      exampleSentence: item.example,
      origin: '${widget.song.title} (${widget.song.artist})',
      songId: widget.song.id,
    );

    setState(() {
      _savedWords.add(item.word);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${item.word}" salva! Revisão agendada para amanhã.'),
          backgroundColor: AppColors.darkSurface,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tts = ref.watch(ttsServiceProvider);
    final currentDay = widget.lessonPlan?.currentDay ?? 1;
    final totalDays = widget.lessonPlan?.totalDays ?? 1;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.song.title, style: AppTypography.titleMedium()),
            Text(
              'DIA $currentDay DE $totalDays',
              style: AppTypography.label(color: AppColors.actionGreen),
            ),
          ],
        ),
        backgroundColor: AppColors.darkBackground,
      ),
      body: _isLoading
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: AppColors.actionGreen),
                    const SizedBox(height: 24),
                    Text(
                      'PREPARANDO SUA AULA...',
                      style: AppTypography.titleMedium(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Analisando pronúncia rioplatense, gírias e gramática.',
                      style: AppTypography.bodySmall(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.celebrationAccent, size: 48),
                        const SizedBox(height: 16),
                        Text('ERRO AO CARREGAR AULA', style: AppTypography.titleMedium()),
                        const SizedBox(height: 8),
                        Text(_errorMessage!, style: AppTypography.bodySmall(color: AppColors.textMuted), textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        PillButton(label: 'TENTAR NOVAMENTE', onPressed: _loadDayContent),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Player de áudio (se disponível)
                      if (widget.song.audioPath != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AudioPlayerBar(
                            audioPath: widget.song.audioPath!,
                            songTitle: widget.song.title,
                          ),
                        ),

                      // Fileira com os 5 ícones no topo
                      LessonIconRow(
                        activeType: _selectedFilter,
                        onSelect: (type) {
                          setState(() {
                            _selectedFilter = _selectedFilter == type ? null : type;
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Aviso se TTS estiver usando fallback com botão para baixar voz
                      if (tts.isFallback)
                        Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.darkSurface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.supportPurple.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.record_voice_over_outlined, size: 18, color: AppColors.supportPurple),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Voz em espanhol argentino não encontrada',
                                      style: AppTypography.label(color: AppColors.supportPurple),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Para melhor pronúncia, baixe a voz "Espanhol (Argentina)" nas configurações de TTS do seu dispositivo.',
                                style: AppTypography.bodySmall(color: AppColors.textMuted),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await tts.openTtsSettings();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: AppColors.supportPurple, width: 1.5),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'ABRIR CONFIG. DE VOZ',
                                          style: AppTypography.label(color: AppColors.supportPurple, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      await tts.reinitialize();
                                      if (mounted) setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.actionGreen,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Text(
                                        'RECARREGAR',
                                        style: AppTypography.label(color: AppColors.actionText, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      Text(
                        _dayContent?.dayTitle ?? 'Aula do Dia',
                        style: AppTypography.titleLarge(),
                      ),
                      const SizedBox(height: 20),

                      // Blocos para cada seção da música do dia
                      if (_dayContent != null)
                        ..._dayContent!.sections.map(
                          (sec) => _buildSectionBlock(context, sec, tts),
                        ),

                      const SizedBox(height: 32),

                      // Botão Concluir Dia
                      PillButton(
                        label: currentDay == totalDays ? 'CONCLUIR MÚSICA' : 'CONCLUIR DIA $currentDay',
                        icon: const Icon(Icons.check_circle_outline, color: AppColors.actionText),
                        isExpanded: true,
                        onPressed: _completeDay,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildSectionBlock(BuildContext context, SectionLessonBlock block, TtsService tts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Faixa Clara de Leitura da Letra (Estilo Navigate: #fdf9f0 com texto #141414)
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.lightLessonBackground, // #fdf9f0
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    block.sectionLabel.toUpperCase(),
                    style: AppTypography.label(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Row(
                    children: [
                      // Ouvir normal
                      IconButton(
                        icon: const Icon(Icons.volume_up_rounded, color: AppColors.textDark),
                        tooltip: 'Ouvir velocidade normal',
                        onPressed: () => tts.speak(block.originalText, slow: false),
                      ),
                      // Ouvir devagar (controle de velocidade)
                      IconButton(
                        icon: const Icon(Icons.slow_motion_video_rounded, color: AppColors.textDark),
                        tooltip: 'Ouvir devagar',
                        onPressed: () => tts.speak(block.originalText, slow: true),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                block.originalText,
                style: AppTypography.bodyLarge(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.textMuted.withValues(alpha: 0.3))),
                ),
                child: Text(
                  block.translationPt,
                  style: AppTypography.bodyMedium(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Os 5 Pilares para este trecho:
        // 1. Pronúncia
        if (_selectedFilter == null || _selectedFilter == QuintetType.pronunciation)
          _buildPillarCard(
            type: QuintetType.pronunciation,
            title: 'PRONÚNCIA RIOPLATENSE',
            content: block.pronunciation,
            tts: tts,
          ),

        // 2. Gírias e Expressões
        if (_selectedFilter == null || _selectedFilter == QuintetType.slang)
          _buildPillarCard(
            type: QuintetType.slang,
            title: 'GÍRIAS & LUNFARDO',
            content: block.slang,
            tts: tts,
          ),

        // 3. Gramática
        if (_selectedFilter == null || _selectedFilter == QuintetType.grammar)
          _buildPillarCard(
            type: QuintetType.grammar,
            title: 'GRAMÁTICA & VOSEO',
            content: block.grammar,
            tts: tts,
          ),

        // 4. Falsos Cognatos
        if (_selectedFilter == null || _selectedFilter == QuintetType.falseFriends)
          _buildPillarCard(
            type: QuintetType.falseFriends,
            title: 'FALSOS COGNATOS (ARMADILHAS)',
            content: block.falseFriends,
            tts: tts,
          ),

        // 5. Vocabulário Salvo
        if (_selectedFilter == null || _selectedFilter == QuintetType.vocab)
          if (block.vocab.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Row(
                children: [
                  const QuintetIcon(type: QuintetType.vocab, size: 28),
                  const SizedBox(width: 8),
                  Text('VOCABULÁRIO DO TRECHO', style: AppTypography.label(color: AppColors.iconVocab)),
                ],
              ),
            ),
            ...block.vocab.map(
              (item) => VocabFlipCard(
                item: item,
                isSaved: _savedWords.contains(item.word),
                onSpeak: () => tts.speak(item.word),
                onSave: () => _saveWord(item),
              ),
            ),
          ],

        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildPillarCard({
    required QuintetType type,
    required String title,
    required String content,
    required TtsService tts,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 250),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                QuintetIcon(type: type, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.label(color: AppColors.textLight),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: AppTypography.bodyMedium(color: AppColors.supportGrey),
            ),
          ],
        ),
      ),
    );
  }
}
