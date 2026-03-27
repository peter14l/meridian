import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'tasks_controller.dart';
import '../../data/models/task_model.dart';
import '../../core/widgets/task_card.dart';
import '../../core/widgets/meridian_button.dart';
import '../auth/auth_controller.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
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
                TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(text: 'To Do'),
                    Tab(text: 'Active'),
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
        onPressed: () => _showAddTaskSheet(context, ref),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    int selectedPriority = 3;
    final authState = ref.read(authStateProvider);
    final userId = authState.value?.session?.user.id;

    if (userId == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                left: 24,
                right: 24,
                top: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('New Task', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'What needs to be done?',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: descController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Add description (optional)',
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _PriorityButton(
                        priority: 1,
                        isSelected: selectedPriority == 1,
                        onTap: () => setState(() => selectedPriority = 1),
                      ),
                      const SizedBox(width: 8),
                      _PriorityButton(
                        priority: 2,
                        isSelected: selectedPriority == 2,
                        onTap: () => setState(() => selectedPriority = 2),
                      ),
                      const SizedBox(width: 8),
                      _PriorityButton(
                        priority: 3,
                        isSelected: selectedPriority == 3,
                        onTap: () => setState(() => selectedPriority = 3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  MeridianButton(
                    label: 'Create Task',
                    onPressed: () {
                      final title = titleController.text.trim();
                      if (title.isNotEmpty) {
                        final newTask = TaskModel(
                          id: const Uuid().v4(),
                          userId: userId,
                          title: title,
                          description: descController.text.trim(),
                          priority: selectedPriority,
                        );
                        ref.read(taskControllerProvider).createTask(newTask);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
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
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt,
              size: 64,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 16),
            Text(
              'All clear for now',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TaskCard(
            task: task,
            onStatusChanged: (newStatus) {
              ref.read(taskControllerProvider).updateStatus(task.id, newStatus);
            },
          ),
        );
      },
    );
  }
}

class _PriorityButton extends StatelessWidget {
  final int priority;
  final bool isSelected;
  final VoidCallback onTap;

  const _PriorityButton({
    required this.priority,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color color;
    String label;
    switch (priority) {
      case 1:
        color = const Color(0xFFFF6B6B);
        label = 'High';
        break;
      case 2:
        color = const Color(0xFFFBBF24);
        label = 'Medium';
        break;
      default:
        color = Colors.blueGrey;
        label = 'Low';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : theme.dividerColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? color : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
