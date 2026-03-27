import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_controller.dart';
import '../../core/widgets/meridian_button.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _collegeController = TextEditingController();
  final _courseController = TextEditingController();
  final _goalController = TextEditingController();
  int _selectedYear = 1;

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(onboardingControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                    theme.colorScheme.primary.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                _buildProgressIndicator(step),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: _buildStepContent(step),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      if (step > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => ref.read(onboardingControllerProvider.notifier).previousStep(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              side: BorderSide(color: theme.colorScheme.outlineVariant),
                            ),
                            child: Text('Back', style: theme.textTheme.labelLarge),
                          ),
                        ),
                      if (step > 0) const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: MeridianButton(
                          label: step == 3 ? 'Get Started' : 'Continue',
                          onPressed: () async {
                            final notifier = ref.read(onboardingControllerProvider.notifier);
                            if (step == 0) {
                              notifier.college = _collegeController.text;
                              notifier.year = _selectedYear;
                              notifier.nextStep();
                            } else if (step == 1) {
                              notifier.nextStep();
                            } else if (step == 2) {
                              notifier.nextStep();
                            } else {
                              await notifier.completeOnboarding();
                              if (mounted) context.go('/briefing');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= currentStep;
          return Expanded(
            child: Container(
              height: 6,
              margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
              decoration: BoxDecoration(
                color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0: return _buildBasicInfoStep();
      case 1: return _buildCoursesStep();
      case 2: return _buildGoalsStep();
      case 3: return _buildPreferencesStep();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildBasicInfoStep() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 1 of 4', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Tell us about\nyour college', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 48),
        _buildTextField(
          controller: _collegeController,
          label: 'College Name',
          hint: 'e.g. Stanford University',
          icon: Icons.school_outlined,
        ),
        const SizedBox(height: 32),
        Text('Current Year', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final year = index + 1;
            final isSelected = _selectedYear == year;
            return GestureDetector(
              onTap: () => setState(() => _selectedYear = year),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected ? [
                    BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    '$year',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCoursesStep() {
    final theme = Theme.of(context);
    final notifier = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 2 of 4', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('What are you\nstudying?', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text('Add up to 8 courses you are currently taking.', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _courseController,
                label: 'Course Name',
                hint: 'e.g. Data Structures',
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filled(
              onPressed: () {
                final name = _courseController.text.trim();
                if (name.isNotEmpty && notifier.courses.length < 8) {
                  setState(() {
                    notifier.courses.add(name);
                    _courseController.clear();
                  });
                }
              },
              icon: const Icon(Icons.add_rounded),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: notifier.courses.map((course) => Chip(
            label: Text(course),
            backgroundColor: theme.colorScheme.surfaceContainerHigh,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onDeleted: () {
              setState(() => notifier.courses.remove(course));
            },
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildGoalsStep() {
    final theme = Theme.of(context);
    final notifier = ref.read(onboardingControllerProvider.notifier);
    final suggestedGoals = [
      'Placement Prep',
      'CGPA Target',
      'Skill Learning',
      'Side Project',
      'Research'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Step 3 of 4', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Define your\ngoals', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 40),
        Text('Suggested Goals', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: suggestedGoals.map((goal) {
            final isSelected = notifier.goals.contains(goal);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    notifier.goals.remove(goal);
                  } else {
                    notifier.goals.add(goal);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.tertiary : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  goal,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isSelected ? theme.colorScheme.onTertiary : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        _buildTextField(
          controller: _goalController,
          label: 'Custom Goal',
          hint: 'e.g. Master React Native',
          onSubmitted: (val) {
             if (val.trim().isNotEmpty) {
               setState(() {
                 notifier.goals.add(val.trim());
                 _goalController.clear();
               });
             }
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesStep() {
    final theme = Theme.of(context);
    final notifier = ref.read(onboardingControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Final Step', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Daily Routine', style: theme.textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text('When would you like to receive your morning briefing?', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 48),
        Center(
          child: GestureDetector(
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 8, minute: 0),
              );
              if (time != null) {
                setState(() {
                  notifier.wakeTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3), width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.alarm_rounded, color: theme.colorScheme.primary, size: 32),
                  const SizedBox(width: 16),
                  Text(
                    notifier.wakeTime,
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    Function(String)? onSubmitted,
  }) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        prefixIcon: icon != null ? Icon(icon, color: theme.colorScheme.primary) : null,
      ),
    );
  }
}
