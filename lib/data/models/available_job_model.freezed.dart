// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AvailableJobModel {

 String get id; String get company; String get role; String get location; WorkMode get workMode; JobType get jobType;@JsonKey(name: 'job_url') String? get jobUrl;@JsonKey(name: 'salary_range') String? get salaryRange; String? get description;@JsonKey(name: 'required_skills') List<String>? get requiredSkills;@JsonKey(name: 'posted_at') DateTime? get postedAt;@JsonKey(name: 'expires_at') DateTime? get expiresAt;@JsonKey(name: 'is_promoted') bool get isPromoted;
/// Create a copy of AvailableJobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableJobModelCopyWith<AvailableJobModel> get copyWith => _$AvailableJobModelCopyWithImpl<AvailableJobModel>(this as AvailableJobModel, _$identity);

  /// Serializes this AvailableJobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableJobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.location, location) || other.location == location)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.jobUrl, jobUrl) || other.jobUrl == jobUrl)&&(identical(other.salaryRange, salaryRange) || other.salaryRange == salaryRange)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiredSkills, requiredSkills) || other.requiredSkills == requiredSkills)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,company,role,location,workMode,jobType,jobUrl,salaryRange,description,requiredSkills,postedAt,expiresAt,isPromoted);

@override
String toString() {
  return 'AvailableJobModel(id: $id, company: $company, role: $role, location: $location, workMode: $workMode, jobType: $jobType, jobUrl: $jobUrl, salaryRange: $salaryRange, description: $description, requiredSkills: $requiredSkills, postedAt: $postedAt, expiresAt: $expiresAt, isPromoted: $isPromoted)';
}


}

/// @nodoc
abstract mixin class $AvailableJobModelCopyWith<$Res>  {
  factory $AvailableJobModelCopyWith(AvailableJobModel value, $Res Function(AvailableJobModel) _then) = _$AvailableJobModelCopyWithImpl;
@useResult
$Res call({
 String id, String company, String role, String location, WorkMode workMode, JobType jobType, String? jobUrl, String? salaryRange, String? description, List<String>? requiredSkills, DateTime? postedAt, DateTime? expiresAt, bool isPromoted
});



}
/// @nodoc
class _$AvailableJobModelCopyWithImpl<$Res>
    implements $AvailableJobModelCopyWith<$Res> {
  _$AvailableJobModelCopyWithImpl(this._self, this._then);

  // ignore: unused_field
  final AvailableJobModel _self;
  // ignore: unused_field
  final $Res Function(AvailableJobModel) _then;

/// Create a copy of AvailableJobModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null, Object? company = null, Object? role = null, Object? location = null, Object? workMode = null, Object? jobType = null, Object? jobUrl = freezed, Object? salaryRange = freezed, Object? description = freezed, Object? requiredSkills = freezed, Object? postedAt = freezed, Object? expiresAt = freezed, Object? isPromoted = null}) {
    return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,workMode: null == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,jobUrl: freezed == jobUrl ? _self.jobUrl : jobUrl // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiredSkills: freezed == requiredSkills ? _self.requiredSkills : requiredSkills // ignore: cast_nullable_to_non_nullable
as List<String>?,postedAt: freezed == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,
    ));
  }

}

