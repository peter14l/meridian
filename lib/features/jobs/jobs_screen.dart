import 'package:flutter/material.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Tracker'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Saved'),
              Tab(text: 'Applied'),
              Tab(text: 'Interview'),
              Tab(text: 'Offer/Rejected'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _JobListView(status: 'saved'),
            _JobListView(status: 'applied'),
            _JobListView(status: 'interview'),
            _JobListView(status: 'completed'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show Add Job Sheet matching UI Spec
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _JobListView extends StatelessWidget {
  final String status;
  const _JobListView({required this.status});

  @override
  Widget build(BuildContext context) {
    final mockJobs = status == 'saved' 
        ? [{'company': 'Razorpay', 'role': 'Frontend Intern'}]
        : [];

    if (mockJobs.isEmpty) {
      return Center(child: Text('No jobs in $status'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: mockJobs.length,
      itemBuilder: (context, index) {
        final job = mockJobs[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListTile(
            title: Text(job['company']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(job['role']!),
            trailing: IconButton(
              icon: const Icon(Icons.auto_awesome, color: Color(0xFFC084FC)),
              tooltip: 'Generate Follow-Up Email',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Drafting AI follow-up email...')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
