import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/secure_storage_service.dart';
import 'ai_provider.dart';
import 'openai_compatible_provider.dart';

final aiGatewayServiceProvider = Provider<AiGatewayService>((ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return AiGatewayService(storage);
});

class AiGatewayService {
  final SecureStorageService _storage;

  AiGatewayService(this._storage);

  /// Cria a instância do provedor ativo configurado pelo usuário.
  Future<AiProvider> getActiveProvider() async {
    final providerType = await _storage.getSelectedProvider();
    final model = await _storage.getModel(providerType);
    final apiKey = await _storage.getApiKey(providerType) ?? '';

    return OpenAiCompatibleProvider(
      name: providerType.displayName,
      baseUrl: providerType.baseUrl,
      apiKey: apiKey,
      model: model,
    );
  }

  /// Teste de conexão simples ("olá" em espanhol argentino com validação de JSON)
  Future<String> testConnection() async {
    final provider = await getActiveProvider();

    const systemPrompt = '''
Você é o motor de IA do Acorde, app de aprendizado de espanhol rioplatense (Argentina).
Responda em formato JSON com o seguinte formato:
{
  "status": "ok",
  "message": "uma saudação curta e amigável em espanhol argentino usando vos (ex: ¡Hola, che! Todo en orden por acá.)"
}
''';

    const userPrompt = 'Teste de conexão com o Acorde. Por favor, confirme o funcionamento.';

    final response = await provider.complete(
      system: systemPrompt,
      user: userPrompt,
      jsonMode: true,
    );

    try {
      final decoded = jsonDecode(response) as Map<String, dynamic>;
      final message = decoded['message'] as String? ?? '¡Hola! Conexión exitosa.';
      return message;
    } catch (e) {
      return response;
    }
  }
}
