import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../onboarding/data/repositories/profile_repository.dart';
import '../../../onboarding/domain/models/user_profile.dart';
import '../../../lesson/data/services/lesson_ai_service.dart';
import '../../data/repositories/music_repository.dart';
import '../../data/services/spotify_service.dart';

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
  String? _selectedAudioPath;
  String? _selectedAudioName;

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  Future<void> _importFromSpotify() async {
    final urlController = TextEditingController();
    final spotifyUrl = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text('IMPORTAR DO SPOTIFY', style: AppTypography.titleMedium()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cole o link de uma música ou playlist do Spotify.',
              style: AppTypography.bodySmall(color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              style: AppTypography.bodyMedium(color: AppColors.textLight),
              decoration: InputDecoration(
                hintText: 'https://open.spotify.com/track/... ou /playlist/...',
                hintStyle: AppTypography.bodySmall(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.darkBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('CANCELAR', style: AppTypography.label(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1DB954),
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
            ),
            onPressed: () => Navigator.of(ctx).pop(urlController.text.trim()),
            child: Text('IMPORTAR', style: AppTypography.button(color: Colors.white)),
          ),
        ],
      ),
    );

    if (spotifyUrl == null || spotifyUrl.isEmpty) return;

    final spotify = ref.read(spotifyServiceProvider);
    if (!spotify.isSpotifyUrl(spotifyUrl)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('URL inválida. Cole um link do Spotify (track ou playlist).'),
            backgroundColor: AppColors.darkSurface,
          ),
        );
      }
      return;
    }

    // Handle playlist URLs — show track picker
    if (spotify.isPlaylistUrl(spotifyUrl)) {
      await _importFromSpotifyPlaylist(spotifyUrl);
      return;
    }

    // Handle single track URL
    final info = await spotify.getTrackInfo(spotifyUrl);
    if (info != null && mounted) {
      setState(() {
        _titleController.text = info.title;
        _artistController.text = info.artist;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Importado: ${info.title} - ${info.artist}. Agora cole a letra!'),
          backgroundColor: AppColors.darkSurface,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível obter dados do Spotify. Verifique o link.'),
          backgroundColor: AppColors.celebrationAccent,
        ),
      );
    }
  }

  Future<void> _importFromSpotifyPlaylist(String playlistUrl) async {
    if (!mounted) return;

    // Show loading dialog while fetching tracks
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Color(0xFF1DB954)),
            const SizedBox(height: 16),
            Text('Carregando playlist...', style: AppTypography.bodyMedium(color: AppColors.textLight)),
          ],
        ),
      ),
    );

    final spotify = ref.read(spotifyServiceProvider);
    final tracks = await spotify.getPlaylistTracks(playlistUrl);

    if (!mounted) return;
    Navigator.of(context).pop(); // dismiss loading

    if (tracks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Playlist vazia ou não foi possível carregar. Verifique as credenciais do Spotify nas Configurações.'),
          backgroundColor: AppColors.celebrationAccent,
        ),
      );
      return;
    }

    // Show track picker
    final selected = await showModalBottomSheet<SpotifyTrackInfo>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) => _PlaylistTrackPicker(tracks: tracks),
    );

    if (selected != null && mounted) {
      setState(() {
        _titleController.text = selected.title;
        _artistController.text = selected.artist;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecionado: ${selected.title} - ${selected.artist}. Agora cole a letra!'),
          backgroundColor: AppColors.darkSurface,
        ),
      );
    }
  }

  Future<void> _searchSpotify() async {
    final spotify = ref.read(spotifyServiceProvider);
    final isConfigured = await spotify.isConfigured;
    if (!isConfigured) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Configure as credenciais do Spotify em Configurações para buscar músicas.'),
            backgroundColor: AppColors.celebrationAccent,
          ),
        );
      }
      return;
    }

    if (!mounted) return;
    final selected = await showModalBottomSheet<SpotifyTrackInfo>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) => _SpotifySearchSheet(spotify: spotify),
    );

    if (selected != null && mounted) {
      setState(() {
        _titleController.text = selected.title;
        _artistController.text = selected.artist;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecionado: ${selected.title} - ${selected.artist}. Agora cole a letra!'),
          backgroundColor: AppColors.darkSurface,
        ),
      );
    }
  }

  Future<void> _pickAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedAudioPath = result.files.single.path;
        _selectedAudioName = result.files.single.name;
      });
    }
  }

  Future<String?> _copyAudioToAppDir(String sourcePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory(p.join(appDir.path, 'audio'));
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }
    final ext = p.extension(sourcePath);
    final destPath = p.join(audioDir.path, '${DateTime.now().millisecondsSinceEpoch}$ext');
    await File(sourcePath).copy(destPath);
    return destPath;
  }

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

      // 4. Copiar áudio para diretório do app (se selecionado)
      String? savedAudioPath;
      if (_selectedAudioPath != null) {
        setState(() {
          _statusText = 'Salvando arquivo de áudio...';
        });
        savedAudioPath = await _copyAudioToAppDir(_selectedAudioPath!);
      }

      // 5. Salvar no SQLite local
      setState(() {
        _statusText = 'Salvando música e cronograma de dias...';
      });

      final musicRepo = ref.read(musicRepositoryProvider);
      final songId = await musicRepo.insertSongWithSectionsAndPlan(
        title: title,
        artist: artist,
        fullLyrics: lyrics,
        totalDays: totalDays,
        planJson: jsonEncode(planData),
        sections: sections,
        audioPath: savedAudioPath,
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
          if (kDebugMode)
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
                  const SizedBox(height: 16),

                  // Importar do Spotify
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _importFromSpotify,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DB954).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xFF1DB954), width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.link_rounded, color: Color(0xFF1DB954), size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'LINK / PLAYLIST',
                                  style: AppTypography.label(color: const Color(0xFF1DB954), fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: _searchSpotify,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DB954).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: const Color(0xFF1DB954), width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.search_rounded, color: Color(0xFF1DB954), size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'BUSCAR',
                                  style: AppTypography.label(color: const Color(0xFF1DB954), fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  const SizedBox(height: 24),

                  // Áudio da música (opcional)
                  Text('ÁUDIO DA MÚSICA (OPCIONAL)', style: AppTypography.label(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickAudioFile,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: _selectedAudioName != null ? AppColors.actionGreen : AppColors.borderSubtle,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedAudioName != null ? Icons.audiotrack_rounded : Icons.upload_file_rounded,
                            color: _selectedAudioName != null ? AppColors.actionGreen : AppColors.textMuted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedAudioName ?? 'Toque para selecionar um arquivo de áudio',
                              style: AppTypography.bodyMedium(
                                color: _selectedAudioName != null ? AppColors.textLight : AppColors.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_selectedAudioName != null)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAudioPath = null;
                                  _selectedAudioName = null;
                                });
                              },
                              child: const Icon(Icons.close_rounded, color: AppColors.textMuted, size: 20),
                            ),
                        ],
                      ),
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

