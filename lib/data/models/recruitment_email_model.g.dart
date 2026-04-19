// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruitment_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecruitmentEmailModel _$RecruitmentEmailModelFromJson(
  Map<String, dynamic> json,
) => _RecruitmentEmailModel(
  id: json['id'] as String,
  subject: json['subject'] as String,
  from: json['from'] as String,
  snippet: json['snippet'] as String,
  receivedAt: DateTime.parse(json['receivedAt'] as String),
  category:
      $enumDecodeNullable(_$EmailCategoryEnumMap, json['category']) ??
      EmailCategory.other,
  company: json['company'] as String?,
  role: json['role'] as String?,
  isRead: json['isRead'] as bool? ?? false,
  isArchived: json['isArchived'] as bool? ?? false,
);

Map<String, dynamic> _$RecruitmentEmailModelToJson(
  _RecruitmentEmailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'subject': instance.subject,
  'from': instance.from,
  'snippet': instance.snippet,
  'receivedAt': instance.receivedAt.toIso8601String(),
  'category': _$EmailCategoryEnumMap[instance.category]!,
  'company': instance.company,
  'role': instance.role,
  'isRead': instance.isRead,
  'isArchived': instance.isArchived,
};

const _$EmailCategoryEnumMap = {
  EmailCategory.interview: 'interview',
  EmailCategory.application: 'application',
  EmailCategory.offer: 'offer',
  EmailCategory.rejection: 'rejection',
  EmailCategory.other: 'other',
};
