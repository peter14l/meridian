import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'jobs_controller.dart';
import '../../data/models/job_model.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';
import '../auth/auth_controller.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Job Tracker', 
            style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: theme.colorScheme.onPrimary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  labelStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: 'Saved'),
                    Tab(text: 'Applied'),
                    Tab(text: 'Interviewing'),
                    Tab(text: 'Outcome'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: jobsAsync.when(
          data: (jobs) {
            return TabBarView(
              children: [
                _JobListView(jobs: jobs.where((j) => j.status == JobStatus.saved).toList()),
                _JobListView(jobs: jobs.where((j) => j.status == JobStatus.applied || j.status == JobStatus.oa).toList()),
                _JobListView(jobs: jobs.where((j) => j.status == JobStatus.interview).toList()),
                _JobListView(jobs: jobs.where((j) => j.status == JobStatus.offer || j.status == JobStatus.rejected).toList()),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () => _showAddJobSheet(context, ref),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: const Icon(Icons.add_rounded, size: 32),
        ),
      ),
    );
  }

  void _showAddJobSheet(BuildContext context, WidgetRef ref) {
    final companyController = TextEditingController();
    final roleController = TextEditingController();
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.session?.user.id;

    if (userId == null) return;

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
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Track Application', 
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: companyController,
                autofocus: true,
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  hintText: 'e.g. Google, Razorpay',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainer,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: roleController,
                style: theme.textTheme.titleLarge,
                decoration: InputDecoration(
                  labelText: 'Role',
                  hintText: 'e.g. Frontend Intern',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainer,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              MeridianButton(
                label: 'Save to Tracker',
                onPressed: () {
                  final company = companyController.text.trim();
                  final role = roleController.text.trim();
                  if (company.isNotEmpty && role.isNotEmpty) {
                    final newJob = JobModel(
                      id: const Uuid().v4(),
                      userId: userId,
                      company: company,
                      role: role,
                      status: JobStatus.saved,
                    );
                    ref.read(jobsProvider.notifier).createJob(newJob);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _JobListView extends ConsumerWidget {
  final List<JobModel> jobs;

  const _JobListView({required this.jobs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.work_outline_rounded,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No applications here yet',
              style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlowCard(
            isAI: false,
            color: theme.colorScheme.surfaceContainerLow,
            onTap: () {
              _showStatusPicker(context, ref, job);
            },
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.business_rounded, color: theme.colorScheme.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.company,
                        style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.role,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.auto_awesome_rounded, color: theme.colorScheme.tertiary, size: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStatusPicker(BuildContext context, WidgetRef ref, JobModel job) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Update Status', 
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 24),
              ...JobStatus.values.map((status) {
                final isSelected = job.status == status;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  title: Text(
                    status.name.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      letterSpacing: 1.2,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                  leading: Radio<JobStatus>(
                    value: status,
                    groupValue: job.status,
                    onChanged: (newStatus) {
                      if (newStatus != null) {
                        ref.read(jobsProvider.notifier).updateJobStatus(job.id, newStatus);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  onTap: () {
                    ref.read(jobsProvider.notifier).updateJobStatus(job.id, status);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
