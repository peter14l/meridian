import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'jobs_controller.dart';
import '../../data/models/job_model.dart';
import '../../data/models/available_job_model.dart';
import '../../data/repositories/available_jobs_repository.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/meridian_button.dart';
import '../../core/widgets/shimmer_loader.dart';
import '../auth/auth_controller.dart';

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Job Tracker',
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
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
                  labelStyle: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: const [
                    Tab(text: 'Available'),
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
            // Calculate stats
            final totalApplied = jobs
                .where(
                  (j) =>
                      j.status == JobStatus.applied ||
                      j.status == JobStatus.oa ||
                      j.status == JobStatus.interview ||
                      j.status == JobStatus.offer ||
                      j.status == JobStatus.rejected,
                )
                .length;
            final responseCount = jobs
                .where((j) => j.status != JobStatus.saved)
                .length;
            final interviewCount = jobs
                .where((j) => j.status == JobStatus.interview)
                .length;
            final responseRate = totalApplied > 0
                ? ((responseCount / totalApplied) * 100).round()
                : 0;

            // Check for follow-up reminders
            final followUpJobs = jobs.where((j) {
              if (j.status == JobStatus.applied && j.nextFollowUpAt != null) {
                return j.nextFollowUpAt!.isBefore(DateTime.now()) ||
                    j.nextFollowUpAt!.isBefore(
                      DateTime.now().add(const Duration(days: 7)),
                    );
              }
              return false;
            }).toList();

            return Column(
              children: [
                // Stats Header
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        label: 'Applied',
                        value: totalApplied.toString(),
                      ),
                      _StatItem(label: 'Response', value: '$responseRate%'),
                      _StatItem(
                        label: 'Interview',
                        value: interviewCount.toString(),
                      ),
                    ],
                  ),
                ),
                // Follow-up reminder if any
                if (followUpJobs.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notification_important_rounded,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${followUpJobs.length} application${followUpJobs.length > 1 ? 's' : ''} need follow-up',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text('View')),
                      ],
                    ),
                  ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _AvailableJobsView(),
                      _JobListView(
                        jobs: jobs
                            .where((j) => j.status == JobStatus.saved)
                            .toList(),
                      ),
                      _JobListView(
                        jobs: jobs
                            .where(
                              (j) =>
                                  j.status == JobStatus.applied ||
                                  j.status == JobStatus.oa,
                            )
                            .toList(),
                      ),
                      _JobListView(
                        jobs: jobs
                            .where((j) => j.status == JobStatus.interview)
                            .toList(),
                      ),
                      _JobListView(
                        jobs: jobs
                            .where(
                              (j) =>
                                  j.status == JobStatus.offer ||
                                  j.status == JobStatus.rejected,
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Track Application',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
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
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.5,
                ),
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
                  child: Icon(
                    Icons.business_rounded,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
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
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: theme.colorScheme.tertiary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEmailDraftDialog(
    BuildContext context,
    WidgetRef ref,
    JobModel job,
  ) async {
    final theme = Theme.of(context);
    Navigator.pop(context); // Close status picker

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: FutureBuilder<String?>(
                future: ref
                    .read(jobsProvider.notifier)
                    .draftEmail(job.id, 'follow-up'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 24),
                          Text(
                            'Generating your follow-up...',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  final draft = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'AI Draft',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.outlineVariant,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                draft ??
                                    'Failed to generate draft. Please try again.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        MeridianButton(
                          label: 'Copy to Clipboard',
                          onPressed: () {
                            if (draft != null) {
                              Clipboard.setData(ClipboardData(text: draft));
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Copied to clipboard!'),
                                  backgroundColor: theme.colorScheme.primary,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
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
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Actions',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _showEmailDraftDialog(context, ref, job),
                      icon: const Icon(Icons.auto_awesome_rounded, size: 18),
                      label: const Text('AI Draft'),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.tertiary.withValues(
                          alpha: 0.1,
                        ),
                        foregroundColor: theme.colorScheme.tertiary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ...JobStatus.values.map((status) {
                final isSelected = job.status == status;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 4,
                  ),
                  title: Text(
                    status.name.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      letterSpacing: 1.2,
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  leading: Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  onTap: () {
                    ref
                        .read(jobsProvider.notifier)
                        .updateJobStatus(job.id, status);
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ============== AVAILABLE JOBS VIEW ==============
class _AvailableJobsView extends ConsumerStatefulWidget {
  const _AvailableJobsView();

  @override
  ConsumerState<_AvailableJobsView> createState() => _AvailableJobsViewState();
}

class _AvailableJobsViewState extends ConsumerState<_AvailableJobsView> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Debounce timer for search
  DateTime? _lastSearchTime;
  static const _debounceDelay = Duration(milliseconds: 500);

  @override
  void dispose() {
    _roleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Debounce API calls
    final now = DateTime.now();
    _lastSearchTime = now;

    Future.delayed(_debounceDelay, () {
      if (_lastSearchTime == now) {
        ref
            .read(availableJobsProvider.notifier)
            .setRoleFilter(value.isEmpty ? null : value);
      }
    });
  }

  void _showFiltersSheet(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ref.read(availableJobsProvider.notifier);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
                left: 24,
                right: 24,
                top: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 24),
                  Text(
                    'Filters',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Location filter
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      hintText: 'e.g. San Francisco, Remote',
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (value) {
                      controller.setLocationFilter(
                        value.isEmpty ? null : value,
                      );
                    },
                    onChanged: (value) {
                      // Debounce location filter
                      Future.delayed(_debounceDelay, () {
                        controller.setLocationFilter(
                          value.isEmpty ? null : value,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Work mode filter
                  Text('Work Mode', style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Remote'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedWorkModeFilter ==
                            WorkMode.remote,
                        onSelected: (selected) {
                          controller.setWorkModeFilter(
                            selected ? WorkMode.remote : null,
                          );
                          setState(() {});
                        },
                      ),
                      FilterChip(
                        label: const Text('Onsite'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedWorkModeFilter ==
                            WorkMode.onsite,
                        onSelected: (selected) {
                          controller.setWorkModeFilter(
                            selected ? WorkMode.onsite : null,
                          );
                          setState(() {});
                        },
                      ),
                      FilterChip(
                        label: const Text('Hybrid'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedWorkModeFilter ==
                            WorkMode.hybrid,
                        onSelected: (selected) {
                          controller.setWorkModeFilter(
                            selected ? WorkMode.hybrid : null,
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Job type filter
                  Text('Job Type', style: theme.textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('FullTime'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedJobTypeFilter ==
                            JobType.fullTime,
                        onSelected: (selected) {
                          controller.setJobTypeFilter(
                            selected ? JobType.fullTime : null,
                          );
                          setState(() {});
                        },
                      ),
                      FilterChip(
                        label: const Text('PartTime'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedJobTypeFilter ==
                            JobType.partTime,
                        onSelected: (selected) {
                          controller.setJobTypeFilter(
                            selected ? JobType.partTime : null,
                          );
                          setState(() {});
                        },
                      ),
                      FilterChip(
                        label: const Text('Internship'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedJobTypeFilter ==
                            JobType.internship,
                        onSelected: (selected) {
                          controller.setJobTypeFilter(
                            selected ? JobType.internship : null,
                          );
                          setState(() {});
                        },
                      ),
                      FilterChip(
                        label: const Text('Contract'),
                        selected:
                            ref
                                .watch(availableJobsProvider.notifier)
                                .selectedJobTypeFilter ==
                            JobType.contract,
                        onSelected: (selected) {
                          controller.setJobTypeFilter(
                            selected ? JobType.contract : null,
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        _roleController.clear();
                        _locationController.clear();
                        controller.clearFilters();
                        setState(() {});
                      },
                      child: const Text('Clear All Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobsAsync = ref.watch(availableJobsProvider);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Filter toggle
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _roleController,
                  decoration: InputDecoration(
                    hintText: 'Search roles...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (value) {
                    ref
                        .read(availableJobsProvider.notifier)
                        .setRoleFilter(value.isEmpty ? null : value);
                  },
                  onChanged: _onSearchChanged,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  onPressed: () => _showFiltersSheet(context),
                  icon: Icon(Icons.filter_list_rounded),
                ),
              ),
            ],
          ),
        ),

        // Available jobs list
        Expanded(
          child: jobsAsync.when(
            data: (jobs) {
              if (jobs.isEmpty) {
                return SingleChildScrollView(
                  child: Center(
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
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'No available jobs found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            _roleController.clear();
                            _locationController.clear();
                            ref
                                .read(availableJobsProvider.notifier)
                                .clearFilters();
                          },
                          child: const Text('Clear filters'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _AvailableJobCard(
                      job: job,
                      onSave: () => _saveToTracker(context, ref, job),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = ref.read(availableJobsProvider.notifier);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          // Location filter
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              hintText: 'e.g. San Francisco, Remote',
              filled: true,
              fillColor: theme.colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              controller.setLocationFilter(value.isEmpty ? null : value);
            },
          ),
          const SizedBox(height: 12),

          // Work mode filter
          Text('Work Mode', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: WorkMode.values.map((mode) {
              return FilterChip(
                label: Text(mode.name),
                selected:
                    ref
                        .watch(availableJobsProvider.notifier)
                        .selectedWorkModeFilter ==
                    mode,
                onSelected: (selected) {
                  controller.setWorkModeFilter(selected ? mode : null);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Job type filter
          Text('Job Type', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: JobType.values.map((type) {
              return FilterChip(
                label: Text(type.name),
                selected:
                    ref
                        .watch(availableJobsProvider.notifier)
                        .selectedJobTypeFilter ==
                    type,
                onSelected: (selected) {
                  controller.setJobTypeFilter(selected ? type : null);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                _roleController.clear();
                _locationController.clear();
                controller.clearFilters();
              },
              child: const Text('Clear All Filters'),
            ),
          ),
        ],
      ),
    );
  }

  void _saveToTracker(
    BuildContext context,
    WidgetRef ref,
    AvailableJobModel job,
  ) {
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.session?.user.id;

    if (userId == null) return;

    final newJob = JobModel(
      id: const Uuid().v4(),
      userId: userId,
      company: job.company,
      role: job.role,
      location: job.location,
      status: JobStatus.saved,
    );

    ref.read(jobsProvider.notifier).createJob(newJob);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved ${job.company} to tracker'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildLoadingShimmer(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoader(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 20,
                  borderRadius: 8,
                ),
                const SizedBox(height: 8),
                ShimmerLoader(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 14,
                  borderRadius: 8,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerLoader(width: 60, height: 28, borderRadius: 14),
                    const SizedBox(width: 8),
                    ShimmerLoader(width: 60, height: 28, borderRadius: 14),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AvailableJobCard extends StatelessWidget {
  final AvailableJobModel job;
  final VoidCallback onSave;

  const _AvailableJobCard({required this.job, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: job.isPromoted
            ? Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Could open job URL in browser
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.role,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job.company,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (job.isPromoted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Promoted',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.location_on_outlined,
                      label: job.location,
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(
                      icon: job.workMode == WorkMode.remote
                          ? Icons.home_work_outlined
                          : job.workMode == WorkMode.onsite
                          ? Icons.business_outlined
                          : Icons.people_outlined,
                      label: job.workMode.name,
                    ),
                    const SizedBox(width: 8),
                    _InfoChip(
                      icon: Icons.work_outline,
                      label: job.jobType.name,
                    ),
                  ],
                ),
                if (job.salaryRange != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    job.salaryRange!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (job.requiredSkills != null &&
                    job.requiredSkills!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: job.requiredSkills!.take(4).map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(skill, style: theme.textTheme.labelSmall),
                      );
                    }).toList(),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (job.postedAt != null)
                      Text(
                        _formatPostedDate(job.postedAt!),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    TextButton.icon(
                      onPressed: onSave,
                      icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                      label: const Text('Save'),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                        foregroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatPostedDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return '${(diff.inDays / 30).floor()}mo ago';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
