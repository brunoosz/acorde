import 'dart:convert';

/// Interface única do AI Gateway para desacoplar o aplicativo dos detalhes do provedor.
abstract class AiProvider {
  String get name;

  Future<String> complete({
    required String system,
    required String user,
    bool jsonMode = false,
  });
}

/// Exceções específicas do AI Gateway
class AiGatewayException implements Exception {
  final String message;
  final int? statusCode;

  const AiGatewayException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class AiRateLimitException extends AiGatewayException {
  const AiRateLimitException([String message = 'Limite de requisições excedido (HTTP 429). Aguarde alguns instantes antes de tentar novamente.'])
      : super(message, 429);
}

class AiMissingKeyException extends AiGatewayException {
  const AiMissingKeyException([String message = 'Chave de API não informada. Configure a sua chave na aba Ajustes.'])
      : super(message, 401);
}

class AiInvalidJsonException extends AiGatewayException {
  final String rawResponse;

  const AiInvalidJsonException(this.rawResponse, [String message = 'A IA retornou uma resposta que não é um JSON válido.'])
      : super(message);
}
