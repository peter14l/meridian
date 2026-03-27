// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedItemModel _$SavedItemModelFromJson(Map<String, dynamic> json) =>
    _SavedItemModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      tag: $enumDecodeNullable(_$SavedTagEnumMap, json['tag']),
      suggestedGoalId: json['suggested_goal_id'] as String?,
      suggestedCourseId: json['suggested_course_id'] as String?,
      aiSummary: json['ai_summary'] as String?,
      aiTags: (json['ai_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$SavedItemModelToJson(_SavedItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'tag': _$SavedTagEnumMap[instance.tag],
      'suggested_goal_id': instance.suggestedGoalId,
      'suggested_course_id': instance.suggestedCourseId,
      'ai_summary': instance.aiSummary,
      'ai_tags': instance.aiTags,
      'created_at': instance.createdAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

const _$SavedTagEnumMap = {
  SavedTag.article: 'article',
  SavedTag.job: 'job',
  SavedTag.resource: 'resource',
  SavedTag.tool: 'tool',
  SavedTag.research: 'research',
};
