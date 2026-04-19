import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/job_model.dart';
import '../../data/repositories/job_repository.dart';

final jobsProvider =
    StateNotifierProvider<JobsController, AsyncValue<List<JobModel>>>((ref) {
      final repository = ref.watch(jobRepositoryProvider);
      return JobsController(repository);
    });

class JobsController extends StateNotifier<AsyncValue<List<JobModel>>> {
  final JobRepository _repository;

  JobsController(this._repository) : super(const AsyncValue.loading()) {
    loadJobs();
  }

  Future<void> loadJobs() async {
    state = const AsyncValue.loading();
    try {
      final jobs = await _repository.getJobs();
      state = AsyncValue.data(jobs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createJob(JobModel job) async {
    try {
      await _repository.createJob(job);
      await loadJobs();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateJobStatus(String id, JobStatus status) async {
    try {
      await _repository.updateJobStatus(id, status);
      await loadJobs();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteJob(String id) async {
    try {
      await _repository.deleteJob(id);
      await loadJobs();
    } on Exception catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<String?> draftEmail(String jobId, String type) async {
    try {
      return await _repository.draftEmail(jobId, type);
    } on Exception {
      return null;
    }
  }
}
