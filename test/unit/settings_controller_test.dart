import 'package:flutter_test/flutter_test.dart';
import 'package:acorde/core/storage/secure_storage_service.dart';

void main() {
  group('AiProviderType configuration tests', () {
    test('Default provider is Groq with llama-3.3-70b-versatile', () {
      final provider = AiProviderType.fromId('groq');
      expect(provider, AiProviderType.groq);
      expect(provider.baseUrl, 'https://api.groq.com/openai/v1');
      expect(provider.defaultModel, 'llama-3.3-70b-versatile');
    });

    test('Gemini provider is configured with OpenAI compatible endpoint', () {
      final provider = AiProviderType.fromId('gemini');
      expect(provider, AiProviderType.gemini);
      expect(provider.baseUrl, 'https://generativelanguage.googleapis.com/v1beta/openai/');
      expect(provider.defaultModel, 'gemini-2.0-flash');
    });

    test('Fallback to Groq if invalid ID is provided', () {
      final provider = AiProviderType.fromId('unknown_provider');
      expect(provider, AiProviderType.groq);
    });
  });
}