class _PlaylistTrackPicker extends StatefulWidget {
  final List<SpotifyTrackInfo> tracks;

  const _PlaylistTrackPicker({required this.tracks});

  @override
  State<_PlaylistTrackPicker> createState() => _PlaylistTrackPickerState();
}

class _PlaylistTrackPickerState extends State<_PlaylistTrackPicker> {
  String _search = '';

  List<SpotifyTrackInfo> get _filtered {
    if (_search.isEmpty) return widget.tracks;
    final q = _search.toLowerCase();
    return widget.tracks
        .where((t) => t.title.toLowerCase().contains(q) || t.artist.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.75;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textMuted,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Icon(Icons.queue_music_rounded, color: Color(0xFF1DB954), size: 22),
                const SizedBox(width: 10),
                Text(
                  'PLAYLIST (${widget.tracks.length} músicas)',
                  style: AppTypography.titleMedium(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: AppTypography.bodyMedium(color: AppColors.textLight),
              decoration: InputDecoration(
                hintText: 'Buscar na playlist...',
                hintStyle: AppTypography.bodySmall(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.darkBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final track = _filtered[i];
                return ListTile(
                  leading: track.thumbnailUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            track.thumbnailUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.darkBackground,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.music_note_rounded, color: AppColors.textMuted),
                            ),
                          ),
                        )
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.darkBackground,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.music_note_rounded, color: AppColors.textMuted),
                        ),
                  title: Text(
                    track.title,
                    style: AppTypography.bodyMedium(color: AppColors.textLight),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    track.artist,
                    style: AppTypography.bodySmall(color: AppColors.textMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onTap: () => Navigator.of(ctx).pop(track),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SpotifySearchSheet extends StatefulWidget {
  final SpotifyService spotify;

  const _SpotifySearchSheet({required this.spotify});

  @override
  State<_SpotifySearchSheet> createState() => _SpotifySearchSheetState();
}

class _SpotifySearchSheetState extends State<_SpotifySearchSheet> {
  final _controller = TextEditingController();
  List<SpotifyTrackInfo> _results = [];
  bool _loading = false;
  bool _searched = false;

  Future<void> _doSearch() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    setState(() {
      _loading = true;
      _searched = true;
    });
    final results = await widget.spotify.searchTracks(query, limit: 20);
    if (mounted) {
      setState(() {
        _results = results;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.8;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textMuted,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Color(0xFF1DB954), size: 22),
                const SizedBox(width: 10),
                Text('BUSCAR NO SPOTIFY', style: AppTypography.titleMedium()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _doSearch(),
                    textInputAction: TextInputAction.search,
                    style: AppTypography.bodyMedium(color: AppColors.textLight),
                    decoration: InputDecoration(
                      hintText: 'Nome da música ou artista...',
                      hintStyle: AppTypography.bodySmall(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.darkBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _doSearch,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1DB954),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.search_rounded, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(color: Color(0xFF1DB954)),
            )
          else if (_results.isEmpty && _searched)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Nenhum resultado encontrado.',
                style: AppTypography.bodyMedium(color: AppColors.textMuted),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                itemCount: _results.length,
                itemBuilder: (ctx, i) {
                  final track = _results[i];
                  return ListTile(
                    leading: track.thumbnailUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              track.thumbnailUrl!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.darkBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.music_note_rounded, color: AppColors.textMuted),
                              ),
                            ),
                          )
                        : Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.darkBackground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.music_note_rounded, color: AppColors.textMuted),
                          ),
                    title: Text(
                      track.title,
                      style: AppTypography.bodyMedium(color: AppColors.textLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      track.artist,
                      style: AppTypography.bodySmall(color: AppColors.textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    onTap: () => Navigator.of(ctx).pop(track),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
