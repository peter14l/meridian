import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/supabase_service.dart';
import '../models/task_model.dart';

final taskRepositoryProvider = Provider((ref) => TaskRepository());

class TaskRepository {
  final _client = SupabaseService.client;

  Future<List<TaskModel>> getTasks() async {
    final response = await _client
        .from('tasks')
        .select()
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false);
    return response.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<void> createTask(TaskModel task) async {
    await _client.from('tasks').insert(task.toJson());
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    await _client.from('tasks').update({
      'status': status.name,
      if (status == TaskStatus.done) 'completed_at': DateTime.now().toIso8601String()
    }).eq('id', taskId);
  }
}
