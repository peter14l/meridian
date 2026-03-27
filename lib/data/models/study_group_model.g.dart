// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyGroupModel _$StudyGroupModelFromJson(Map<String, dynamic> json) =>
    _StudyGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      inviteCode: json['invite_code'] as String,
      createdBy: json['created_by'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$StudyGroupModelToJson(_StudyGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'invite_code': instance.inviteCode,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_GroupMessageModel _$GroupMessageModelFromJson(Map<String, dynamic> json) =>
    _GroupMessageModel(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$GroupMessageModelToJson(_GroupMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'user_id': instance.userId,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
    };
