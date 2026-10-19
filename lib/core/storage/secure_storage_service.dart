import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return const SecureStorageService();
});

enum AiProviderType {
  groq('groq', 'Groq', 'https://api.groq.com/openai/v1', 'llama-3.3-70b-versatile'),
  gemini('gemini', 'Gemini (Google)', 'https://generativelanguage.googleapis.com/v1beta/openai/', 'gemini-2.0-flash'),
  ollama('ollama', 'Ollama (Local/Windows)', 'http://localhost:11434/v1', 'llama3.2');

  final String id;
  final String displayName;
  final String baseUrl;
  final String defaultModel;

  const AiProviderType(this.id, this.displayName, this.baseUrl, this.defaultModel);

  static AiProviderType fromId(String? id) {
    return AiProviderType.values.firstWhere(
      (p) => p.id == id,
      orElse: () => AiProviderType.groq,
    );
  }
}

class SecureStorageService {
  final FlutterSecureStorage _storage;

  const SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  static const String _keyProvider = 'acorde_ai_selected_provider';
  static const String _keyPrivacyAccepted = 'acorde_privacy_accepted';
  static const String _keySpotifyClientId = 'acorde_spotify_client_id';
  static const String _keySpotifyClientSecret = 'acorde_spotify_client_secret';
  static const String _keySpotifyAccessToken = 'acorde_spotify_access_token';
  static const String _keySpotifyTokenExpiry = 'acorde_spotify_token_expiry';

  String _keyForApiKey(String providerId) => 'acorde_api_key_$providerId';
  String _keyForModel(String providerId) => 'acorde_model_$providerId';

  // Provedor Ativo
  Future<AiProviderType> getSelectedProvider() async {
    final id = await _storage.read(key: _keyProvider);
    return AiProviderType.fromId(id);
  }

  Future<void> setSelectedProvider(AiProviderType provider) async {
    await _storage.write(key: _keyProvider, value: provider.id);
  }

  // Chave de API por provedor
  Future<String?> getApiKey(AiProviderType provider) async {
    return await _storage.read(key: _keyForApiKey(provider.id));
  }

  Future<void> setApiKey(AiProviderType provider, String apiKey) async {
    await _storage.write(key: _keyForApiKey(provider.id), value: apiKey.trim());
  }

  // Modelo configurável por provedor
  Future<String> getModel(AiProviderType provider) async {
    final customModel = await _storage.read(key: _keyForModel(provider.id));
    if (customModel != null && customModel.trim().isNotEmpty) {
      return customModel.trim();
    }
    return provider.defaultModel;
  }

  Future<void> setModel(AiProviderType provider, String model) async {
    await _storage.write(key: _keyForModel(provider.id), value: model.trim());
  }

  // Confirmação de privacidade (aviso de envio de letra para provedor externo)
  Future<bool> isPrivacyNoticeAccepted() async {
    final val = await _storage.read(key: _keyPrivacyAccepted);
    return val == 'true';
  }

  Future<void> setPrivacyNoticeAccepted(bool accepted) async {
    await _storage.write(key: _keyPrivacyAccepted, value: accepted.toString());
  }

  // Spotify Credentials
  Future<String?> getSpotifyClientId() async {
    return await _storage.read(key: _keySpotifyClientId);
  }

  Future<void> setSpotifyClientId(String clientId) async {
    await _storage.write(key: _keySpotifyClientId, value: clientId.trim());
  }

  Future<String?> getSpotifyClientSecret() async {
    return await _storage.read(key: _keySpotifyClientSecret);
  }

  Future<void> setSpotifyClientSecret(String clientSecret) async {
    await _storage.write(key: _keySpotifyClientSecret, value: clientSecret.trim());
  }

  Future<String?> getSpotifyAccessToken() async {
    final expiry = await _storage.read(key: _keySpotifyTokenExpiry);
    if (expiry != null) {
      final expiryTime = DateTime.tryParse(expiry);
      if (expiryTime != null && expiryTime.isBefore(DateTime.now())) {
        return null;
      }
    }
    return await _storage.read(key: _keySpotifyAccessToken);
  }

  Future<void> setSpotifyAccessToken(String token, Duration expiresIn) async {
    await _storage.write(key: _keySpotifyAccessToken, value: token);
    final expiry = DateTime.now().add(expiresIn).toIso8601String();
    await _storage.write(key: _keySpotifyTokenExpiry, value: expiry);
  }

  Future<bool> hasSpotifyCredentials() async {
    final clientId = await getSpotifyClientId();
    final clientSecret = await getSpotifyClientSecret();
    return clientId != null && clientId.isNotEmpty && clientSecret != null && clientSecret.isNotEmpty;
  }

  // Apagar todas as chaves e credenciais seguras
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
