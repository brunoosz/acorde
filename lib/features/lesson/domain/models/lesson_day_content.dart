import 'dart:convert';

/// Item de vocabulário sugerido pela aula
class LessonVocabItem {
  final String word;
  final String translation;
  final String example;
  final String note;

  const LessonVocabItem({
    required this.word,
    required this.translation,
    required this.example,
    this.note = '',
  });

  factory LessonVocabItem.fromJson(Map<String, dynamic> json) {
    return LessonVocabItem(
      word: json['word'] as String? ?? '',
      translation: json['translation'] as String? ?? '',
      example: json['example'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'translation': translation,
        'example': example,
        'note': note,
      };
}

/// Conteúdo completo dos 5 blocos para um trecho específico da música
class SectionLessonBlock {
  final int sectionId;
  final String sectionLabel;
  final String originalText;
  final String translationPt;
  final String pronunciation; // Bloco 1: Dicas de pronúncia rioplatense para brasileiros
  final String slang;         // Bloco 2: Gírias, lunfardo e expressões
  final String grammar;       // Bloco 3: Ponto gramatical principal comparado ao português
  final String falseFriends;   // Bloco 4: Falsos cognatos e armadilhas
  final List<LessonVocabItem> vocab; // Bloco 5: Vocabulário para salvar

  const SectionLessonBlock({
    required this.sectionId,
    required this.sectionLabel,
    required this.originalText,
    required this.translationPt,
    required this.pronunciation,
    required this.slang,
    required this.grammar,
    required this.falseFriends,
    required this.vocab,
  });

  factory SectionLessonBlock.fromJson(Map<String, dynamic> json) {
    return SectionLessonBlock(
      sectionId: json['section_id'] as int? ?? 1,
      sectionLabel: json['section_label'] as String? ?? 'Trecho',
      originalText: json['original_text'] as String? ?? '',
      translationPt: json['translation_pt'] as String? ?? '',
      pronunciation: json['pronunciation'] as String? ?? 'Dicas de pronúncia.',
      slang: json['slang'] as String? ?? 'Sem gírias marcantes neste trecho.',
      grammar: json['grammar'] as String? ?? 'Análise gramatical.',
      falseFriends: json['false_friends'] as String? ?? 'Nenhum falso cognato evidente.',
      vocab: (json['vocab'] as List?)
              ?.map((item) => LessonVocabItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Conteúdo completo da aula de um dia (pode abranger 1 ou mais seções)
class DayLessonContent {
  final int day;
  final String dayTitle;
  final List<SectionLessonBlock> sections;

  const DayLessonContent({
    required this.day,
    required this.dayTitle,
    required this.sections,
  });

  factory DayLessonContent.fromRawJson(String rawJson) {
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    return DayLessonContent(
      day: decoded['day'] as int? ?? 1,
      dayTitle: decoded['day_title'] as String? ?? 'Aula do Dia',
      sections: (decoded['sections'] as List?)
              ?.map((s) => SectionLessonBlock.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
