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
      isAI: false, // Normal tasks aren't AI-powered by default
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PriorityIndicator(priority: task.priority),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
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
              style: theme.textTheme.labelMedium,
            ),
          ],
          if (task.dueAt != null || task.courseId != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (task.dueAt != null)
                  _TagChip(
                    icon: Icons.calendar_today,
                    label: _formatDate(task.dueAt!),
                    color: _isOverdue(task.dueAt!) ? theme.colorScheme.error : null,
                  ),
                if (task.courseId != null) ...[
                  if (task.dueAt != null) const SizedBox(width: 8),
                  _TagChip(
                    icon: Icons.book_outlined,
                    label: task.courseId!, // Should ideally be course name
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple formatter for now
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
        color = const Color(0xFFFF6B6B); // P1 - Red
        break;
      case 2:
        color = const Color(0xFFFBBF24); // P2 - Amber
        break;
      default:
        color = Colors.blueGrey; // P3 - Muted
    }

    return Container(
      width: 4,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
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
      icon: Icon(
        _getStatusIcon(currentStatus),
        size: 20,
        color: _getStatusColor(context, currentStatus),
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
        return Icons.radio_button_unchecked;
      case TaskStatus.inProgress:
        return Icons.pending_outlined;
      case TaskStatus.done:
        return Icons.check_circle;
    }
  }

  Color _getStatusColor(BuildContext context, TaskStatus status) {
    if (status == TaskStatus.done) {
      return Theme.of(context).colorScheme.secondary;
    }
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);
  }
}

class _TagChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _TagChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: effectiveColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
