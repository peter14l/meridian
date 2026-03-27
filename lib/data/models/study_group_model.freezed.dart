// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyGroupModel {

 String get id; String get name;@JsonKey(name: 'invite_code') String get inviteCode;@JsonKey(name: 'created_by') String get createdBy;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of StudyGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyGroupModelCopyWith<StudyGroupModel> get copyWith => _$StudyGroupModelCopyWithImpl<StudyGroupModel>(this as StudyGroupModel, _$identity);

  /// Serializes this StudyGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,inviteCode,createdBy,createdAt);

@override
String toString() {
  return 'StudyGroupModel(id: $id, name: $name, inviteCode: $inviteCode, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $StudyGroupModelCopyWith<$Res>  {
  factory $StudyGroupModelCopyWith(StudyGroupModel value, $Res Function(StudyGroupModel) _then) = _$StudyGroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'invite_code') String inviteCode,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$StudyGroupModelCopyWithImpl<$Res>
    implements $StudyGroupModelCopyWith<$Res> {
  _$StudyGroupModelCopyWithImpl(this._self, this._then);

  final StudyGroupModel _self;
  final $Res Function(StudyGroupModel) _then;

/// Create a copy of StudyGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? inviteCode = null,Object? createdBy = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyGroupModel].
extension StudyGroupModelPatterns on StudyGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _StudyGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _StudyGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'invite_code')  String inviteCode, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.inviteCode,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'invite_code')  String inviteCode, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _StudyGroupModel():
return $default(_that.id,_that.name,_that.inviteCode,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'invite_code')  String inviteCode, @JsonKey(name: 'created_by')  String createdBy, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _StudyGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.inviteCode,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyGroupModel implements StudyGroupModel {
  const _StudyGroupModel({required this.id, required this.name, @JsonKey(name: 'invite_code') required this.inviteCode, @JsonKey(name: 'created_by') required this.createdBy, @JsonKey(name: 'created_at') this.createdAt});
  factory _StudyGroupModel.fromJson(Map<String, dynamic> json) => _$StudyGroupModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'invite_code') final  String inviteCode;
@override@JsonKey(name: 'created_by') final  String createdBy;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of StudyGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyGroupModelCopyWith<_StudyGroupModel> get copyWith => __$StudyGroupModelCopyWithImpl<_StudyGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,inviteCode,createdBy,createdAt);

@override
String toString() {
  return 'StudyGroupModel(id: $id, name: $name, inviteCode: $inviteCode, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$StudyGroupModelCopyWith<$Res> implements $StudyGroupModelCopyWith<$Res> {
  factory _$StudyGroupModelCopyWith(_StudyGroupModel value, $Res Function(_StudyGroupModel) _then) = __$StudyGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'invite_code') String inviteCode,@JsonKey(name: 'created_by') String createdBy,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$StudyGroupModelCopyWithImpl<$Res>
    implements _$StudyGroupModelCopyWith<$Res> {
  __$StudyGroupModelCopyWithImpl(this._self, this._then);

  final _StudyGroupModel _self;
  final $Res Function(_StudyGroupModel) _then;

/// Create a copy of StudyGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? inviteCode = null,Object? createdBy = null,Object? createdAt = freezed,}) {
  return _then(_StudyGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,inviteCode: null == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$GroupMessageModel {

 String get id;@JsonKey(name: 'group_id') String get groupId;@JsonKey(name: 'user_id') String get userId; String get content;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of GroupMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupMessageModelCopyWith<GroupMessageModel> get copyWith => _$GroupMessageModelCopyWithImpl<GroupMessageModel>(this as GroupMessageModel, _$identity);

  /// Serializes this GroupMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,content,createdAt);

@override
String toString() {
  return 'GroupMessageModel(id: $id, groupId: $groupId, userId: $userId, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $GroupMessageModelCopyWith<$Res>  {
  factory $GroupMessageModelCopyWith(GroupMessageModel value, $Res Function(GroupMessageModel) _then) = _$GroupMessageModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'group_id') String groupId,@JsonKey(name: 'user_id') String userId, String content,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$GroupMessageModelCopyWithImpl<$Res>
    implements $GroupMessageModelCopyWith<$Res> {
  _$GroupMessageModelCopyWithImpl(this._self, this._then);

  final GroupMessageModel _self;
  final $Res Function(GroupMessageModel) _then;

/// Create a copy of GroupMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? content = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupMessageModel].
extension GroupMessageModelPatterns on GroupMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'group_id')  String groupId, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupMessageModel() when $default != null:
return $default(_that.id,_that.groupId,_that.userId,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'group_id')  String groupId, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _GroupMessageModel():
return $default(_that.id,_that.groupId,_that.userId,_that.content,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'group_id')  String groupId, @JsonKey(name: 'user_id')  String userId,  String content, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _GroupMessageModel() when $default != null:
return $default(_that.id,_that.groupId,_that.userId,_that.content,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupMessageModel implements GroupMessageModel {
  const _GroupMessageModel({required this.id, @JsonKey(name: 'group_id') required this.groupId, @JsonKey(name: 'user_id') required this.userId, required this.content, @JsonKey(name: 'created_at') this.createdAt});
  factory _GroupMessageModel.fromJson(Map<String, dynamic> json) => _$GroupMessageModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'group_id') final  String groupId;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String content;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of GroupMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupMessageModelCopyWith<_GroupMessageModel> get copyWith => __$GroupMessageModelCopyWithImpl<_GroupMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupId,userId,content,createdAt);

@override
String toString() {
  return 'GroupMessageModel(id: $id, groupId: $groupId, userId: $userId, content: $content, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GroupMessageModelCopyWith<$Res> implements $GroupMessageModelCopyWith<$Res> {
  factory _$GroupMessageModelCopyWith(_GroupMessageModel value, $Res Function(_GroupMessageModel) _then) = __$GroupMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'group_id') String groupId,@JsonKey(name: 'user_id') String userId, String content,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$GroupMessageModelCopyWithImpl<$Res>
    implements _$GroupMessageModelCopyWith<$Res> {
  __$GroupMessageModelCopyWithImpl(this._self, this._then);

  final _GroupMessageModel _self;
  final $Res Function(_GroupMessageModel) _then;

/// Create a copy of GroupMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = null,Object? userId = null,Object? content = null,Object? createdAt = freezed,}) {
  return _then(_GroupMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
