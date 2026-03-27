// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  courseId: json['course_id'] as String?,
  goalId: json['goal_id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  dueAt: json['due_at'] == null
      ? null
      : DateTime.parse(json['due_at'] as String),
  priority: (json['priority'] as num?)?.toInt() ?? 3,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.todo,
  isRecurring: json['is_recurring'] as bool? ?? false,
  recurrenceRule: json['recurrence_rule'] as String?,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'course_id': instance.courseId,
      'goal_id': instance.goalId,
      'title': instance.title,
      'description': instance.description,
      'due_at': instance.dueAt?.toIso8601String(),
      'priority': instance.priority,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'is_recurring': instance.isRecurring,
      'recurrence_rule': instance.recurrenceRule,
      'completed_at': instance.completedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.todo: 'todo',
  TaskStatus.inProgress: 'in_progress',
  TaskStatus.done: 'done',
};
