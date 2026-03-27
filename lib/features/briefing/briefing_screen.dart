import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';
import 'briefing_controller.dart';
import '../../data/models/briefing_model.dart';

class BriefingScreen extends ConsumerWidget {
  const BriefingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final briefingAsync = ref.watch(briefingProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          _getGreeting(),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(briefingProvider.notifier).generateNewBriefing(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: briefingAsync.when(
        data: (briefing) {
          if (briefing == null) {
            return _EmptyBriefingView(onGenerate: () {
              ref.read(briefingProvider.notifier).generateNewBriefing();
            });
          }
          return _BriefingContentView(briefing: briefing);
        },
        loading: () => const _BriefingLoadingView(),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}

class _EmptyBriefingView extends StatelessWidget {
  final VoidCallback onGenerate;

  const _EmptyBriefingView({required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 80,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Ready for your briefing?",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "I'll analyze your tasks and goals to help you focus on what matters today.",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            MeridianButton(
              label: 'Generate Daily Briefing',
              onPressed: onGenerate,
              icon: Icons.bolt_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _BriefingContentView extends StatelessWidget {
  final BriefingModel briefing;

  const _BriefingContentView({required this.briefing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = briefing.contentJson;
    final insight = content['insight'] as String? ?? 'No insight available.';
    final tasks = (content['highlighted_tasks'] as List? ?? []);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Today's Focus",
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          GlowCard(
            isAI: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.auto_awesome_rounded, color: theme.colorScheme.tertiary, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'MERIDIAN AI INSIGHT',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  insight,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          if (tasks.isNotEmpty) ...[
            _SectionHeader(title: 'Top Priorities', icon: Icons.bolt_rounded, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            ...tasks.map((task) => _TaskItem(task: task)),
          ],
          const SizedBox(height: 32),
          _SectionHeader(title: 'Learning Goal', icon: Icons.auto_stories_rounded, color: theme.colorScheme.secondary),
          const SizedBox(height: 16),
          GlowCard(
            isAI: false,
            color: theme.colorScheme.surfaceContainerLow,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.menu_book_rounded, color: theme.colorScheme.secondary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DSA for Placements', 
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Next: Binary Search Trees', 
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)),
              ],
            ),
          ),
          const SizedBox(height: 48),
          MeridianButton(
            label: 'Complete Morning Briefing',
            variant: MeridianButtonVariant.secondary,
            onPressed: () {
              // Mark as complete logic
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: theme.colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

class _TaskItem extends StatelessWidget {
  final dynamic task;

  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHighPriority = task['priority'] == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.radio_button_unchecked_rounded, 
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              task['title'] ?? 'Unnamed Task',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isHighPriority)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.bolt_rounded, color: theme.colorScheme.error, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'P1',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _BriefingLoadingView extends StatelessWidget {
  const _BriefingLoadingView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 6,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          const SizedBox(height: 32),
          Text(
            'Preparing your briefing...',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
