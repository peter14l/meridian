// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'briefing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BriefingModel _$BriefingModelFromJson(Map<String, dynamic> json) =>
    _BriefingModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      contentJson: json['content_json'] as Map<String, dynamic>,
      generatedAt: json['generated_at'] == null
          ? null
          : DateTime.parse(json['generated_at'] as String),
      dismissedAt: json['dismissed_at'] == null
          ? null
          : DateTime.parse(json['dismissed_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BriefingModelToJson(_BriefingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date.toIso8601String(),
      'content_json': instance.contentJson,
      'generated_at': instance.generatedAt?.toIso8601String(),
      'dismissed_at': instance.dismissedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
