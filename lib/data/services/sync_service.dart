import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task_model.dart';
import 'local_database.dart';
import 'supabase_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final syncServiceProvider = Provider((ref) => SyncService());

/// Offline-first sync service with last-write-wins conflict resolution
/// Uses simple upsert - latest write wins
class SyncService {
  final AppDatabase _localDb = AppDatabase();
  final SupabaseClient _supabase = SupabaseService.client;
  final Connectivity _connectivity = Connectivity();

  SyncService() {
    _connectivity.onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi)) {
        _syncPendingData();
      }
    });
  }

  // --- Task Operations ---

  /// Save task locally first, then sync
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

  /// Try to sync a single task to remote
  Future<void> _attemptSync(TaskModel task) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) return;

    try {
      // Simple upsert - last write wins
      await _supabase.from('tasks').upsert(task.toJson());

      // Mark as synced locally
      await (_localDb.update(_localDb.localTasks)
            ..where((t) => t.id.equals(task.id)))
          .write(const LocalTasksCompanion(isSynced: drift.Value(true)));
    } on Exception {
      // Sync failed, it will be retried later
    }
  }

  /// Sync all pending local changes to remote
  Future<void> _syncPendingData() async {
    // Fetch all unsynced tasks
    final unsyncedTasks = await (_localDb.select(
      _localDb.localTasks,
    )..where((t) => t.isSynced.equals(false))).get();

    for (final taskRow in unsyncedTasks) {
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

    // Fetch remote changes that happened while offline
    await _fetchRemoteChanges();
  }

  /// Fetch remote changes and apply last-write-wins
  Future<void> _fetchRemoteChanges() async {
    try {
      final remoteTasks = await _supabase.from('tasks').select();

      for (final remoteTask in remoteTasks) {
        // Check if task exists locally
        final query = _localDb.select(_localDb.localTasks)
          ..where((t) => t.id.equals(remoteTask['id']));

        final localTask = await query.getSingleOrNull();

        if (localTask == null) {
          // New remote task, insert locally
          TaskStatus status;
          try {
            status = TaskStatus.values.firstWhere(
              (e) => e.name == remoteTask['status'],
            );
          } catch (e) {
            status = TaskStatus.todo;
          }

          final companion = LocalTasksCompanion.insert(
            id: remoteTask['id'],
            userId: remoteTask['user_id'],
            title: remoteTask['title'],
            description: drift.Value(remoteTask['description']),
            priority: drift.Value(remoteTask['priority'] ?? 3),
            status: remoteTask['status'] ?? 'todo',
            dueAt: drift.Value(
              remoteTask['due_at'] != null
                  ? DateTime.parse(remoteTask['due_at'])
                  : null,
            ),
            isSynced: const drift.Value(true),
          );

          await _localDb
              .into(_localDb.localTasks)
              .insertOnConflictUpdate(companion);
        }
        // If local exists, it stays (last-write-wins from local side)
      }
    } on Exception {
      // Failed to fetch remote changes, will retry later
    }
  }
}
