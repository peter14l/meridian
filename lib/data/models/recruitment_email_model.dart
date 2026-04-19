import 'package:freezed_annotation/freezed_annotation.dart';

part 'recruitment_email_model.freezed.dart';
part 'recruitment_email_model.g.dart';

enum EmailCategory { interview, application, offer, rejection, other }

@freezed
abstract class RecruitmentEmailModel with _$RecruitmentEmailModel {
  const factory RecruitmentEmailModel({
    required String id,
    required String subject,
    required String from,
    required String snippet,
    required DateTime receivedAt,
    @Default(EmailCategory.other) EmailCategory category,
    String? company,
    String? role,
    @Default(false) bool isRead,
    @Default(false) bool isArchived,
  }) = _RecruitmentEmailModel;

  factory RecruitmentEmailModel.fromJson(Map<String, dynamic> json) =>
      _$RecruitmentEmailModelFromJson(json);
}
