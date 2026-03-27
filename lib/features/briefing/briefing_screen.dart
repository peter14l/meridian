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
      appBar: AppBar(
        title: Text(
          _getGreeting(),
          style: theme.textTheme.headlineLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(briefingProvider.notifier).generateNewBriefing(),
          ),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 24),
            Text(
              "Ready for your briefing?",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "I'll analyze your tasks and goals to help you focus on what matters today.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            MeridianButton(
              label: 'Generate Daily Briefing',
              onPressed: onGenerate,
              icon: Icons.bolt,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Today's Briefing",
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          GlowCard(
            isAI: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: Color(0xFFC084FC), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Meridian AI',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFC084FC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  insight,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          if (tasks.isNotEmpty) ...[
            _SectionHeader(title: 'Top Priorities', icon: Icons.priority_high),
            const SizedBox(height: 12),
            ...tasks.map((task) => _TaskItem(task: task)),
          ],
          const SizedBox(height: 24),
          _SectionHeader(title: 'Learning Goal', icon: Icons.school_outlined),
          const SizedBox(height: 12),
          GlowCard(
            isAI: false,
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DSA for Placements', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      Text('Next: Binary Search Trees', style: theme.textTheme.labelMedium),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 40),
          MeridianButton(
            label: 'Complete Morning Briefing',
            variant: MeridianButtonVariant.secondary,
            onPressed: () {
              // Mark as complete logic
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank, color: theme.colorScheme.primary.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task['title'] ?? 'Unnamed Task',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          if (task['priority'] == 1)
            const Icon(Icons.flag, color: Colors.red, size: 16),
        ],
      ),
    );
  }
}

class _BriefingLoadingView extends StatelessWidget {
  const _BriefingLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 24),
          Text('Meridian is preparing your briefing...'),
        ],
      ),
    );
  }
}
