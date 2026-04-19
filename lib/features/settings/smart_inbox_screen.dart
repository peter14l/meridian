import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/recruitment_email_model.dart';
import '../../data/services/gmail_service.dart';

final recruitmentEmailsProvider =
    StateNotifierProvider<
      RecruitmentEmailsController,
      AsyncValue<List<RecruitmentEmailModel>>
    >((ref) {
      return RecruitmentEmailsController(ref.watch(gmailServiceProvider));
    });

class RecruitmentEmailsController
    extends StateNotifier<AsyncValue<List<RecruitmentEmailModel>>> {
  final GmailService _gmailService;

  RecruitmentEmailsController(this._gmailService)
    : super(const AsyncValue.loading()) {
    loadEmails();
  }

  Future<void> loadEmails() async {
    state = const AsyncValue.loading();
    try {
      final messages = await _gmailService.fetchRecruitmentEmails();
      final emails = messages.map(_convertToEmail).toList();
      state = AsyncValue.data(emails);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  RecruitmentEmailModel _convertToEmail(dynamic msg) {
    // Parse email headers to extract subject, from, etc.
    final headers = msg.payload?.headers as List?;
    String subject = 'No Subject';
    String from = 'Unknown';

    if (headers != null) {
      for (final header in headers) {
        if (header.name == 'Subject') subject = header.value ?? 'No Subject';
        if (header.name == 'From') from = header.value ?? 'Unknown';
      }
    }

    // Auto-categorize based on subject
    EmailCategory category = EmailCategory.other;
    final lowerSubject = subject.toLowerCase();
    if (lowerSubject.contains('interview')) {
      category = EmailCategory.interview;
    } else if (lowerSubject.contains('offer')) {
      category = EmailCategory.offer;
    } else if (lowerSubject.contains('rejected') ||
        lowerSubject.contains('not moving forward')) {
      category = EmailCategory.rejection;
    } else if (lowerSubject.contains('application') ||
        lowerSubject.contains('received')) {
      category = EmailCategory.application;
    }

    return RecruitmentEmailModel(
      id: msg.id ?? '',
      subject: subject,
      from: from,
      snippet: msg.snippet ?? '',
      receivedAt:
          DateTime.tryParse(msg.internalDate?.toString() ?? '') ??
          DateTime.now(),
      category: category,
    );
  }

  Future<void> markAsRead(String id) async {
    state.whenData((emails) async {
      final updated = emails.map((e) {
        if (e.id == id) return e.copyWith(isRead: true);
        return e;
      }).toList();
      state = AsyncValue.data(updated);
    });
  }

  Future<void> archive(String id) async {
    state.whenData((emails) async {
      final updated = emails.map((e) {
        if (e.id == id) return e.copyWith(isArchived: true);
        return e;
      }).toList();
      state = AsyncValue.data(updated);
    });
  }
}

class SmartInboxScreen extends ConsumerWidget {
  const SmartInboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailsAsync = ref.watch(recruitmentEmailsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Smart Inbox',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(recruitmentEmailsProvider.notifier).loadEmails();
            },
          ),
        ],
      ),
      body: emailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text('Failed to load emails', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.read(recruitmentEmailsProvider.notifier).loadEmails();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (emails) {
          final unreadEmails = emails.where((e) => !e.isArchived).toList();

          if (unreadEmails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recruitment emails',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect Gmail to see your recruitment emails',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // Group by category
          final grouped = <EmailCategory, List<RecruitmentEmailModel>>{};
          for (final email in unreadEmails) {
            grouped.putIfAbsent(email.category, () => []).add(email);
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (grouped[EmailCategory.interview]?.isNotEmpty == true) ...[
                _buildCategoryHeader(
                  context,
                  'Interviews',
                  Icons.event,
                  Colors.blue,
                ),
                ...grouped[EmailCategory.interview]!.map(
                  (e) => _buildEmailCard(context, ref, e),
                ),
                const SizedBox(height: 16),
              ],
              if (grouped[EmailCategory.offer]?.isNotEmpty == true) ...[
                _buildCategoryHeader(
                  context,
                  'Offers',
                  Icons.celebration,
                  Colors.green,
                ),
                ...grouped[EmailCategory.offer]!.map(
                  (e) => _buildEmailCard(context, ref, e),
                ),
                const SizedBox(height: 16),
              ],
              if (grouped[EmailCategory.application]?.isNotEmpty == true) ...[
                _buildCategoryHeader(
                  context,
                  'Applications',
                  Icons.send,
                  Colors.orange,
                ),
                ...grouped[EmailCategory.application]!.map(
                  (e) => _buildEmailCard(context, ref, e),
                ),
                const SizedBox(height: 16),
              ],
              if (grouped[EmailCategory.rejection]?.isNotEmpty == true) ...[
                _buildCategoryHeader(
                  context,
                  'Updates',
                  Icons.update,
                  Colors.grey,
                ),
                ...grouped[EmailCategory.rejection]!.map(
                  (e) => _buildEmailCard(context, ref, e),
                ),
                const SizedBox(height: 16),
              ],
              if (grouped[EmailCategory.other]?.isNotEmpty == true) ...[
                _buildCategoryHeader(
                  context,
                  'Other',
                  Icons.email,
                  Colors.purple,
                ),
                ...grouped[EmailCategory.other]!.map(
                  (e) => _buildEmailCard(context, ref, e),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailCard(
    BuildContext context,
    WidgetRef ref,
    RecruitmentEmailModel email,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: () {
          ref.read(recruitmentEmailsProvider.notifier).markAsRead(email.id);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      email.subject,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: email.isRead
                            ? FontWeight.w500
                            : FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!email.isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                email.from,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                email.snippet,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.8,
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _formatDate(email.receivedAt),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.archive_outlined, size: 20),
                    onPressed: () {
                      ref
                          .read(recruitmentEmailsProvider.notifier)
                          .archive(email.id);
                    },
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}';
    }
  }
}
