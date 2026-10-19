import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());
  return service;
});

class TtsService {
  final FlutterTts _flutterTts;
  String _activeLanguage = 'es-AR';
  bool _isFallback = false;
  bool _isInitialized = false;

  TtsService([FlutterTts? flutterTts]) : _flutterTts = flutterTts ?? FlutterTts();

  String get activeLanguage => _activeLanguage;
  bool get isFallback => _isFallback;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final languages = await _flutterTts.getLanguages;
      final langList = (languages as List?)?.map((e) => e.toString()).toList() ?? [];

      // Spanish language candidates in priority order
      const candidates = ['es-AR', 'es_AR', 'es-US', 'es_US', 'es-MX', 'es_MX', 'es-ES', 'es_ES', 'es'];

      String? matched;
      for (final candidate in candidates) {
        final found = langList.firstWhere(
          (l) => l.toLowerCase() == candidate.toLowerCase(),
          orElse: () => '',
        );
        if (found.isNotEmpty) {
          matched = found;
          break;
        }
      }

      // If exact match failed, try partial match for any "es" language
      if (matched == null) {
        final found = langList.firstWhere(
          (l) => l.toLowerCase().startsWith('es'),
          orElse: () => '',
        );
        if (found.isNotEmpty) matched = found;
      }

      if (matched != null) {
        _activeLanguage = matched;
        _isFallback = !matched.toLowerCase().contains('es-ar') && !matched.toLowerCase().contains('es_ar');
      } else {
        _activeLanguage = 'es-ES';
        _isFallback = true;
      }

      // Set language and verify it was accepted
      final setResult = await _flutterTts.setLanguage(_activeLanguage);
      if (setResult != 1) {
        // If setLanguage failed, try the generic 'es'
        await _flutterTts.setLanguage('es');
        _activeLanguage = 'es';
        _isFallback = true;
      }

      await _flutterTts.setSpeechRate(0.48);
      await _flutterTts.setPitch(1.0);
    } catch (_) {
      _activeLanguage = 'es';
      _isFallback = true;
      try {
        await _flutterTts.setLanguage('es');
      } catch (_) {}
    }

    _isInitialized = true;
  }

  Future<void> speak(String text, {bool slow = false}) async {
    await initialize();
    await _flutterTts.stop();
    // Re-assert language before every speak call to prevent device default fallback
    await _flutterTts.setLanguage(_activeLanguage);
    await _flutterTts.setSpeechRate(slow ? 0.28 : 0.48);
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  void setProgressHandler(void Function(String text, int start, int end, String word) handler) {
    _flutterTts.setProgressHandler(handler);
  }

  void setCompletionHandler(void Function() handler) {
    _flutterTts.setCompletionHandler(handler);
  }

  void dispose() {
    _flutterTts.stop();
  }
}
