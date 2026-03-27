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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: theme.colorScheme.onPrimary,
                      unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                      labelStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                      tabs: const [
                        Tab(text: 'To Do'),
                        Tab(text: 'Active'),
                        Tab(text: 'Done'),
                      ],
                    ),
                  ),
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _showAddTaskSheet(context, ref),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // Extra-Large
        child: const Icon(Icons.add_rounded, size: 32),
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
        final theme = Theme.of(context);
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
                      width: 48,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'New Task', 
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    )
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    style: theme.textTheme.titleLarge,
                    decoration: InputDecoration(
                      hintText: 'What needs to be done?',
                      hintStyle: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    controller: descController,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Add description (optional)',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _PriorityButton(
                        priority: 1,
                        isSelected: selectedPriority == 1,
                        onTap: () => setState(() => selectedPriority = 1),
                      ),
                      const SizedBox(width: 12),
                      _PriorityButton(
                        priority: 2,
                        isSelected: selectedPriority == 2,
                        onTap: () => setState(() => selectedPriority = 2),
                      ),
                      const SizedBox(width: 12),
                      _PriorityButton(
                        priority: 3,
                        isSelected: selectedPriority == 3,
                        onTap: () => setState(() => selectedPriority = 3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.task_alt_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'All clear for now',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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
          padding: const EdgeInsets.only(bottom: 16),
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
        color = theme.colorScheme.error;
        label = 'High';
        break;
      case 2:
        color = Colors.orangeAccent;
        label = 'Medium';
        break;
      default:
        color = theme.colorScheme.onSurfaceVariant;
        label = 'Low';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color, 
                shape: BoxShape.circle,
                boxShadow: isSelected ? [
                  BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4)
                ] : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected ? color : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
