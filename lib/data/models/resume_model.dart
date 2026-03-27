import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_model.freezed.dart';
part 'resume_model.g.dart';

@freezed
abstract class ResumeModel with _$ResumeModel {
  const factory ResumeModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String label,
    @JsonKey(name: 'file_url') required String fileUrl,
    @JsonKey(name: 'file_size') int? fileSize,
    @JsonKey(name: 'is_primary') @Default(false) bool isPrimary,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ResumeModel;

  factory ResumeModel.fromJson(Map<String, dynamic> json) => _$ResumeModelFromJson(json);
}
