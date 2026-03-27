// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedItemModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get url; String? get title; String? get description; SavedTag? get tag;@JsonKey(name: 'suggested_goal_id') String? get suggestedGoalId;@JsonKey(name: 'suggested_course_id') String? get suggestedCourseId;@JsonKey(name: 'ai_summary') String? get aiSummary;@JsonKey(name: 'ai_tags') List<String>? get aiTags;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'deleted_at') DateTime? get deletedAt;
/// Create a copy of SavedItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedItemModelCopyWith<SavedItemModel> get copyWith => _$SavedItemModelCopyWithImpl<SavedItemModel>(this as SavedItemModel, _$identity);

  /// Serializes this SavedItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.suggestedGoalId, suggestedGoalId) || other.suggestedGoalId == suggestedGoalId)&&(identical(other.suggestedCourseId, suggestedCourseId) || other.suggestedCourseId == suggestedCourseId)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&const DeepCollectionEquality().equals(other.aiTags, aiTags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,url,title,description,tag,suggestedGoalId,suggestedCourseId,aiSummary,const DeepCollectionEquality().hash(aiTags),createdAt,deletedAt);

@override
String toString() {
  return 'SavedItemModel(id: $id, userId: $userId, url: $url, title: $title, description: $description, tag: $tag, suggestedGoalId: $suggestedGoalId, suggestedCourseId: $suggestedCourseId, aiSummary: $aiSummary, aiTags: $aiTags, createdAt: $createdAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $SavedItemModelCopyWith<$Res>  {
  factory $SavedItemModelCopyWith(SavedItemModel value, $Res Function(SavedItemModel) _then) = _$SavedItemModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String url, String? title, String? description, SavedTag? tag,@JsonKey(name: 'suggested_goal_id') String? suggestedGoalId,@JsonKey(name: 'suggested_course_id') String? suggestedCourseId,@JsonKey(name: 'ai_summary') String? aiSummary,@JsonKey(name: 'ai_tags') List<String>? aiTags,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'deleted_at') DateTime? deletedAt
});




}
/// @nodoc
class _$SavedItemModelCopyWithImpl<$Res>
    implements $SavedItemModelCopyWith<$Res> {
  _$SavedItemModelCopyWithImpl(this._self, this._then);

  final SavedItemModel _self;
  final $Res Function(SavedItemModel) _then;

/// Create a copy of SavedItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? url = null,Object? title = freezed,Object? description = freezed,Object? tag = freezed,Object? suggestedGoalId = freezed,Object? suggestedCourseId = freezed,Object? aiSummary = freezed,Object? aiTags = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as SavedTag?,suggestedGoalId: freezed == suggestedGoalId ? _self.suggestedGoalId : suggestedGoalId // ignore: cast_nullable_to_non_nullable
as String?,suggestedCourseId: freezed == suggestedCourseId ? _self.suggestedCourseId : suggestedCourseId // ignore: cast_nullable_to_non_nullable
as String?,aiSummary: freezed == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String?,aiTags: freezed == aiTags ? _self.aiTags : aiTags // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedItemModel].
extension SavedItemModelPatterns on SavedItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedItemModel value)  $default,){
final _that = this;
switch (_that) {
case _SavedItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _SavedItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String url,  String? title,  String? description,  SavedTag? tag, @JsonKey(name: 'suggested_goal_id')  String? suggestedGoalId, @JsonKey(name: 'suggested_course_id')  String? suggestedCourseId, @JsonKey(name: 'ai_summary')  String? aiSummary, @JsonKey(name: 'ai_tags')  List<String>? aiTags, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedItemModel() when $default != null:
return $default(_that.id,_that.userId,_that.url,_that.title,_that.description,_that.tag,_that.suggestedGoalId,_that.suggestedCourseId,_that.aiSummary,_that.aiTags,_that.createdAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String url,  String? title,  String? description,  SavedTag? tag, @JsonKey(name: 'suggested_goal_id')  String? suggestedGoalId, @JsonKey(name: 'suggested_course_id')  String? suggestedCourseId, @JsonKey(name: 'ai_summary')  String? aiSummary, @JsonKey(name: 'ai_tags')  List<String>? aiTags, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _SavedItemModel():
return $default(_that.id,_that.userId,_that.url,_that.title,_that.description,_that.tag,_that.suggestedGoalId,_that.suggestedCourseId,_that.aiSummary,_that.aiTags,_that.createdAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String url,  String? title,  String? description,  SavedTag? tag, @JsonKey(name: 'suggested_goal_id')  String? suggestedGoalId, @JsonKey(name: 'suggested_course_id')  String? suggestedCourseId, @JsonKey(name: 'ai_summary')  String? aiSummary, @JsonKey(name: 'ai_tags')  List<String>? aiTags, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'deleted_at')  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedItemModel() when $default != null:
return $default(_that.id,_that.userId,_that.url,_that.title,_that.description,_that.tag,_that.suggestedGoalId,_that.suggestedCourseId,_that.aiSummary,_that.aiTags,_that.createdAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedItemModel implements SavedItemModel {
  const _SavedItemModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.url, this.title, this.description, this.tag, @JsonKey(name: 'suggested_goal_id') this.suggestedGoalId, @JsonKey(name: 'suggested_course_id') this.suggestedCourseId, @JsonKey(name: 'ai_summary') this.aiSummary, @JsonKey(name: 'ai_tags') final  List<String>? aiTags, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'deleted_at') this.deletedAt}): _aiTags = aiTags;
  factory _SavedItemModel.fromJson(Map<String, dynamic> json) => _$SavedItemModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String url;
@override final  String? title;
@override final  String? description;
@override final  SavedTag? tag;
@override@JsonKey(name: 'suggested_goal_id') final  String? suggestedGoalId;
@override@JsonKey(name: 'suggested_course_id') final  String? suggestedCourseId;
@override@JsonKey(name: 'ai_summary') final  String? aiSummary;
 final  List<String>? _aiTags;
@override@JsonKey(name: 'ai_tags') List<String>? get aiTags {
  final value = _aiTags;
  if (value == null) return null;
  if (_aiTags is EqualUnmodifiableListView) return _aiTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'deleted_at') final  DateTime? deletedAt;

/// Create a copy of SavedItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedItemModelCopyWith<_SavedItemModel> get copyWith => __$SavedItemModelCopyWithImpl<_SavedItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.suggestedGoalId, suggestedGoalId) || other.suggestedGoalId == suggestedGoalId)&&(identical(other.suggestedCourseId, suggestedCourseId) || other.suggestedCourseId == suggestedCourseId)&&(identical(other.aiSummary, aiSummary) || other.aiSummary == aiSummary)&&const DeepCollectionEquality().equals(other._aiTags, _aiTags)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,url,title,description,tag,suggestedGoalId,suggestedCourseId,aiSummary,const DeepCollectionEquality().hash(_aiTags),createdAt,deletedAt);

@override
String toString() {
  return 'SavedItemModel(id: $id, userId: $userId, url: $url, title: $title, description: $description, tag: $tag, suggestedGoalId: $suggestedGoalId, suggestedCourseId: $suggestedCourseId, aiSummary: $aiSummary, aiTags: $aiTags, createdAt: $createdAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$SavedItemModelCopyWith<$Res> implements $SavedItemModelCopyWith<$Res> {
  factory _$SavedItemModelCopyWith(_SavedItemModel value, $Res Function(_SavedItemModel) _then) = __$SavedItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String url, String? title, String? description, SavedTag? tag,@JsonKey(name: 'suggested_goal_id') String? suggestedGoalId,@JsonKey(name: 'suggested_course_id') String? suggestedCourseId,@JsonKey(name: 'ai_summary') String? aiSummary,@JsonKey(name: 'ai_tags') List<String>? aiTags,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'deleted_at') DateTime? deletedAt
});




}
/// @nodoc
class __$SavedItemModelCopyWithImpl<$Res>
    implements _$SavedItemModelCopyWith<$Res> {
  __$SavedItemModelCopyWithImpl(this._self, this._then);

  final _SavedItemModel _self;
  final $Res Function(_SavedItemModel) _then;

/// Create a copy of SavedItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? url = null,Object? title = freezed,Object? description = freezed,Object? tag = freezed,Object? suggestedGoalId = freezed,Object? suggestedCourseId = freezed,Object? aiSummary = freezed,Object? aiTags = freezed,Object? createdAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_SavedItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as SavedTag?,suggestedGoalId: freezed == suggestedGoalId ? _self.suggestedGoalId : suggestedGoalId // ignore: cast_nullable_to_non_nullable
as String?,suggestedCourseId: freezed == suggestedCourseId ? _self.suggestedCourseId : suggestedCourseId // ignore: cast_nullable_to_non_nullable
as String?,aiSummary: freezed == aiSummary ? _self.aiSummary : aiSummary // ignore: cast_nullable_to_non_nullable
as String?,aiTags: freezed == aiTags ? _self._aiTags : aiTags // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
