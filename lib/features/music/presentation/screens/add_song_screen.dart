import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../onboarding/data/repositories/profile_repository.dart';
import '../../../onboarding/domain/models/user_profile.dart';
import '../../../lesson/data/services/lesson_ai_service.dart';
import '../../data/repositories/music_repository.dart';

class AddSongScreen extends ConsumerStatefulWidget {
  const AddSongScreen({super.key});

  @override
  ConsumerState<AddSongScreen> createState() => _AddSongScreenState();
}

class _AddSongScreenState extends ConsumerState<AddSongScreen> {
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _lyricsController = TextEditingController();

  bool _isLoading = false;
  String? _statusText;

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  // Exemplo de preenchimento rápido para testar
  void _fillSampleSong() {
    _titleController.text = 'Seminare';
    _artistController.text = 'Serú Girán (Charly García)';
    _lyricsController.text = '''
Es medianoche en la ciudad
Tu voz me llega como un eco distante
Siento el frío que cala los huesos
Y me acuerdo de vos, de tu risa y tu pelo

No te olvides de mí, che
Que las luces del centro se apagan
Y aunque el mundo parezca un quilombo
Siempre hay un motivo para volver a empezar
'''.trim();
  }

  Future<void> _handleGeneratePlan() async {
    final title = _titleController.text.trim();
    final artist = _artistController.text.trim();
    final lyrics = _lyricsController.text.trim();

    if (title.isEmpty || artist.isEmpty || lyrics.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o título, artista e cole a letra da música.'),
          backgroundColor: AppColors.darkSurface,
        ),
      );
      return;
    }

    // 1. Validação de Privacidade: mostrar aviso na primeira vez
    final storage = ref.read(secureStorageServiceProvider);
    final hasAcceptedPrivacy = await storage.isPrivacyNoticeAccepted();

    if (!hasAcceptedPrivacy) {
      if (!mounted) return;
      final accepted = await _showPrivacyConsentDialog();
      if (!accepted) return;
      await storage.setPrivacyNoticeAccepted(true);
    }

    setState(() {
      _isLoading = true;
      _statusText = 'Analisando letra e estruturando plano com IA...';
    });

    try {
      // 2. Carregar perfil do estudante
      final profileRepo = ref.read(profileRepositoryProvider);
      final profile = await profileRepo.getProfile() ??
          UserProfile(
            objective: 'Aprender por Música',
            spanishLevel: 3,
            dailyMinutes: 15,
            currentKnowledge: 'Básico',
            musicPreferences: 'Rock Argentino',
            createdAt: DateTime.now(),
          );

      // 3. Chamada A: IA gera plano em dias e divisão de seções
      final lessonAi = ref.read(lessonAiServiceProvider);
      final planData = await lessonAi.generatePlan(
        songTitle: title,
        artist: artist,
        fullLyrics: lyrics,
        profile: profile,
      );

      final totalDays = planData['total_days'] as int? ?? 4;
      final sections = (planData['sections'] as List?)
              ?.map((s) => s as Map<String, dynamic>)
              .toList() ??
          [];

      // 4. Salvar no SQLite local
      setState(() {
        _statusText = 'Salvando música e cronograma de dias...';
      });

      final musicRepo = ref.read(musicRepositoryProvider);
      final songId = await musicRepo.insertSongWithSectionsAndPlan(
        title: title,
        artist: artist,
        fullLyrics: lyrics,
        totalDays: totalDays,
        planJson: planData.toString(),
        sections: sections,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Plano de $totalDays dias gerado com sucesso!'),
            backgroundColor: AppColors.darkSurface,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar plano: $e'),
            backgroundColor: AppColors.celebrationAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _statusText = null;
        });
      }
    }
  }

  Future<bool> _showPrivacyConsentDialog() async {
    final storage = ref.read(secureStorageServiceProvider);
    final provider = await storage.getSelectedProvider();

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.darkSurface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Text('Aviso de Privacidade', style: AppTypography.titleMedium()),
            content: Text(
              'A letra da música será enviada para o provedor de IA configurado (${provider.displayName}) para gerar o plano pedagógico.\n\nLembre-se: os planos gratuitos de alguns provedores externos podem processar o conteúdo para aprimorar seus serviços.\n\nDeseja prosseguir com o envio?',
              style: AppTypography.bodySmall(color: AppColors.textLight),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('CANCELAR', style: AppTypography.label(color: AppColors.textMuted)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.actionGreen,
                  foregroundColor: AppColors.actionText,
                  shape: const StadiumBorder(),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('CONCORDAR E ENVIAR', style: AppTypography.button()),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('NOVA MÚSICA', style: AppTypography.titleMedium()),
        backgroundColor: AppColors.darkBackground,
        actions: [
          TextButton(
            onPressed: _fillSampleSong,
            child: Text('Exemplo', style: AppTypography.label(color: AppColors.actionGreen)),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: AppColors.actionGreen),
                    const SizedBox(height: 24),
                    Text(
                      'CRIANDO SEU PLANO DE AULA',
                      style: AppTypography.titleMedium(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _statusText ?? 'Aguarde um momento...',
                      style: AppTypography.bodySmall(color: AppColors.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('COLE A LETRA', style: AppTypography.titleLarge()),
                  const SizedBox(height: 6),
                  Text(
                    'A IA dividirá a música em dias conforme o seu tempo diário disponível.',
                    style: AppTypography.bodySmall(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),

                  // Título da Música
                  Text('TÍTULO DA MÚSICA', style: AppTypography.label(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    style: AppTypography.bodyMedium(color: AppColors.textLight),
                    decoration: InputDecoration(
                      hintText: 'Ex: Seminare, Canción Para Mi Muerte',
                      hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.darkSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Artista
                  Text('ARTISTA OU BANDA', style: AppTypography.label(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _artistController,
                    style: AppTypography.bodyMedium(color: AppColors.textLight),
                    decoration: InputDecoration(
                      hintText: 'Ex: Charly García, Fito Páez, Carlos Gardel',
                      hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.darkSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Letra Completa
                  Text('LETRA COMPLETA (EM ESPANHOL)', style: AppTypography.label(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _lyricsController,
                    maxLines: 10,
                    style: AppTypography.bodyMedium(color: AppColors.textLight),
                    decoration: InputDecoration(
                      hintText: 'Cole a letra completa da música aqui...',
                      hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.darkSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Botão de Ação #c7ff69
                  PillButton(
                    label: 'GERAR PLANO DE AULA',
                    icon: const Icon(Icons.auto_awesome, color: AppColors.actionText),
                    isExpanded: true,
                    onPressed: _handleGeneratePlan,
                  ),
                ],
              ),
            ),
    );
  }
}
