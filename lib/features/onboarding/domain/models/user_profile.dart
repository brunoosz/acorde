/// Modelo de domínio do perfil do usuário para o aprendizado.
/// Alimenta as instruções personalizadas nos prompts da IA.
class UserProfile {
  final int id;
  final String objective;
  final int spanishLevel; // 0 a 10
  final int dailyMinutes;
  final String currentKnowledge;
  final String musicPreferences;
  final DateTime createdAt;

  const UserProfile({
    this.id = 1,
    required this.objective,
    required this.spanishLevel,
    required this.dailyMinutes,
    required this.currentKnowledge,
    required this.musicPreferences,
    required this.createdAt,
  });

  /// Gera a descrição textual resumida do perfil para ser injetada no prompt de sistema da IA
  String toPromptSummary() {
    return '''
Perfil do estudante:
- Nível de espanhol: $spanishLevel/10 (${_describeLevel(spanishLevel)})
- Tempo diário de estudo: $dailyMinutes minutos
- Objetivo principal: $objective
- O que já compreende: $currentKnowledge
- Gêneros musicais preferidos: $musicPreferences
'''.trim();
  }

  static String _describeLevel(int level) {
    if (level <= 2) return 'Iniciante absoluto (partindo do zero)';
    if (level <= 5) return 'Básico (entende semelhanças com o português, mas confunde falsos amigos)';
    if (level <= 7) return 'Intermediário (consegue compreender o contexto geral das músicas)';
    return 'Avançado (quer dominar nuances, gírias rioplatenses e lunfardo)';
  }
}
