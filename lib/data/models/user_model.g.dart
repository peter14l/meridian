// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  college: json['college'] as String?,
  year: (json['year'] as num?)?.toInt(),
  wakeTime: json['wakeTime'] as String?,
  onboardedAt: json['onboardedAt'] == null
      ? null
      : DateTime.parse(json['onboardedAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'college': instance.college,
      'year': instance.year,
      'wakeTime': instance.wakeTime,
      'onboardedAt': instance.onboardedAt?.toIso8601String(),
    };
