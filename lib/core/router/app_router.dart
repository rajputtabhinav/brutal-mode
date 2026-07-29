import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

import '../../features/ai_mentor/presentation/mentor_screen.dart';
import '../../features/growth/presentation/growth_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/night_reflection/presentation/reflection_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/shell/presentation/shell_screen.dart';
import '../config/env.dart';
import '../services/storage_service.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final onboarded = StorageService.instance.getBool(
    StorageKeys.onboardingComplete,
    fallback: false,
  );

  return GoRouter(
    initialLocation: onboarded ? '/home' : '/onboarding',
    observers: [
      if (Env.hasPostHog) PosthogObserver(),
    ],
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/reflection',
        name: 'reflection',
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReflectionScreen(),
          transitionDuration: const Duration(milliseconds: 420),
          transitionsBuilder: (_, anim, __, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: anim,
                curve: Curves.easeOutCubic,
              ),
              child: child,
            );
          },
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ShellScreen(location: state.uri.toString(), child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: _fade(const HomeScreen()),
          ),
          GoRoute(
            path: '/growth',
            name: 'growth',
            pageBuilder: _fade(const GrowthScreen()),
          ),
          GoRoute(
            path: '/mentor',
            name: 'mentor',
            pageBuilder: _fade(const MentorScreen()),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: _fade(const ProfileScreen()),
          ),
        ],
      ),
    ],
  );
});

CustomTransitionPage<void> Function(BuildContext, GoRouterState) _fade(
  Widget child,
) {
  return (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: child,
        transitionDuration: const Duration(milliseconds: 280),
        transitionsBuilder: (_, anim, __, c) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: c,
          );
        },
      );
}
