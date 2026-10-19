import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum PillButtonVariant {
  /// Botão primário: fundo preenchido #c7ff69 com texto #141414
  primary,

  /// Botão secundário: fundo transparente com contorno de 2px
  outline,
}

class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final PillButtonVariant variant;
  final Widget? icon;
  final bool isExpanded;
  final EdgeInsetsGeometry padding;

  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = PillButtonVariant.primary,
    this.icon,
    this.isExpanded = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == PillButtonVariant.primary;

    final child = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: AppTypography.button(
            color: isPrimary ? AppColors.actionText : AppColors.textLight,
          ),
        ),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isPrimary ? AppColors.actionGreen : Colors.transparent,
      foregroundColor: isPrimary ? AppColors.actionText : AppColors.textLight,
      elevation: 0,
      shadowColor: Colors.transparent,
      padding: padding,
      shape: const StadiumBorder(
        side: BorderSide(
          color: isPrimary ? Colors.transparent : AppColors.textLight,
          width: 2.0,
        ),
      ),
    );

    if (isExpanded) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: child,
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: child,
    );
  }
}
