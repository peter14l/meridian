// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get company; String get role;@JsonKey(name: 'job_url') String? get jobUrl; String? get location;@JsonKey(name: 'salary_range') String? get salaryRange; JobStatus get status;@JsonKey(name: 'applied_at') DateTime? get appliedAt;@JsonKey(name: 'resume_version_id') String? get resumeVersionId; String? get notes;@JsonKey(name: 'follow_up_sent_at') DateTime? get followUpSentAt;@JsonKey(name: 'next_follow_up_at') DateTime? get nextFollowUpAt;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'deleted_at') DateTime? get deletedAt;
/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobModelCopyWith<JobModel> get copyWith => _$JobModelCopyWithImpl<JobModel>(this as JobModel, _$identity);

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.jobUrl, jobUrl) || other.jobUrl == jobUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.salaryRange, salaryRange) || other.salaryRange == salaryRange)&&(identical(other.status, status) || other.status == status)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.resumeVersionId, resumeVersionId) || other.resumeVersionId == resumeVersionId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.followUpSentAt, followUpSentAt) || other.followUpSentAt == followUpSentAt)&&(identical(other.nextFollowUpAt, nextFollowUpAt) || other.nextFollowUpAt == nextFollowUpAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,company,role,jobUrl,location,salaryRange,status,appliedAt,resumeVersionId,notes,followUpSentAt,nextFollowUpAt,createdAt,deletedAt);

@override
String toString() {
  return 'JobModel(id: $id, userId: $userId, company: $company, role: $role, jobUrl: $jobUrl, location: $location, salaryRange: $salaryRange, status: $status, appliedAt: $appliedAt, resumeVersionId: $resumeVersionId, notes: $notes, followUpSentAt: $followUpSentAt, nextFollowUpAt: $nextFollowUpAt, createdAt: $createdAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $JobModelCopyWith<$Res>  {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) _then) = _$JobModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String company, String role,@JsonKey(name: 'job_url') String? jobUrl, String? location,@JsonKey(name: 'salary_range') String? salaryRange, JobStatus status,@JsonKey(name: 'applied_at') DateTime? appliedAt,@JsonKey(name: 'resume_version_id') String? resumeVersionId, String? notes,@JsonKey(name: 'follow_up_sent_at') DateTime? followUpSentAt,@JsonKey(name: 'next_follow_up_at') DateTime? nextFollowUpAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'deleted_at') DateTime? deletedAt
});




}
/// @nodoc
class _$JobModelCopyWithImpl<$Res>
    implements $JobModelCopyWith<$Res> {
  _$JobModelCopyWithImpl(this._self, this._then);

  final JobModel _self;
  final $Res Function(JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? company = null,Object? role = null,Object? jobUrl = freezed,Object? location = freezed,Object? salaryRange = freezed,Object? status = null,Object? appliedAt = freezed,Object? resumeVersionId = freezed,Object? notes = freezed,Object? followUpSentAt = freezed,Object? nextFollowUpAt = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,jobUrl: freezed == jobUrl ? _self.jobUrl : jobUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resumeVersionId: freezed == resumeVersionId ? _self.resumeVersionId : resumeVersionId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,followUpSentAt: freezed == followUpSentAt ? _self.followUpSentAt : followUpSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextFollowUpAt: freezed == nextFollowUpAt ? _self.nextFollowUpAt : nextFollowUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobModel].
extension JobModelPatterns on JobModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobModel value)  $default,){
final _that = this;
switch (_that) {
case _JobModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String company,  String role, @JsonKey(name: 'job_url')  String? jobUrl,  String? location, @JsonKey(name: 'salary_range')  String? salaryRange,  JobStatus status, @JsonKey(name: 'applied_at')  DateTime? appliedAt, @JsonKey(name: 'resume_version_id')  String? resumeVersionId,  String? notes, @JsonKey(name: 'follow_up_sent_at')  DateTime? followUpSentAt, @JsonKey(name: 'next_follow_up_at')  DateTime? nextFollowUpAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.userId,_that.company,_that.role,_that.jobUrl,_that.location,_that.salaryRange,_that.status,_that.appliedAt,_that.resumeVersionId,_that.notes,_that.followUpSentAt,_that.nextFollowUpAt,_that.createdAt,_that.deletedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String company,  String role, @JsonKey(name: 'job_url')  String? jobUrl,  String? location, @JsonKey(name: 'salary_range')  String? salaryRange,  JobStatus status, @JsonKey(name: 'applied_at')  DateTime? appliedAt, @JsonKey(name: 'resume_version_id')  String? resumeVersionId,  String? notes, @JsonKey(name: 'follow_up_sent_at')  DateTime? followUpSentAt, @JsonKey(name: 'next_follow_up_at')  DateTime? nextFollowUpAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _JobModel():
return $default(_that.id,_that.userId,_that.company,_that.role,_that.jobUrl,_that.location,_that.salaryRange,_that.status,_that.appliedAt,_that.resumeVersionId,_that.notes,_that.followUpSentAt,_that.nextFollowUpAt,_that.createdAt,_that.deletedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String company,  String role, @JsonKey(name: 'job_url')  String? jobUrl,  String? location, @JsonKey(name: 'salary_range')  String? salaryRange,  JobStatus status, @JsonKey(name: 'applied_at')  DateTime? appliedAt, @JsonKey(name: 'resume_version_id')  String? resumeVersionId,  String? notes, @JsonKey(name: 'follow_up_sent_at')  DateTime? followUpSentAt, @JsonKey(name: 'next_follow_up_at')  DateTime? nextFollowUpAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.userId,_that.company,_that.role,_that.jobUrl,_that.location,_that.salaryRange,_that.status,_that.appliedAt,_that.resumeVersionId,_that.notes,_that.followUpSentAt,_that.nextFollowUpAt,_that.createdAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobModel implements JobModel {
  const _JobModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.company, required this.role, @JsonKey(name: 'job_url') this.jobUrl, this.location, @JsonKey(name: 'salary_range') this.salaryRange, this.status = JobStatus.saved, @JsonKey(name: 'applied_at') this.appliedAt, @JsonKey(name: 'resume_version_id') this.resumeVersionId, this.notes, @JsonKey(name: 'follow_up_sent_at') this.followUpSentAt, @JsonKey(name: 'next_follow_up_at') this.nextFollowUpAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'deleted_at') this.deletedAt});
  factory _JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String company;
@override final  String role;
@override@JsonKey(name: 'job_url') final  String? jobUrl;
@override final  String? location;
@override@JsonKey(name: 'salary_range') final  String? salaryRange;
@override@JsonKey() final  JobStatus status;
@override@JsonKey(name: 'applied_at') final  DateTime? appliedAt;
@override@JsonKey(name: 'resume_version_id') final  String? resumeVersionId;
@override final  String? notes;
@override@JsonKey(name: 'follow_up_sent_at') final  DateTime? followUpSentAt;
@override@JsonKey(name: 'next_follow_up_at') final  DateTime? nextFollowUpAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'deleted_at') final  DateTime? deletedAt;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobModelCopyWith<_JobModel> get copyWith => __$JobModelCopyWithImpl<_JobModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.jobUrl, jobUrl) || other.jobUrl == jobUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.salaryRange, salaryRange) || other.salaryRange == salaryRange)&&(identical(other.status, status) || other.status == status)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.resumeVersionId, resumeVersionId) || other.resumeVersionId == resumeVersionId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.followUpSentAt, followUpSentAt) || other.followUpSentAt == followUpSentAt)&&(identical(other.nextFollowUpAt, nextFollowUpAt) || other.nextFollowUpAt == nextFollowUpAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,company,role,jobUrl,location,salaryRange,status,appliedAt,resumeVersionId,notes,followUpSentAt,nextFollowUpAt,createdAt,deletedAt);

