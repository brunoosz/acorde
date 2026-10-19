import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'ai_provider.dart';

class OpenAiCompatibleProvider implements AiProvider {
  @override
  final String name;
  final String baseUrl;
  final String apiKey;
  final String model;
  final Dio _dio;

  OpenAiCompatibleProvider({
    required this.name,
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 30),
                receiveTimeout: const Duration(seconds: 45),
                sendTimeout: const Duration(seconds: 30),
              ),
            );

  @override
  Future<String> complete({
    required String system,
    required String user,
    bool jsonMode = false,
  }) async {
    if (apiKey.trim().isEmpty) {
      throw const AiMissingKeyException();
    }

    // Tentativa com suporte a retry em caso de JSON inválido
    try {
      return await _executeWithRetry(
        system: system,
        user: user,
        jsonMode: jsonMode,
      );
    } on AiInvalidJsonException {
      // Se veio JSON inválido, tenta mais uma vez reforçando o formato
      return await _executeWithRetry(
        system: '$system\n\nATENÇÃO: Responda ESTRITAMENTE em formato JSON válido. Sem markdown ```json, sem comentários ou texto fora do JSON.',
        user: user,
        jsonMode: jsonMode,
      );
    }
  }

  Future<String> _executeWithRetry({
    required String system,
    required String user,
    required bool jsonMode,
    int maxAttempts = 3,
  }) async {
    int attempts = 0;
    Duration waitTime = const Duration(seconds: 2);

    while (attempts < maxAttempts) {
      attempts++;
      try {
        final endpoint = baseUrl.endsWith('/')
            ? '${baseUrl}chat/completions'
            : '$baseUrl/chat/completions';

        final Map<String, dynamic> requestBody = {
          'model': model,
          'messages': [
            {'role': 'system', 'content': system},
            {'role': 'user', 'content': user},
          ],
          'temperature': 0.3,
        };

        if (jsonMode) {
          requestBody['response_format'] = {'type': 'json_object'};
        }

        final response = await _dio.post(
          endpoint,
          options: Options(
            headers: {
              'Authorization': 'Bearer $apiKey',
              'Content-Type': 'application/json',
            },
          ),
          data: requestBody,
        );

        final data = response.data;
        final choices = data['choices'] as List?;
        if (choices == null || choices.isEmpty) {
          throw const AiGatewayException('Resposta da IA não contém escolhas (choices vazias).');
        }

        final content = choices[0]['message']['content'] as String?;
        if (content == null || content.trim().isEmpty) {
          throw const AiGatewayException('Resposta da IA veio vazia.');
        }

        final cleanContent = _sanitizeResponse(content);

        if (jsonMode) {
          try {
            jsonDecode(cleanContent);
          } catch (e) {
            throw AiInvalidJsonException(cleanContent);
          }
        }

        return cleanContent;
      } on DioException catch (e) {
        final statusCode = e.response?.statusCode;

        // Trata erro 429 (Rate Limit / Quota)
        if (statusCode == 429) {
          if (attempts < maxAttempts) {
            await Future.delayed(waitTime);
            waitTime *= 2; // Espera exponencial: 2s, 4s...
            continue;
          }
          throw const AiRateLimitException();
        }

        if (statusCode == 401 || statusCode == 403) {
          throw AiGatewayException(
            'Chave de API inválida ou sem permissão para $name (HTTP $statusCode).',
            statusCode,
          );
        }

        final errorMsg = e.response?.data?['error']?['message'] ?? e.message;
        throw AiGatewayException(
          'Erro ao comunicar com $name: $errorMsg',
          statusCode,
        );
      }
    }

    throw const AiGatewayException('Número máximo de tentativas atingido.');
  }

  /// Limpa eventuais blocos markdown ```json caso a IA os inclua
  String _sanitizeResponse(String raw) {
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
}
