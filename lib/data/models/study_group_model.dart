import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_group_model.freezed.dart';
part 'study_group_model.g.dart';

@freezed
abstract class StudyGroupModel with _$StudyGroupModel {
  const factory StudyGroupModel({
    required String id,
    required String name,
    @JsonKey(name: 'invite_code') required String inviteCode,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _StudyGroupModel;

  factory StudyGroupModel.fromJson(Map<String, dynamic> json) => _$StudyGroupModelFromJson(json);
}

@freezed
abstract class GroupMessageModel with _$GroupMessageModel {
  const factory GroupMessageModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'user_id') required String userId,
    required String content,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _GroupMessageModel;

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) => _$GroupMessageModelFromJson(json);
}
