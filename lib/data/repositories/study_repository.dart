import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

final studyRepositoryProvider = Provider((ref) => StudyRepository());

class StudyRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<Map<String, dynamic>> planStudySession({
    required List<String> taskIds,
    required double availableHours,
  }) async {
    final response = await _client.functions.invoke(
      'plan-study-session',
      body: {
        'task_ids': taskIds,
        'available_hours': availableHours,
      },
    );
    
    return response.data as Map<String, dynamic>;
  }
}
