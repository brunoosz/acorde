import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:acorde/core/ai_gateway/ai_provider.dart';
import 'package:acorde/core/ai_gateway/openai_compatible_provider.dart';

void main() {
  group('AI Gateway & Provider Unit Tests', () {
    test('Throws AiMissingKeyException if API key is blank', () async {
      final provider = OpenAiCompatibleProvider(
        name: 'Groq',
        baseUrl: 'https://api.groq.com/openai/v1',
        apiKey: '   ',
        model: 'llama-3.3-70b-versatile',
      );

      expect(
        () => provider.complete(system: 'test', user: 'test'),
        throwsA(isA<AiMissingKeyException>()),
      );
    });

    test('Markdown sanitization properly removes code fences', () {
      const rawWithFences = '''```json
{
  "status": "ok",
  "message": "¡Hola, che!"
}
```''';

      String sanitize(String raw) {
        String text = raw.trim();
        if (text.startsWith('```json')) {
          text = text.substring(7);
        } else if (text.startsWith('```')) {
          text = text.substring(3);
        }
        if (text.endsWith('```')) {
          text = text.substring(0, text.length - 3);
        }
        return text.trim();
      }

      final sanitized = sanitize(rawWithFences);
      final decoded = jsonDecode(sanitized) as Map<String, dynamic>;
      expect(decoded['status'], 'ok');
      expect(decoded['message'], '¡Hola, che!');
    });

    test('AiRateLimitException carries correct HTTP 429 status code', () {
      const ex = AiRateLimitException();
      expect(ex.statusCode, 429);
      expect(ex.toString(), contains('429'));
    });
  });
}
