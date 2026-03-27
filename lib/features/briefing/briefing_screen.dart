import 'package:flutter/material.dart';
import '../../core/widgets/glow_card.dart';

class BriefingScreen extends StatelessWidget {
  const BriefingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Morning'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Here's your Daily Briefing",
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
                      const Icon(Icons.auto_awesome, color: Color(0xFFC084FC)),
                      const SizedBox(width: 8),
                      Text('Meridian AI Insight', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "You have 2 tasks due today. Let's tackle them before your 3 PM lecture. Also, you saved a job posting yesterday for Razorpay. Want me to draft a follow-up email?",
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Action Items', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.assignment_late),
              title: const Text('Calculus Problem Set 4'),
              subtitle: const Text('Due today at 11:59 PM'),
              trailing: const Icon(Icons.check_circle_outline),
              tileColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            )
          ],
        ),
      ),
    );
  }
}
