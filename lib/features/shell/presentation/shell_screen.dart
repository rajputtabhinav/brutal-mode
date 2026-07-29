import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  static const _items = <_NavItem>[
    _NavItem(label: 'Home', icon: Icons.circle_outlined, route: '/home'),
    _NavItem(label: 'Growth', icon: Icons.graphic_eq_rounded, route: '/growth'),
    _NavItem(label: 'Mentor', icon: Icons.auto_awesome_outlined, route: '/mentor'),
    _NavItem(label: 'You', icon: Icons.person_outline, route: '/profile'),
  ];

  int get _currentIndex {
    final i = _items.indexWhere((it) => location.startsWith(it.route));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: AppColors.stroke.withValues(alpha: 0.6),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackOverlay(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Row(
              children: [
                for (var i = 0; i < _items.length; i++)
                  Expanded(
                    child: _NavTile(
                      item: _items[i],
                      selected: i == _currentIndex,
                      onTap: () => context.go(_items[i].route),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
  final String label;
  final IconData icon;
  final String route;
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? AppColors.textPrimary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      splashColor: AppColors.accentGlow(0.06),
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: 36,
            height: 3,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: selected ? AppColors.accent : Colors.transparent,
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
          ),
          Icon(item.icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: AppTypography.labelMedium.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
