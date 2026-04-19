// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AvailableJobModel _$AvailableJobModelFromJson(Map<String, dynamic> json) =>
    _AvailableJobModel(
      id: json['id'] as String,
      company: json['company'] as String,
      role: json['role'] as String,
      location: json['location'] as String,
      workMode: (json['workMode'] as String?)?.toWorkMode() ?? WorkMode.hybrid,
      jobType: (json['jobType'] as String?)?.toJobType() ?? JobType.internship,
      jobUrl: json['jobUrl'] as String?,
      salaryRange: json['salaryRange'] as String?,
      description: json['description'] as String?,
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postedAt: json['postedAt'] == null
          ? null
          : DateTime.parse(json['postedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      isPromoted: json['isPromoted'] as bool? ?? false,
    );

Map<String, dynamic> _$AvailableJobModelToJson(_AvailableJobModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'role': instance.role,
      'location': instance.location,
      'workMode': instance.workMode.name,
      'jobType': instance.jobType.name,
      'jobUrl': instance.jobUrl,
      'salaryRange': instance.salaryRange,
      'description': instance.description,
      'requiredSkills': instance.requiredSkills,
      'postedAt': instance.postedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'isPromoted': instance.isPromoted,
    };

extension on String {
  WorkMode toWorkMode() {
    switch (this) {
      case 'remote':
        return WorkMode.remote;
      case 'onsite':
        return WorkMode.onsite;
      default:
        return WorkMode.hybrid;
    }
  }

  JobType toJobType() {
    switch (this) {
      case 'fullTime':
        return JobType.fullTime;
      case 'partTime':
        return JobType.partTime;
      case 'contract':
        return JobType.contract;
      default:
        return JobType.internship;
    }
  }
}