@override
String toString() {
  return 'JobModel(id: $id, userId: $userId, company: $company, role: $role, jobUrl: $jobUrl, location: $location, salaryRange: $salaryRange, status: $status, appliedAt: $appliedAt, resumeVersionId: $resumeVersionId, notes: $notes, followUpSentAt: $followUpSentAt, nextFollowUpAt: $nextFollowUpAt, createdAt: $createdAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$JobModelCopyWith<$Res> implements $JobModelCopyWith<$Res> {
  factory _$JobModelCopyWith(_JobModel value, $Res Function(_JobModel) _then) = __$JobModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String company, String role,@JsonKey(name: 'job_url') String? jobUrl, String? location,@JsonKey(name: 'salary_range') String? salaryRange, JobStatus status,@JsonKey(name: 'applied_at') DateTime? appliedAt,@JsonKey(name: 'resume_version_id') String? resumeVersionId, String? notes,@JsonKey(name: 'follow_up_sent_at') DateTime? followUpSentAt,@JsonKey(name: 'next_follow_up_at') DateTime? nextFollowUpAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'deleted_at') DateTime? deletedAt
});




}
/// @nodoc
class __$JobModelCopyWithImpl<$Res>
    implements _$JobModelCopyWith<$Res> {
  __$JobModelCopyWithImpl(this._self, this._then);

  final _JobModel _self;
  final $Res Function(_JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? company = null,Object? role = null,Object? jobUrl = freezed,Object? location = freezed,Object? salaryRange = freezed,Object? status = null,Object? appliedAt = freezed,Object? resumeVersionId = freezed,Object? notes = freezed,Object? followUpSentAt = freezed,Object? nextFollowUpAt = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_JobModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,jobUrl: freezed == jobUrl ? _self.jobUrl : jobUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resumeVersionId: freezed == resumeVersionId ? _self.resumeVersionId : resumeVersionId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,followUpSentAt: freezed == followUpSentAt ? _self.followUpSentAt : followUpSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextFollowUpAt: freezed == nextFollowUpAt ? _self.nextFollowUpAt : nextFollowUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
