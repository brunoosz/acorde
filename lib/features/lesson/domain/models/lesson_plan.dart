import 'dart:convert';

/// Dia estruturado do plano de aula
class PlanDay {
  final int day;
  final String title;
  final List<int> sectionIds;

  const PlanDay({
    required this.day,
    required this.title,
    required this.sectionIds,
  });

  factory PlanDay.fromJson(Map<String, dynamic> json) {
    return PlanDay(
      day: json['day'] as int? ?? 1,
      title: json['title'] as String? ?? 'Dia',
      sectionIds: (json['section_ids'] as List?)?.map((e) => (e as num).toInt()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'title': title,
        'section_ids': sectionIds,
      };
}

/// Plano completo da música dividido em vários dias
class LessonPlan {
  final int id;
  final int songId;
  final int totalDays;
  final int currentDay;
  final bool isCompleted;
  final List<PlanDay> days;

  const LessonPlan({
    required this.id,
    required this.songId,
    required this.totalDays,
    required this.currentDay,
    required this.isCompleted,
    required this.days,
  });

  factory LessonPlan.fromRaw({
    required int id,
    required int songId,
    required int totalDays,
    required int currentDay,
    required bool isCompleted,
    required String planJson,
  }) {
    List<PlanDay> parsedDays = [];
    try {
      final decoded = jsonDecode(planJson) as Map<String, dynamic>;
      final list = decoded['days'] as List?;
      if (list != null) {
        parsedDays = list.map((item) => PlanDay.fromJson(item as Map<String, dynamic>)).toList();
      }
    } catch (_) {}

    return LessonPlan(
      id: id,
      songId: songId,
      totalDays: totalDays,
      currentDay: currentDay,
      isCompleted: isCompleted,
      days: parsedDays,
    );
  }
}
