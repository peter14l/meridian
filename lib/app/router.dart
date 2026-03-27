import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/auth_screen.dart';
import '../features/auth/auth_controller.dart';
import '../features/auth/onboarding_screen.dart';
import '../features/tasks/tasks_screen.dart';
import '../features/briefing/briefing_screen.dart';
import '../features/jobs/jobs_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/briefing',
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
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _calculateSelectedIndex(state.matchedLocation),
              onTap: (index) {
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
                    context.go('/settings');
                    break;
                }
              },
              unselectedItemColor: Colors.grey,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Briefing'),
                BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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
            path: '/settings',
            builder: (context, state) => const Center(child: Text('Settings')),
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
  if (location.startsWith('/settings')) return 3;
  return 0;
}
