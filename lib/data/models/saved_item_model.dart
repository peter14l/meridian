import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_item_model.freezed.dart';
part 'saved_item_model.g.dart';

enum SavedTag {
  article,
  job,
  resource,
  tool,
  research,
}

@freezed
abstract class SavedItemModel with _$SavedItemModel {
  const factory SavedItemModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String url,
    String? title,
    String? description,
    SavedTag? tag,
    @JsonKey(name: 'suggested_goal_id') String? suggestedGoalId,
    @JsonKey(name: 'suggested_course_id') String? suggestedCourseId,
    @JsonKey(name: 'ai_summary') String? aiSummary,
    @JsonKey(name: 'ai_tags') List<String>? aiTags,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _SavedItemModel;

  factory SavedItemModel.fromJson(Map<String, dynamic> json) => _$SavedItemModelFromJson(json);
}
