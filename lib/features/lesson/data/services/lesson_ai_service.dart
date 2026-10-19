import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ai_gateway/ai_gateway_service.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../onboarding/domain/models/user_profile.dart';
import '../../../music/domain/models/song.dart';
import '../../domain/models/lesson_day_content.dart';

final lessonAiServiceProvider = Provider<LessonAiService>((ref) {
  final aiGateway = ref.watch(aiGatewayServiceProvider);
  final db = ref.watch(appDatabaseProvider);
  return LessonAiService(aiGateway, db);
});

class LessonAiService {
  final AiGatewayService _aiGateway;
  final AppDatabase _db;

  LessonAiService(this._aiGateway, this._db);

  // -------------------------------------------------------------
  // CHAMADA A: Geração do Plano da Música por Dias
  // -------------------------------------------------------------
  Future<Map<String, dynamic>> generatePlan({
    required String songTitle,
    required String artist,
    required String fullLyrics,
    required UserProfile profile,
  }) async {
    final provider = await _aiGateway.getActiveProvider();

    final systemPrompt = '''
Você é o professor especialista do app "Acorde". Seu objetivo é planejar o ensino de espanhol rioplatense (Argentina) a partir de letras de músicas para estudantes brasileiros.

Instruções obrigatórias:
- Divida a letra da música em seções lógicas numeradas (Estrofe 1, Refrão, etc.).
- Com base no tempo diário do usuário (${profile.dailyMinutes} min/dia) e tamanho da letra, determine a quantidade ideal de dias (ex: 3 a 5 dias).
- Distribua as seções pelos dias de estudo, reservando preferencialmente o último dia para revisão/visão geral.
- Responda ESTRITAMENTE em formato JSON no modelo exato:
{
  "total_days": 4,
  "days": [
    { "day": 1, "title": "Estrofe 1 e 2: O Ponto de Partida", "section_ids": [1, 2] },
    { "day": 2, "title": "Refrão: A Expressão Central", "section_ids": [3] },
    { "day": 3, "title": "Estrofe 3 e Ponte", "section_ids": [4] },
    { "day": 4, "title": "Revisão e Letra Completa", "section_ids": [1, 2, 3, 4] }
  ],
  "sections": [
    { "id": 1, "label": "Estrofe 1", "text": "texto da estrofe aqui..." },
    { "id": 2, "label": "Estrofe 2", "text": "texto da estrofe aqui..." }
  ]
}
''';

    final userPrompt = '''
${profile.toPromptSummary()}

Música: "$songTitle"
Artista: "$artist"

Letra completa:
$fullLyrics
''';

    final response = await provider.complete(
      system: systemPrompt,
      user: userPrompt,
      jsonMode: true,
    );

    final Map<String, dynamic> decoded = jsonDecode(response);
    return decoded;
  }

  // -------------------------------------------------------------
  // CHAMADA B: Geração do Conteúdo da Aula do Dia (com Cache SQLite)
  // -------------------------------------------------------------
  Future<DayLessonContent> getOrGenerateDayLesson({
    required int songId,
    required int day,
    required String dayTitle,
    required List<SongSection> daySections,
    required UserProfile profile,
  }) async {
    // 1. Checa Cache no SQLite primeiro (não gasta cota de IA)
    final cached = await _db.customSelect(
      'SELECT content_json FROM lesson_content_table WHERE song_id = ? AND day = ? LIMIT 1',
      variables: [Variable.withInt(songId), Variable.withInt(day)],
    ).getSingleOrNull();

    if (cached != null) {
      final jsonStr = cached.read<String>('content_json');
      return DayLessonContent.fromRawJson(jsonStr);
    }

    // 2. Não está no cache -> Chama o provedor de IA
    final provider = await _aiGateway.getActiveProvider();

    final systemPrompt = '''
Você é o professor de espanhol rioplatense (Argentina) do app Acorde, ensinando brasileiros.
Para cada trecho fornecido, produza uma análise didática rica e viva cobrindo rigorosamente estes cinco pilares:
1. "pronunciation": Como pronunciar, destacando fonemas argentinos ("ll" e "y" como "sh/ch", s aspirado antes de consoante, ritmo rioplatense, entonação de pergunta).
2. "slang": Gírias locais, lunfardo e expressões argentinas (ex: che, posta, chabón, quilombo, laburo), nível de formalidade e contexto de uso.
3. "grammar": Ponto gramatical marcante do trecho (foco no voseo: tenés, sos, mirá, querés; pretéritos; pronomes), explicado contrastando com o português.
4. "false_friends": Falsos cognatos / armadilhas entre português e espanhol presentes no trecho (ex: acordar, rato, borrar, largo, etc.).
5. "vocab": Lista de palavras ou expressões novas para fixação (palavra, tradução, exemplo em frase rioplatense, e dica).
6. "translation_pt": Tradução poética e contextual para o português brasileiro.

Regras adicionais:
- Explique sempre em português brasileiro claro, caloroso e didático.
- Adapte à nota do aluno: nível ${profile.spanishLevel}/10 (quanto menor, mais paralelos com o português).
- Responda APENAS em formato JSON válido:
{
  "day": $day,
  "day_title": "$dayTitle",
  "sections": [
    {
      "section_id": 1,
      "section_label": "Estrofe 1",
      "original_text": "...",
      "translation_pt": "...",
      "pronunciation": "...",
      "slang": "...",
      "grammar": "...",
      "false_friends": "...",
      "vocab": [
        { "word": "laburo", "translation": "trabalho/emprego", "example": "Tengo mucho laburo hoy.", "note": "Gíria do lunfardo muito comum" }
      ]
    }
  ]
}
''';

    final buffer = StringBuffer();
    for (final sec in daySections) {
      buffer.writeln('[Seção ${sec.sectionOrder}: ${sec.label}]');
      buffer.writeln(sec.textContent);
      buffer.writeln();
    }

    final userPrompt = '''
${profile.toPromptSummary()}

Aula do Dia: $dayTitle
Trechos a estudar:
$buffer
''';

    final response = await provider.complete(
      system: systemPrompt,
      user: userPrompt,
      jsonMode: true,
    );

    // 3. Salva no Cache do SQLite
    await _db.customInsert(
      'INSERT OR REPLACE INTO lesson_content_table (song_id, day, content_json, is_completed, generated_at) VALUES (?, ?, ?, ?, ?)',
      variables: [
        Variable.withInt(songId),
        Variable.withInt(day),
        Variable.withString(response),
        Variable.withBool(false),
        Variable.withString(DateTime.now().toIso8601String()),
      ],
    );

    return DayLessonContent.fromRawJson(response);
  }
}
