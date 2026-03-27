import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_model.dart';
import '../services/supabase_service.dart';

final jobRepositoryProvider = Provider((ref) => JobRepository());

class JobRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<JobModel>> getJobs() async {
    final response = await _client
        .from('job_applications')
        .select()
        .filter('deleted_at', 'is', null)
        .order('created_at', ascending: false);

    return (response as List).map((json) => JobModel.fromJson(json)).toList();
  }

  Future<JobModel> createJob(JobModel job) async {
    final response = await _client
        .from('job_applications')
        .insert(job.toJson())
        .select()
        .single();
    return JobModel.fromJson(response);
  }

  Future<void> updateJobStatus(String id, JobStatus status) async {
    await _client
        .from('job_applications')
        .update({'status': status.name.toLowerCase()})
        .eq('id', id);
  }

  Future<void> deleteJob(String id) async {
    await _client
        .from('job_applications')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', id);
  }
}
