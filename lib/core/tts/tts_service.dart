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

      // Prioridade 1: es-AR (Espanhol Argentino)
      if (langList.any((l) => l.toLowerCase().contains('es-ar') || l.toLowerCase().contains('es_ar'))) {
        _activeLanguage = 'es-AR';
        _isFallback = false;
      }
      // Fallback 1: es-US
      else if (langList.any((l) => l.toLowerCase().contains('es-us') || l.toLowerCase().contains('es_us'))) {
        _activeLanguage = 'es-US';
        _isFallback = true;
      }
      // Fallback 2: es-ES
      else if (langList.any((l) => l.toLowerCase().contains('es-es') || l.toLowerCase().contains('es_es'))) {
        _activeLanguage = 'es-ES';
        _isFallback = true;
      } else {
        _activeLanguage = 'es';
        _isFallback = true;
      }

      await _flutterTts.setLanguage(_activeLanguage);
      await _flutterTts.setSpeechRate(0.5); // Velocidade normal
      await _flutterTts.setPitch(1.0);
    } catch (_) {
      _activeLanguage = 'es-AR';
      _isFallback = true;
    }

    _isInitialized = true;
  }

  Future<void> speak(String text, {bool slow = false}) async {
    await initialize();
    await _flutterTts.stop();
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
