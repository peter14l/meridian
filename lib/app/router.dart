import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../features/auth/auth_screen.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/onboarding_screen.dart';
import '../features/tasks/tasks_screen.dart';
import '../features/briefing/briefing_screen.dart';
import '../features/jobs/jobs_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/study/study_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/briefing',
    observers: [
      PosthogObserver(),
      SentryNavigatorObserver(),
    ],
    redirect: (context, state) {
      final isAuthenticated = authState.value?.session != null;
      final isAuthRoute = state.matchedLocation == '/auth';

      if (!isAuthenticated && !isAuthRoute) {
        return '/auth';
      }
      if (isAuthenticated && isAuthRoute) {
        return '/briefing';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final theme = Theme.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _calculateSelectedIndex(state.matchedLocation),
              indicatorColor: theme.colorScheme.primaryContainer,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/briefing');
                    break;
                  case 1:
                    context.go('/tasks');
                    break;
                  case 2:
                    context.go('/jobs');
                    break;
                  case 3:
                    context.go('/study');
                    break;
                  case 4:
                    context.go('/settings');
                    break;
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.auto_awesome_outlined),
                  selectedIcon: Icon(Icons.auto_awesome),
                  label: 'Briefing',
                ),
                NavigationDestination(
                  icon: Icon(Icons.check_box_outlined),
                  selectedIcon: Icon(Icons.check_box),
                  label: 'Tasks',
                ),
                NavigationDestination(
                  icon: Icon(Icons.work_outline_rounded),
                  selectedIcon: Icon(Icons.work_rounded),
                  label: 'Jobs',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined),
                  selectedIcon: Icon(Icons.school),
                  label: 'Study',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/briefing',
            builder: (context, state) => const BriefingScreen(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: '/jobs',
            builder: (context, state) => const JobsScreen(),
          ),
          GoRoute(
            path: '/study',
            builder: (context, state) => const StudyScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/briefing')) return 0;
  if (location.startsWith('/tasks')) return 1;
  if (location.startsWith('/jobs')) return 2;
  if (location.startsWith('/study')) return 3;
  if (location.startsWith('/settings')) return 4;
  return 0;
}
