import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';
import 'local_database.dart';
import 'supabase_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final syncServiceProvider = Provider((ref) => SyncService());

class SyncService {
  final AppDatabase _localDb = AppDatabase();
  final SupabaseClient _supabase = SupabaseService.client;
  final Connectivity _connectivity = Connectivity();

  SyncService() {
    _connectivity.onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi)) {
        _syncPendingData();
      }
    });
  }

  // --- Task Operations ---

  Future<void> saveTaskLocally(TaskModel task) async {
    final companion = LocalTasksCompanion.insert(
      id: task.id,
      userId: task.userId,
      title: task.title,
      description: drift.Value(task.description),
      priority: drift.Value(task.priority),
      status: task.status.name,
      dueAt: drift.Value(task.dueAt),
      isSynced: const drift.Value(false), // Mark as pending sync
    );
    
    await _localDb.into(_localDb.localTasks).insertOnConflictUpdate(companion);
    _attemptSync(task);
  }

  Future<void> _attemptSync(TaskModel task) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) return;

    try {
      await _supabase.from('tasks').upsert(task.toJson());
      
      // Mark as synced locally
      await (_localDb.update(_localDb.localTasks)
            ..where((t) => t.id.equals(task.id)))
          .write(const LocalTasksCompanion(isSynced: drift.Value(true)));
    } catch (e) {
      // Sync failed, it will be retried later
    }
  }

  Future<void> _syncPendingData() async {
    // Fetch all unsynced tasks
    final unsyncedTasks = await (_localDb.select(_localDb.localTasks)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    for (final taskRow in unsyncedTasks) {
      // Reconstruct TaskModel from row
      // Assuming TaskStatus enum extension logic is handled
      TaskStatus status;
      try {
        status = TaskStatus.values.firstWhere((e) => e.name == taskRow.status);
      } catch (e) {
        status = TaskStatus.todo;
      }
      
      final task = TaskModel(
        id: taskRow.id,
        userId: taskRow.userId,
        title: taskRow.title,
        description: taskRow.description,
        priority: taskRow.priority,
        status: status,
        dueAt: taskRow.dueAt,
      );

      await _attemptSync(task);
    }
  }
}
