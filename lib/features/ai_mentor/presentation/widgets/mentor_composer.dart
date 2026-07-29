import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class MentorComposer extends StatefulWidget {
  const MentorComposer({super.key, required this.onSend});

  final ValueChanged<String> onSend;

  @override
  State<MentorComposer> createState() => _MentorComposerState();
}

class _MentorComposerState extends State<MentorComposer> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _focus.hasFocus;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.lg + MediaQuery.of(context).viewInsets.bottom * 0.0,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: hasFocus
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.stroke.withValues(alpha: 0.6),
            width: 0.5,
          ),
          boxShadow: _hasText
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 24,
                    spreadRadius: -4,
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focus,
                onSubmitted: (_) => _submit(),
                textInputAction: TextInputAction.send,
                style: AppTypography.bodyLarge,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ask your mentor…',
                  hintStyle: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                cursorColor: AppColors.accent,
              ),
            ),
            AnimatedScale(
              scale: _hasText ? 1 : 0.85,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: _hasText ? 1 : 0.5,
                duration: const Duration(milliseconds: 220),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _submit,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: _hasText ? AppColors.accentGradient : null,
                        color: _hasText ? null : AppColors.surfaceElevated,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
