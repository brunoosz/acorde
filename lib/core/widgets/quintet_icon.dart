import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum QuintetType {
  pronunciation,
  slang,
  grammar,
  falseFriends,
  vocab,
  music,
}

class QuintetIcon extends StatelessWidget {
  final QuintetType type;
  final double size;
  final bool isSelected;
  final VoidCallback? onTap;

  const QuintetIcon({
    super.key,
    required this.type,
    this.size = 56,
    this.isSelected = true,
    this.onTap,
  });

  Color get backgroundColor {
    switch (type) {
      case QuintetType.pronunciation:
      case QuintetType.music:
        return AppColors.iconPronunciation; // #7A78FF
      case QuintetType.slang:
        return AppColors.iconSlang;         // #00A652
      case QuintetType.grammar:
        return AppColors.iconGrammar;       // #FF6D38
      case QuintetType.falseFriends:
        return AppColors.iconFalseFriends;  // #FFC412
      case QuintetType.vocab:
        return AppColors.iconVocab;         // #478BFF
    }
  }

  IconData get iconData {
    switch (type) {
      case QuintetType.pronunciation:
        return Icons.record_voice_over_rounded;
      case QuintetType.music:
        return Icons.music_note_rounded;
      case QuintetType.slang:
        return Icons.chat_bubble_rounded;
      case QuintetType.grammar:
        return Icons.menu_book_rounded;
      case QuintetType.falseFriends:
        return Icons.warning_amber_rounded;
      case QuintetType.vocab:
        return Icons.bookmark_rounded;
    }
  }

  String get label {
    switch (type) {
      case QuintetType.pronunciation:
        return 'Pronúncia';
      case QuintetType.music:
        return 'Música';
      case QuintetType.slang:
        return 'Gírias';
      case QuintetType.grammar:
        return 'Gramática';
      case QuintetType.falseFriends:
        return 'Falsos amigos';
      case QuintetType.vocab:
        return 'Vocabulário';
    }
  }

  @override
  Widget build(BuildContext context) {
    final widget = AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isSelected ? 1.0 : 0.4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: AppColors.darkBackground,
            size: size * 0.52,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: widget,
      );
    }

    return widget;
  }
}
