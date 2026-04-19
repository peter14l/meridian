import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_job_model.freezed.dart';
part 'available_job_model.g.dart';

enum JobType { fullTime, partTime, internship, contract }

enum WorkMode { remote, onsite, hybrid }

@freezed
abstract class AvailableJobModel with _$AvailableJobModel {
  const factory AvailableJobModel({
    required String id,
    required String company,
    required String role,
    required String location,
    @Default(WorkMode.hybrid) WorkMode workMode,
    @Default(JobType.internship) JobType jobType,
    String? jobUrl,
    String? salaryRange,
    String? description,
    List<String>? requiredSkills,
    DateTime? postedAt,
    DateTime? expiresAt,
    @Default(false) bool isPromoted,
  }) = _AvailableJobModel;

  factory AvailableJobModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableJobModelFromJson(json);
}
