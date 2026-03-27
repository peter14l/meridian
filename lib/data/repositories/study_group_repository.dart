import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/study_group_model.dart';
import '../services/supabase_service.dart';

final studyGroupRepositoryProvider = Provider((ref) => StudyGroupRepository());

class StudyGroupRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<StudyGroupModel>> getMyGroups() async {
    final response = await _client
        .from('study_groups')
        .select('*, study_group_members!inner(user_id)');
    return (response as List).map((json) => StudyGroupModel.fromJson(json)).toList();
  }

  Future<StudyGroupModel> createGroup(String name, String inviteCode) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Unauthorized');

    final groupResponse = await _client
        .from('study_groups')
        .insert({
          'name': name,
          'invite_code': inviteCode,
          'created_by': user.id,
        })
        .select()
        .single();

    final group = StudyGroupModel.fromJson(groupResponse);

    // Add creator as admin member
    await _client.from('study_group_members').insert({
      'group_id': group.id,
      'user_id': user.id,
      'role': 'admin',
    });

    return group;
  }

  Future<void> joinGroup(String inviteCode) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Unauthorized');

    final groupResponse = await _client
        .from('study_groups')
        .select()
        .eq('invite_code', inviteCode)
        .single();

    final group = StudyGroupModel.fromJson(groupResponse);

    await _client.from('study_group_members').insert({
      'group_id': group.id,
      'user_id': user.id,
      'role': 'member',
    });
  }

  Stream<List<GroupMessageModel>> subscribeToMessages(String groupId) {
    return _client
        .from('group_messages')
        .stream(primaryKey: ['id'])
        .eq('group_id', groupId)
        .order('created_at', ascending: true)
        .map((list) => list.map((json) => GroupMessageModel.fromJson(json)).toList());
  }

  Future<void> sendMessage(String groupId, String content) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Unauthorized');

    await _client.from('group_messages').insert({
      'group_id': groupId,
      'user_id': user.id,
      'content': content,
    });
  }
}
