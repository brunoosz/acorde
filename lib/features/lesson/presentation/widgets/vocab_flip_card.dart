import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/lesson_day_content.dart';

class VocabFlipCard extends StatefulWidget {
  final LessonVocabItem item;
  final VoidCallback onSave;
  final VoidCallback onSpeak;
  final bool isSaved;

  const VocabFlipCard({
    super.key,
    required this.item,
    required this.onSave,
    required this.onSpeak,
    this.isSaved = false,
  });

  @override
  State<VocabFlipCard> createState() => _VocabFlipCardState();
}

class _VocabFlipCardState extends State<VocabFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250), // 150–300ms conforme especificado
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isUnder = angle > pi / 2;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isUnder
                ? Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: _buildBack(),
                  )
                : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: widget.isSaved ? AppColors.iconVocab : AppColors.borderSubtle,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.volume_up_rounded, color: AppColors.iconVocab),
            onPressed: widget.onSpeak,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.word,
                  style: AppTypography.bodyLarge(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Toque no card para ver a tradução ↺',
                  style: AppTypography.bodySmall(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              widget.isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_add_outlined,
              color: widget.isSaved ? AppColors.actionGreen : AppColors.textLight,
            ),
            onPressed: widget.onSave,
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.iconVocab.withOpacity(0.18),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.iconVocab, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.translation,
                  style: AppTypography.bodyLarge(
                    color: AppColors.actionGreen,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (widget.item.example.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '"${widget.item.example}"',
                    style: AppTypography.bodySmall(color: AppColors.textLight),
                  ),
                ],
                if (widget.item.note.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    widget.item.note,
                    style: AppTypography.label(color: AppColors.supportPurple),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              widget.isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_add_outlined,
              color: widget.isSaved ? AppColors.actionGreen : AppColors.textLight,
            ),
            onPressed: widget.onSave,
          ),
        ],
      ),
    );
  }
}
