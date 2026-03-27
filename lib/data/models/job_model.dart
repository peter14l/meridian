import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

enum JobStatus {
  saved,
  applied,
  oa,
  interview,
  offer,
  rejected,
}

@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String company,
    required String role,
    @JsonKey(name: 'job_url') String? jobUrl,
    String? location,
    @JsonKey(name: 'salary_range') String? salaryRange,
    @Default(JobStatus.saved) JobStatus status,
    @JsonKey(name: 'applied_at') DateTime? appliedAt,
    @JsonKey(name: 'resume_version_id') String? resumeVersionId,
    String? notes,
    @JsonKey(name: 'follow_up_sent_at') DateTime? followUpSentAt,
    @JsonKey(name: 'next_follow_up_at') DateTime? nextFollowUpAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}
