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

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Job Tracker', style: Theme.of(context).textTheme.headlineLarge),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Saved'),
              Tab(text: 'Applied'),
              Tab(text: 'Interviewing'),
              Tab(text: 'Outcome'),
            ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddJobSheet(context, ref),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.add),
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
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
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
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Track New Application', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              TextField(
                controller: companyController,
                autofocus: true,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  labelText: 'Company Name',
                  hintText: 'e.g. Google, Razorpay',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: roleController,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  hintText: 'e.g. Frontend Intern',
                  border: UnderlineInputBorder(),
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
    if (jobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 16),
            Text(
              'No applications here yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlowCard(
            isAI: false,
            onTap: () {
              // Show job details/edit status
              _showStatusPicker(context, ref, job);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.company,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        job.role,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.auto_awesome, color: Color(0xFFC084FC), size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Drafting AI follow-up email...')),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStatusPicker(BuildContext context, WidgetRef ref, JobModel job) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text('Update Status', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              RadioGroup<JobStatus>(
                groupValue: job.status,
                onChanged: (newStatus) {
                  if (newStatus != null) {
                    ref.read(jobsProvider.notifier).updateJobStatus(job.id, newStatus);
                    Navigator.pop(context);
                  }
                },
                child: Column(
                  children: [
                    ...JobStatus.values.map((status) {
                      return ListTile(
                        title: Text(status.name.toUpperCase()),
                        leading: Radio<JobStatus>(
                          value: status,
                        ),
                        onTap: () {
                          ref.read(jobsProvider.notifier).updateJobStatus(job.id, status);
                          Navigator.pop(context);
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
