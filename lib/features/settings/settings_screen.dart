import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/theme_provider.dart';
import '../auth/auth_controller.dart';
import '../../data/services/calendar_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final authController = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: 12),
          _buildThemeCard(context, ref, themeMode),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Notifications'),
          const SizedBox(height: 12),
          _buildPreferenceTile(
            context,
            icon: Icons.notifications_none_rounded,
            title: 'Daily Briefing Time',
            subtitle: '8:00 AM',
            onTap: () {
              // Placeholder for time picker
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Integrations'),
          const SizedBox(height: 12),
          _buildPreferenceTile(
            context,
            icon: Icons.calendar_today_rounded,
            title: 'Google Calendar',
            subtitle: 'Sync your events and deadlines',
            onTap: () {
              ref.read(calendarServiceProvider).signIn();
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Data Management'),
          const SizedBox(height: 12),
          _buildPreferenceTile(
            context,
            icon: Icons.auto_stories_rounded,
            title: 'Course Management',
            subtitle: 'Add or remove your courses',
            onTap: () {
              // Navigate to course management
            },
          ),
          const SizedBox(height: 16),
          _buildPreferenceTile(
            context,
            icon: Icons.download_rounded,
            title: 'Export Data',
            subtitle: 'Download your data in JSON format',
            onTap: () {
              // Data export logic
            },
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Account'),
          const SizedBox(height: 12),
          _buildPreferenceTile(
            context,
            icon: Icons.logout_rounded,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () async {
              final shouldSignOut = await _showConfirmDialog(
                context,
                title: 'Sign Out',
                content: 'Are you sure you want to sign out?',
                confirmLabel: 'Sign Out',
                isDestructive: true,
              );
              if (shouldSignOut == true) {
                await authController.signOut();
              }
            },
          ),
          const SizedBox(height: 16),
          _buildPreferenceTile(
            context,
            icon: Icons.delete_forever_rounded,
            title: 'Delete Account',
            subtitle: 'Permanently remove all your data',
            textColor: theme.colorScheme.error,
            iconColor: theme.colorScheme.error,
            onTap: () async {
              final shouldDelete = await _showConfirmDialog(
                context,
                title: 'Delete Account',
                content: 'This action is permanent and cannot be undone. All your data will be wiped.',
                confirmLabel: 'Delete Forever',
                isDestructive: true,
              );
              if (shouldDelete == true) {
                // Delete account logic
              }
            },
          ),
          const SizedBox(height: 48),
          Center(
            child: Text(
              'Meridian v1.0.0',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                letterSpacing: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: theme.colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _buildThemeOption(
            context,
            ref,
            mode: ThemeMode.system,
            currentMode: currentMode,
            icon: Icons.settings_brightness_rounded,
            label: 'System Default',
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), indent: 56),
          _buildThemeOption(
            context,
            ref,
            mode: ThemeMode.light,
            currentMode: currentMode,
            icon: Icons.light_mode_rounded,
            label: 'Light Mode',
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), indent: 56),
          _buildThemeOption(
            context,
            ref,
            mode: ThemeMode.dark,
            currentMode: currentMode,
            icon: Icons.dark_mode_rounded,
            label: 'Dark Mode',
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required ThemeMode mode,
    required ThemeMode currentMode,
    required IconData icon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isSelected = mode == currentMode;
    return InkWell(
      onTap: () => ref.read(themeModeProvider.notifier).state = mode,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (iconColor ?? theme.colorScheme.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor ?? theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                            color: textColor ?? theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmLabel,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: isDestructive
                ? TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error)
                : null,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
