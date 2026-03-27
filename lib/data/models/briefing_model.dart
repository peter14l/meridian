import 'package:freezed_annotation/freezed_annotation.dart';

part 'briefing_model.freezed.dart';
part 'briefing_model.g.dart';

@freezed
abstract class BriefingModel with _$BriefingModel {
  const factory BriefingModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required DateTime date,
    @JsonKey(name: 'content_json') required Map<String, dynamic> contentJson,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
    @JsonKey(name: 'dismissed_at') DateTime? dismissedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _BriefingModel;

  factory BriefingModel.fromJson(Map<String, dynamic> json) => _$BriefingModelFromJson(json);
}
