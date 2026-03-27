// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get label;@JsonKey(name: 'file_url') String get fileUrl;@JsonKey(name: 'file_size') int? get fileSize;@JsonKey(name: 'is_primary') bool get isPrimary;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeModelCopyWith<ResumeModel> get copyWith => _$ResumeModelCopyWithImpl<ResumeModel>(this as ResumeModel, _$identity);

  /// Serializes this ResumeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,label,fileUrl,fileSize,isPrimary,createdAt,updatedAt);

@override
String toString() {
  return 'ResumeModel(id: $id, userId: $userId, label: $label, fileUrl: $fileUrl, fileSize: $fileSize, isPrimary: $isPrimary, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ResumeModelCopyWith<$Res>  {
  factory $ResumeModelCopyWith(ResumeModel value, $Res Function(ResumeModel) _then) = _$ResumeModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String label,@JsonKey(name: 'file_url') String fileUrl,@JsonKey(name: 'file_size') int? fileSize,@JsonKey(name: 'is_primary') bool isPrimary,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ResumeModelCopyWithImpl<$Res>
    implements $ResumeModelCopyWith<$Res> {
  _$ResumeModelCopyWithImpl(this._self, this._then);

  final ResumeModel _self;
  final $Res Function(ResumeModel) _then;

/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? label = null,Object? fileUrl = null,Object? fileSize = freezed,Object? isPrimary = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeModel].
extension ResumeModelPatterns on ResumeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeModel value)  $default,){
final _that = this;
switch (_that) {
case _ResumeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String label, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that.id,_that.userId,_that.label,_that.fileUrl,_that.fileSize,_that.isPrimary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String label, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ResumeModel():
return $default(_that.id,_that.userId,_that.label,_that.fileUrl,_that.fileSize,_that.isPrimary,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String label, @JsonKey(name: 'file_url')  String fileUrl, @JsonKey(name: 'file_size')  int? fileSize, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that.id,_that.userId,_that.label,_that.fileUrl,_that.fileSize,_that.isPrimary,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeModel implements ResumeModel {
  const _ResumeModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.label, @JsonKey(name: 'file_url') required this.fileUrl, @JsonKey(name: 'file_size') this.fileSize, @JsonKey(name: 'is_primary') this.isPrimary = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _ResumeModel.fromJson(Map<String, dynamic> json) => _$ResumeModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String label;
@override@JsonKey(name: 'file_url') final  String fileUrl;
@override@JsonKey(name: 'file_size') final  int? fileSize;
@override@JsonKey(name: 'is_primary') final  bool isPrimary;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeModelCopyWith<_ResumeModel> get copyWith => __$ResumeModelCopyWithImpl<_ResumeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.label, label) || other.label == label)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,label,fileUrl,fileSize,isPrimary,createdAt,updatedAt);

@override
String toString() {
  return 'ResumeModel(id: $id, userId: $userId, label: $label, fileUrl: $fileUrl, fileSize: $fileSize, isPrimary: $isPrimary, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ResumeModelCopyWith<$Res> implements $ResumeModelCopyWith<$Res> {
  factory _$ResumeModelCopyWith(_ResumeModel value, $Res Function(_ResumeModel) _then) = __$ResumeModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String label,@JsonKey(name: 'file_url') String fileUrl,@JsonKey(name: 'file_size') int? fileSize,@JsonKey(name: 'is_primary') bool isPrimary,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ResumeModelCopyWithImpl<$Res>
    implements _$ResumeModelCopyWith<$Res> {
  __$ResumeModelCopyWithImpl(this._self, this._then);

  final _ResumeModel _self;
  final $Res Function(_ResumeModel) _then;

/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? label = null,Object? fileUrl = null,Object? fileSize = freezed,Object? isPrimary = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ResumeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
