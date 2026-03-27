// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'briefing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BriefingModel {

 String get id;@JsonKey(name: 'user_id') String get userId; DateTime get date;@JsonKey(name: 'content_json') Map<String, dynamic> get contentJson;@JsonKey(name: 'generated_at') DateTime? get generatedAt;@JsonKey(name: 'dismissed_at') DateTime? get dismissedAt;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of BriefingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BriefingModelCopyWith<BriefingModel> get copyWith => _$BriefingModelCopyWithImpl<BriefingModel>(this as BriefingModel, _$identity);

  /// Serializes this BriefingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BriefingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.contentJson, contentJson)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.dismissedAt, dismissedAt) || other.dismissedAt == dismissedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(contentJson),generatedAt,dismissedAt,createdAt);

@override
String toString() {
  return 'BriefingModel(id: $id, userId: $userId, date: $date, contentJson: $contentJson, generatedAt: $generatedAt, dismissedAt: $dismissedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BriefingModelCopyWith<$Res>  {
  factory $BriefingModelCopyWith(BriefingModel value, $Res Function(BriefingModel) _then) = _$BriefingModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date,@JsonKey(name: 'content_json') Map<String, dynamic> contentJson,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'dismissed_at') DateTime? dismissedAt,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$BriefingModelCopyWithImpl<$Res>
    implements $BriefingModelCopyWith<$Res> {
  _$BriefingModelCopyWithImpl(this._self, this._then);

  final BriefingModel _self;
  final $Res Function(BriefingModel) _then;

/// Create a copy of BriefingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? contentJson = null,Object? generatedAt = freezed,Object? dismissedAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,contentJson: null == contentJson ? _self.contentJson : contentJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dismissedAt: freezed == dismissedAt ? _self.dismissedAt : dismissedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BriefingModel].
extension BriefingModelPatterns on BriefingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BriefingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BriefingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BriefingModel value)  $default,){
final _that = this;
switch (_that) {
case _BriefingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BriefingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BriefingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'content_json')  Map<String, dynamic> contentJson, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'dismissed_at')  DateTime? dismissedAt, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BriefingModel() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.contentJson,_that.generatedAt,_that.dismissedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'content_json')  Map<String, dynamic> contentJson, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'dismissed_at')  DateTime? dismissedAt, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _BriefingModel():
return $default(_that.id,_that.userId,_that.date,_that.contentJson,_that.generatedAt,_that.dismissedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  DateTime date, @JsonKey(name: 'content_json')  Map<String, dynamic> contentJson, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'dismissed_at')  DateTime? dismissedAt, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _BriefingModel() when $default != null:
return $default(_that.id,_that.userId,_that.date,_that.contentJson,_that.generatedAt,_that.dismissedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BriefingModel implements BriefingModel {
  const _BriefingModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.date, @JsonKey(name: 'content_json') required final  Map<String, dynamic> contentJson, @JsonKey(name: 'generated_at') this.generatedAt, @JsonKey(name: 'dismissed_at') this.dismissedAt, @JsonKey(name: 'created_at') this.createdAt}): _contentJson = contentJson;
  factory _BriefingModel.fromJson(Map<String, dynamic> json) => _$BriefingModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  DateTime date;
 final  Map<String, dynamic> _contentJson;
@override@JsonKey(name: 'content_json') Map<String, dynamic> get contentJson {
  if (_contentJson is EqualUnmodifiableMapView) return _contentJson;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contentJson);
}

@override@JsonKey(name: 'generated_at') final  DateTime? generatedAt;
@override@JsonKey(name: 'dismissed_at') final  DateTime? dismissedAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of BriefingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BriefingModelCopyWith<_BriefingModel> get copyWith => __$BriefingModelCopyWithImpl<_BriefingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BriefingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BriefingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._contentJson, _contentJson)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.dismissedAt, dismissedAt) || other.dismissedAt == dismissedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,date,const DeepCollectionEquality().hash(_contentJson),generatedAt,dismissedAt,createdAt);

@override
String toString() {
  return 'BriefingModel(id: $id, userId: $userId, date: $date, contentJson: $contentJson, generatedAt: $generatedAt, dismissedAt: $dismissedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BriefingModelCopyWith<$Res> implements $BriefingModelCopyWith<$Res> {
  factory _$BriefingModelCopyWith(_BriefingModel value, $Res Function(_BriefingModel) _then) = __$BriefingModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, DateTime date,@JsonKey(name: 'content_json') Map<String, dynamic> contentJson,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'dismissed_at') DateTime? dismissedAt,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$BriefingModelCopyWithImpl<$Res>
    implements _$BriefingModelCopyWith<$Res> {
  __$BriefingModelCopyWithImpl(this._self, this._then);

  final _BriefingModel _self;
  final $Res Function(_BriefingModel) _then;

/// Create a copy of BriefingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? date = null,Object? contentJson = null,Object? generatedAt = freezed,Object? dismissedAt = freezed,Object? createdAt = freezed,}) {
  return _then(_BriefingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,contentJson: null == contentJson ? _self._contentJson : contentJson // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dismissedAt: freezed == dismissedAt ? _self.dismissedAt : dismissedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
