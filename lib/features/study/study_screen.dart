import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'study_controller.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
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
                        timerState.status == TimerStatus.running ? 'Focusing' : 'Paused',
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
                  icon: timerState.status == TimerStatus.running ? Icons.pause : Icons.play_arrow,
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
                  onTap: () => ref.read(studyTimerProvider.notifier).resetTimer(25),
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
    return GlowCard(
      isAI: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFFC084FC), size: 18),
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
            "Ready to prepare for Calculus Exam?",
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "I can plan a 3-hour study sequence distributed across today and tomorrow.",
            style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
          ),
          const SizedBox(height: 16),
          MeridianButton(
            label: 'Plan Session',
            onPressed: () {},
            variant: MeridianButtonVariant.secondary,
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
          border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 32),
      ),
    );
  }
}
