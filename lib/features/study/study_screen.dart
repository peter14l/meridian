import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'study_controller.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';
import '../../data/services/supabase_service.dart';

class StudyScreen extends ConsumerStatefulWidget {
  const StudyScreen({super.key});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen> {
  bool _isPlanning = false;
  Map<String, dynamic>? _generatedPlan;

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(studyTimerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Session', style: theme.textTheme.headlineLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Let's focus",
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: CircularProgressIndicator(
                      value: timerState.progress,
                      strokeWidth: 8,
                      backgroundColor: theme.dividerColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timerState.formattedTime,
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timerState.status == TimerStatus.running
                            ? 'Focusing'
                            : 'Paused',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TimerControlButton(
                  icon: timerState.status == TimerStatus.running
                      ? Icons.pause
                      : Icons.play_arrow,
                  onTap: () {
                    if (timerState.status == TimerStatus.running) {
                      ref.read(studyTimerProvider.notifier).pauseTimer();
                    } else {
                      ref.read(studyTimerProvider.notifier).startTimer();
                    }
                  },
                ),
                const SizedBox(width: 32),
                _TimerControlButton(
                  icon: Icons.refresh,
                  onTap: () =>
                      ref.read(studyTimerProvider.notifier).resetTimer(25),
                ),
              ],
            ),
            const SizedBox(height: 48),
            _buildSessionPlanner(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionPlanner(BuildContext context) {
    final theme = Theme.of(context);

    if (_isPlanning) {
      return GlowCard(
        isAI: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFFC084FC),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AI STUDY PLANNER',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC084FC),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Generating your personalized study plan...',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    if (_generatedPlan != null) {
      final sessions = _generatedPlan!['sessions'] as List<dynamic>? ?? [];
      final tip = _generatedPlan!['tip'] as String? ?? '';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlowCard(
            isAI: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFC084FC),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI STUDY PLAN',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFC084FC),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (tip.isNotEmpty) ...[
                  Text(
                    tip,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  '${sessions.length} sessions planned',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...sessions
              .take(5)
              .map(
                (session) =>
                    _SessionCard(session: session as Map<String, dynamic>),
              ),
          const SizedBox(height: 16),
          MeridianButton(
            label: 'Generate New Plan',
            onPressed: () => _showPlanSessionSheet(context),
            variant: MeridianButtonVariant.secondary,
          ),
        ],
      );
    }

    return GlowCard(
      isAI: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Color(0xFFC084FC),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'AI STUDY PLANNER',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC084FC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Ready to prepare for your exam?",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "I can plan a personalized study sequence distributed across today and tomorrow.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 16),
          MeridianButton(
            label: 'Plan Session',
            onPressed: () => _showPlanSessionSheet(context),
            variant: MeridianButtonVariant.secondary,
          ),
        ],
      ),
    );
  }

  void _showPlanSessionSheet(BuildContext context) {
    final hoursController = TextEditingController(text: '3');
    final topicsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            left: 24,
            right: 24,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Plan Study Session',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: hoursController,
                keyboardType: TextInputType.number,
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  labelText: 'Total Study Hours',
                  hintText: 'e.g. 3',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: topicsController,
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  labelText: 'Focus Topics (comma separated)',
                  hintText: 'e.g. Data Structures, Algorithms, System Design',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              MeridianButton(
                label: 'Generate Plan',
                onPressed: () async {
                  final hours = int.tryParse(hoursController.text) ?? 3;
                  final topics = topicsController.text
                      .split(',')
                      .map((t) => t.trim())
                      .where((t) => t.isNotEmpty)
                      .toList();

                  if (topics.isEmpty) {
                    topics.add('General Study');
                  }

                  Navigator.pop(context);
                  await _generateStudyPlan(hours, topics);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _generateStudyPlan(int totalHours, List<String> topics) async {
    setState(() => _isPlanning = true);

    try {
      final client = SupabaseService.client;
      final response = await client.functions.invoke(
        'plan-study-session',
        body: {
          'totalHours': totalHours,
          'focusTopics': topics,
          'currentLevel': 'intermediate',
          'preferredTime': 'morning',
        },
      );

      if (response.data != null && response.data['plan'] != null) {
        setState(() {
          _generatedPlan = response.data['plan'] as Map<String, dynamic>;
        });
      }
    } on Exception catch (e) {
      debugPrint('Error generating study plan: $e');
    } finally {
      setState(() => _isPlanning = false);
    }
  }
}

class _SessionCard extends StatelessWidget {
  final Map<String, dynamic> session;

  const _SessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final day = session['day'] as String? ?? '';
    final time = session['time'] as String? ?? '';
    final duration = session['duration_minutes'] as int? ?? 0;
    final topic = session['topic'] as String? ?? '';
    final type = session['type'] as String? ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              type == 'deep_work'
                  ? Icons.psychology_rounded
                  : Icons.quickreply_rounded,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$day at $time • $duration min',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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

class _TimerControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TimerControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 32),
      ),
    );
  }
}
