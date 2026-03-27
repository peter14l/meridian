import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'tasks_controller.dart';
import '../../data/models/task_model.dart';
import '../auth/auth_controller.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meridian Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider).signOut();
            },
          )
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          final todos = tasks.where((t) => t.status == TaskStatus.todo).toList();
          final inProgress = tasks.where((t) => t.status == TaskStatus.inProgress).toList();
          final done = tasks.where((t) => t.status == TaskStatus.done).toList();

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'To Do'),
                    Tab(text: 'In Progress'),
                    Tab(text: 'Done'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _TaskList(tasks: todos, status: TaskStatus.todo),
                      _TaskList(tasks: inProgress, status: TaskStatus.inProgress),
                      _TaskList(tasks: done, status: TaskStatus.done),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('New Task', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Task Title', border: OutlineInputBorder()),
                autofocus: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  if (title.isNotEmpty) {
                    final newTask = TaskModel(
                      id: const Uuid().v4(),
                      userId: 'REPLACE_WITH_AUTH_UID', // Handled by RLS or Controller
                      title: title,
                    );
                    ref.read(taskControllerProvider).createTask(newTask);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Task'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _TaskList extends ConsumerWidget {
  final List<TaskModel> tasks;
  final TaskStatus status;

  const _TaskList({required this.tasks, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tasks.isEmpty) return const Center(child: Text('No tasks here'));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(task.description ?? ''),
            trailing: PopupMenuButton<TaskStatus>(
              onSelected: (newStatus) {
                ref.read(taskControllerProvider).updateStatus(task.id, newStatus);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: TaskStatus.todo, child: Text('To Do')),
                const PopupMenuItem(value: TaskStatus.inProgress, child: Text('In Progress')),
                const PopupMenuItem(value: TaskStatus.done, child: Text('Done')),
              ],
            ),
          ),
        );
      },
    );
  }
}
