import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskStatus {
  todo,
  @JsonValue('in_progress')
  inProgress,
  done,
}

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'course_id') String? courseId,
    @JsonKey(name: 'goal_id') String? goalId,
    required String title,
    String? description,
    @JsonKey(name: 'due_at') DateTime? dueAt,
    @Default(3) int priority,
    @Default(TaskStatus.todo) TaskStatus status,
    @JsonKey(name: 'is_recurring') @Default(false) bool isRecurring,
    @JsonKey(name: 'recurrence_rule') String? recurrenceRule,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
