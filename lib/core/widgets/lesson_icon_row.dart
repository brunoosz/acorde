import 'package:flutter/material.dart';
import 'quintet_icon.dart';

class LessonIconRow extends StatelessWidget {
  final QuintetType? activeType;
  final ValueChanged<QuintetType>? onSelect;

  const LessonIconRow({
    super.key,
    this.activeType,
    this.onSelect,
  });

  static const List<QuintetType> lessonQuintet = [
    QuintetType.pronunciation,
    QuintetType.slang,
    QuintetType.grammar,
    QuintetType.falseFriends,
    QuintetType.vocab,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: lessonQuintet.map((type) {
        final isSelected = activeType == null || activeType == type;
        return QuintetIcon(
          type: type,
          size: 56,
          isSelected: isSelected,
          onTap: onSelect != null ? () => onSelect!(type) : null,
        );
      }).toList(),
    );
  }
}