/// Adds pattern-matching-related methods to [AvailableJobModel].
extension AvailableJobModelPatterns on AvailableJobModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableJobModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableJobModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableJobModel value)  $default,){
final _that = this;
switch (_that) {
case _AvailableJobModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableJobModel value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableJobModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to returning `orElse` callback.
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String company,  String role,  String location,  WorkMode workMode,  JobType jobType,  String? jobUrl,  String? salaryRange,  String? description,  List<String>? requiredSkills,  DateTime? postedAt,  DateTime? expiresAt,  bool isPromoted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableJobModel() when $default != null:
return $default(_that.id,_that.company,_that.role,_that.location,_that.workMode,_that.jobType,_that.jobUrl,_that.salaryRange,_that.description,_that.requiredSkills,_that.postedAt,_that.expiresAt,_that.isPromoted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String company,  String role,  String location,  WorkMode workMode,  JobType jobType,  String? jobUrl,  String? salaryRange,  String? description,  List<String>? requiredSkills,  DateTime? postedAt,  DateTime? expiresAt,  bool isPromoted)  $default,) {final _that = this;
switch (_that) {
case _AvailableJobModel():
return $default(_that.id,_that.company,_that.role,_that.location,_that.workMode,_that.jobType,_that.jobUrl,_that.salaryRange,_that.description,_that.requiredSkills,_that.postedAt,_that.expiresAt,_that.isPromoted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String company,  String role,  String location,  WorkMode workMode,  JobType jobType,  String? jobUrl,  String? salaryRange,  String? description,  List<String>? requiredSkills,  DateTime? postedAt,  DateTime? expiresAt,  bool isPromoted)?  $default,) {final _that = this;
switch (_that) {
case _AvailableJobModel() when $default != null:
return $default(_that.id,_that.company,_that.role,_that.location,_that.workMode,_that.jobType,_that.jobUrl,_that.salaryRange,_that.description,_that.requiredSkills,_that.postedAt,_that.expiresAt,_that.isPromoted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailableJobModel implements AvailableJobModel {
  const _AvailableJobModel({required this.id, required this.company, required this.role, required this.location, this.workMode = WorkMode.hybrid, this.jobType = JobType.internship, this.jobUrl, this.salaryRange, this.description, this.requiredSkills, this.postedAt, this.expiresAt, this.isPromoted = false});
  factory _AvailableJobModel.fromJson(Map<String, dynamic> json) => _$AvailableJobModelFromJson(json);

@override final  String id;
@override final  String company;
@override final  String role;
@override final  String location;
@override final  WorkMode workMode;
@override final  JobType jobType;
@override final  String? jobUrl;
@override final  String? salaryRange;
@override final  String? description;
@override final  List<String>? requiredSkills;
@override final  DateTime? postedAt;
@override final  DateTime? expiresAt;
@override final  bool isPromoted;

/// Create a copy of AvailableJobModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
 _$AvailableJobModelCopyWith<_AvailableJobModel> get copyWith => __$AvailableJobModelCopyWithImpl<_AvailableJobModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailableJobModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableJobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.location, location) || other.location == location)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.jobUrl, jobUrl) || other.jobUrl == jobUrl)&&(identical(other.salaryRange, salaryRange) || other.salaryRange == salaryRange)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiredSkills, requiredSkills) || other.requiredSkills == requiredSkills)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,company,role,location,workMode,jobType,jobUrl,salaryRange,description,requiredSkills,postedAt,expiresAt,isPromoted);

@override
String toString() {
  return 'AvailableJobModel(id: $id, company: $company, role: $role, location: $location, workMode: $workMode, jobType: $jobType, jobUrl: $jobUrl, salaryRange: $salaryRange, description: $description, requiredSkills: $requiredSkills, postedAt: $postedAt, expiresAt: $expiresAt, isPromoted: $isPromoted)';
}


}

/// @nodoc
abstract mixin class _$AvailableJobModelCopyWith<$Res> implements $AvailableJobModelCopyWith<$Res> {
  factory _$AvailableJobModelCopyWith(_AvailableJobModel value, $Res Function(_AvailableJobModel) _then) = __$AvailableJobModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String company, String role, String location, WorkMode workMode, JobType jobType, String? jobUrl, String? salaryRange, String? description, List<String>? requiredSkills, DateTime? postedAt, DateTime? expiresAt, bool isPromoted
});



}
/// @nodoc
class __$AvailableJobModelCopyWithImpl<$Res>
    implements _$AvailableJobModelCopyWith<$Res> {
  __$AvailableJobModelCopyWithImpl(this._self, this._then);

  // ignore: unused_field
  final _AvailableJobModel _self;
  // ignore: unused_field
  final $Res Function(_AvailableJobModel) _then;

/// Create a copy of AvailableJobModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null, Object? company = null, Object? role = null, Object? location = null, Object? workMode = null, Object? jobType = null, Object? jobUrl = freezed, Object? salaryRange = freezed, Object? description = freezed, Object? requiredSkills = freezed, Object? postedAt = freezed, Object? expiresAt = freezed, Object? isPromoted = null}) {
    return _then(_AvailableJobModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,workMode: null == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode,jobType: null == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as JobType,jobUrl: freezed == jobUrl ? _self.jobUrl : jobUrl // ignore: cast_nullable_to_non_nullable
as String?,salaryRange: freezed == salaryRange ? _self.salaryRange : salaryRange // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiredSkills: freezed == requiredSkills ? _self.requiredSkills : requiredSkills // ignore: cast_nullable_to_non_nullable
as List<String>?,postedAt: freezed == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,
    ));
  }

}


// dart format on
