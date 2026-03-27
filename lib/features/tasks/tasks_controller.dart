import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

final tasksProvider = FutureProvider<List<TaskModel>>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.getTasks();
});

final taskControllerProvider = Provider((ref) => TaskController(ref));

class TaskController {
  final Ref _ref;
  TaskController(this._ref);

  Future<void> createTask(TaskModel task) async {
    await _ref.read(taskRepositoryProvider).createTask(task);
    _ref.invalidate(tasksProvider);
  }

  Future<void> updateStatus(String id, TaskStatus status) async {
    await _ref.read(taskRepositoryProvider).updateTaskStatus(id, status);
    _ref.invalidate(tasksProvider);
  }
}
