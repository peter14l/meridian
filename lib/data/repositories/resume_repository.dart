import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/resume_model.dart';
import '../services/supabase_service.dart';

final resumeRepositoryProvider = Provider((ref) => ResumeRepository());

class ResumeRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<ResumeModel>> getResumes() async {
    final response = await _client
        .from('resume_versions')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => ResumeModel.fromJson(json)).toList();
  }

  Future<ResumeModel> uploadResume(ResumeModel resume) async {
    final response = await _client
        .from('resume_versions')
        .insert(resume.toJson())
        .select()
        .single();
    return ResumeModel.fromJson(response);
  }

  Future<void> setPrimary(String id) async {
    // Transactional logic: unset all others, set this one
    final user = _client.auth.currentUser;
    if (user == null) return;
    
    await _client.from('resume_versions').update({'is_primary': false}).eq('user_id', user.id);
    await _client.from('resume_versions').update({'is_primary': true}).eq('id', id);
  }

  Future<void> deleteResume(String id) async {
    await _client.from('resume_versions').delete().eq('id', id);
  }
}
