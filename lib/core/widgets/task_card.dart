import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import 'glow_card.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;
  final Function(TaskStatus)? onStatusChanged;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GlowCard(
      isAI: false,
      onTap: onTap,
      color: theme.colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PriorityIndicator(priority: task.priority),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    decoration: task.status == TaskStatus.done 
                        ? TextDecoration.lineThrough 
                        : null,
                    color: task.status == TaskStatus.done 
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.5) 
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
              _StatusPicker(
                currentStatus: task.status,
                onChanged: onStatusChanged,
              ),
            ],
          ),
          if (task.description != null && task.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (task.dueAt != null || task.courseId != null) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (task.dueAt != null)
                  _TagChip(
                    icon: Icons.calendar_today_rounded,
                    label: _formatDate(task.dueAt!),
                    color: _isOverdue(task.dueAt!) ? theme.colorScheme.error : theme.colorScheme.primary,
                  ),
                if (task.courseId != null)
                  _TagChip(
                    icon: Icons.auto_stories_rounded,
                    label: task.courseId!,
                    color: theme.colorScheme.tertiary,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    }
    return '${date.day}/${date.month}';
  }

  bool _isOverdue(DateTime date) {
    return date.isBefore(DateTime.now()) && task.status != TaskStatus.done;
  }
}

class _PriorityIndicator extends StatelessWidget {
  final int priority;

  const _PriorityIndicator({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case 1:
        color = Theme.of(context).colorScheme.error;
        break;
      case 2:
        color = Colors.orangeAccent;
        break;
      default:
        color = Theme.of(context).colorScheme.outlineVariant;
    }

    return Container(
      width: 6,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}

class _StatusPicker extends StatelessWidget {
  final TaskStatus currentStatus;
  final Function(TaskStatus)? onChanged;

  const _StatusPicker({required this.currentStatus, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TaskStatus>(
      padding: EdgeInsets.zero,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _getStatusColor(context, currentStatus).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getStatusIcon(currentStatus),
          size: 20,
          color: _getStatusColor(context, currentStatus),
        ),
      ),
      onSelected: onChanged,
      itemBuilder: (context) => [
        const PopupMenuItem(value: TaskStatus.todo, child: Text('To Do')),
        const PopupMenuItem(value: TaskStatus.inProgress, child: Text('In Progress')),
        const PopupMenuItem(value: TaskStatus.done, child: Text('Done')),
      ],
    );
  }

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return Icons.radio_button_unchecked_rounded;
      case TaskStatus.inProgress:
        return Icons.bolt_rounded;
      case TaskStatus.done:
        return Icons.check_circle_rounded;
    }
  }

  Color _getStatusColor(BuildContext context, TaskStatus status) {
    final theme = Theme.of(context);
    switch (status) {
      case TaskStatus.todo:
        return theme.colorScheme.onSurfaceVariant;
      case TaskStatus.inProgress:
        return theme.colorScheme.primary;
      case TaskStatus.done:
        return theme.colorScheme.secondary;
    }
  }
}

class _TagChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _TagChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
