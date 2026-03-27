import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/briefing_model.dart';
import '../services/supabase_service.dart';

final briefingRepositoryProvider = Provider((ref) => BriefingRepository());

class BriefingRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<BriefingModel?> getLatestBriefing() async {
    final response = await _client
        .from('daily_briefings')
        .select()
        .order('date', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return BriefingModel.fromJson(response);
  }

  Future<void> generateBriefing() async {
    await _client.functions.invoke('generate-briefing');
  }

  Future<void> dismissBriefing(String id) async {
    await _client
        .from('daily_briefings')
        .update({'dismissed_at': DateTime.now().toIso8601String()})
        .eq('id', id);
  }
}
