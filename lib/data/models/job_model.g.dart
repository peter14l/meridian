// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobModel _$JobModelFromJson(Map<String, dynamic> json) => _JobModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  company: json['company'] as String,
  role: json['role'] as String,
  jobUrl: json['job_url'] as String?,
  location: json['location'] as String?,
  salaryRange: json['salary_range'] as String?,
  status:
      $enumDecodeNullable(_$JobStatusEnumMap, json['status']) ??
      JobStatus.saved,
  appliedAt: json['applied_at'] == null
      ? null
      : DateTime.parse(json['applied_at'] as String),
  resumeVersionId: json['resume_version_id'] as String?,
  notes: json['notes'] as String?,
  followUpSentAt: json['follow_up_sent_at'] == null
      ? null
      : DateTime.parse(json['follow_up_sent_at'] as String),
  nextFollowUpAt: json['next_follow_up_at'] == null
      ? null
      : DateTime.parse(json['next_follow_up_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$JobModelToJson(_JobModel instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'company': instance.company,
  'role': instance.role,
  'job_url': instance.jobUrl,
  'location': instance.location,
  'salary_range': instance.salaryRange,
  'status': _$JobStatusEnumMap[instance.status]!,
  'applied_at': instance.appliedAt?.toIso8601String(),
  'resume_version_id': instance.resumeVersionId,
  'notes': instance.notes,
  'follow_up_sent_at': instance.followUpSentAt?.toIso8601String(),
  'next_follow_up_at': instance.nextFollowUpAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
};

const _$JobStatusEnumMap = {
  JobStatus.saved: 'saved',
  JobStatus.applied: 'applied',
  JobStatus.oa: 'oa',
  JobStatus.interview: 'interview',
  JobStatus.offer: 'offer',
  JobStatus.rejected: 'rejected',
};
