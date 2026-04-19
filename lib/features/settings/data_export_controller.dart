import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/services/supabase_service.dart';

final exportDataProvider = Provider((ref) => ExportDataController());

class ExportDataController {
  final SupabaseClient _client = SupabaseService.client;

  Future<Map<String, dynamic>> exportAllData() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final results = await Future.wait([
      _client.from('tasks').select().eq('user_id', user.id),
      _client.from('job_applications').select().eq('user_id', user.id),
      _client.from('courses').select().eq('user_id', user.id),
      _client.from('goals').select().eq('user_id', user.id),
      _client.from('saved_items').select().eq('user_id', user.id),
    ]);

    return {
      'exported_at': DateTime.now().toIso8601String(),
      'user_id': user.id,
      'tasks': results[0],
      'job_applications': results[1],
      'courses': results[2],
      'goals': results[3],
      'saved_items': results[4],
    };
  }

  Future<void> deleteAccount() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Delete all user data (RLS will handle cascading deletes)
    await Future.wait([
      _client.from('tasks').delete().eq('user_id', user.id),
      _client.from('job_applications').delete().eq('user_id', user.id),
      _client.from('courses').delete().eq('user_id', user.id),
      _client.from('goals').delete().eq('user_id', user.id),
      _client.from('saved_items').delete().eq('user_id', user.id),
      _client.from('daily_briefings').delete().eq('user_id', user.id),
      _client.from('study_sessions').delete().eq('user_id', user.id),
      _client.from('journal_entries').delete().eq('user_id', user.id),
      _client.from('resume_versions').delete().eq('user_id', user.id),
    ]);

    // Sign out (account deletion should be done through admin API or support)
    await _client.auth.signOut();
  }
}
