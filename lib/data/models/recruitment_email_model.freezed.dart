// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recruitment_email_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecruitmentEmailModel {

 String get id; String get subject; String get from; String get snippet; DateTime get receivedAt; EmailCategory get category; String? get company; String? get role; bool get isRead; bool get isArchived;
/// Create a copy of RecruitmentEmailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruitmentEmailModelCopyWith<RecruitmentEmailModel> get copyWith => _$RecruitmentEmailModelCopyWithImpl<RecruitmentEmailModel>(this as RecruitmentEmailModel, _$identity);

  /// Serializes this RecruitmentEmailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruitmentEmailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,from,snippet,receivedAt,category,company,role,isRead,isArchived);

@override
String toString() {
  return 'RecruitmentEmailModel(id: $id, subject: $subject, from: $from, snippet: $snippet, receivedAt: $receivedAt, category: $category, company: $company, role: $role, isRead: $isRead, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $RecruitmentEmailModelCopyWith<$Res>  {
  factory $RecruitmentEmailModelCopyWith(RecruitmentEmailModel value, $Res Function(RecruitmentEmailModel) _then) = _$RecruitmentEmailModelCopyWithImpl;
@useResult
$Res call({
 String id, String subject, String from, String snippet, DateTime receivedAt, EmailCategory category, String? company, String? role, bool isRead, bool isArchived
});




}
/// @nodoc
class _$RecruitmentEmailModelCopyWithImpl<$Res>
    implements $RecruitmentEmailModelCopyWith<$Res> {
  _$RecruitmentEmailModelCopyWithImpl(this._self, this._then);

  final RecruitmentEmailModel _self;
  final $Res Function(RecruitmentEmailModel) _then;

/// Create a copy of RecruitmentEmailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subject = null,Object? from = null,Object? snippet = null,Object? receivedAt = null,Object? category = null,Object? company = freezed,Object? role = freezed,Object? isRead = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EmailCategory,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruitmentEmailModel].
extension RecruitmentEmailModelPatterns on RecruitmentEmailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruitmentEmailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruitmentEmailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruitmentEmailModel value)  $default,){
final _that = this;
switch (_that) {
case _RecruitmentEmailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruitmentEmailModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecruitmentEmailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subject,  String from,  String snippet,  DateTime receivedAt,  EmailCategory category,  String? company,  String? role,  bool isRead,  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruitmentEmailModel() when $default != null:
return $default(_that.id,_that.subject,_that.from,_that.snippet,_that.receivedAt,_that.category,_that.company,_that.role,_that.isRead,_that.isArchived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subject,  String from,  String snippet,  DateTime receivedAt,  EmailCategory category,  String? company,  String? role,  bool isRead,  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _RecruitmentEmailModel():
return $default(_that.id,_that.subject,_that.from,_that.snippet,_that.receivedAt,_that.category,_that.company,_that.role,_that.isRead,_that.isArchived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subject,  String from,  String snippet,  DateTime receivedAt,  EmailCategory category,  String? company,  String? role,  bool isRead,  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _RecruitmentEmailModel() when $default != null:
return $default(_that.id,_that.subject,_that.from,_that.snippet,_that.receivedAt,_that.category,_that.company,_that.role,_that.isRead,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruitmentEmailModel implements RecruitmentEmailModel {
  const _RecruitmentEmailModel({required this.id, required this.subject, required this.from, required this.snippet, required this.receivedAt, this.category = EmailCategory.other, this.company, this.role, this.isRead = false, this.isArchived = false});
  factory _RecruitmentEmailModel.fromJson(Map<String, dynamic> json) => _$RecruitmentEmailModelFromJson(json);

@override final  String id;
@override final  String subject;
@override final  String from;
@override final  String snippet;
@override final  DateTime receivedAt;
@override@JsonKey() final  EmailCategory category;
@override final  String? company;
@override final  String? role;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  bool isArchived;

/// Create a copy of RecruitmentEmailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruitmentEmailModelCopyWith<_RecruitmentEmailModel> get copyWith => __$RecruitmentEmailModelCopyWithImpl<_RecruitmentEmailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruitmentEmailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruitmentEmailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.from, from) || other.from == from)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subject,from,snippet,receivedAt,category,company,role,isRead,isArchived);

@override
String toString() {
  return 'RecruitmentEmailModel(id: $id, subject: $subject, from: $from, snippet: $snippet, receivedAt: $receivedAt, category: $category, company: $company, role: $role, isRead: $isRead, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$RecruitmentEmailModelCopyWith<$Res> implements $RecruitmentEmailModelCopyWith<$Res> {
  factory _$RecruitmentEmailModelCopyWith(_RecruitmentEmailModel value, $Res Function(_RecruitmentEmailModel) _then) = __$RecruitmentEmailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String subject, String from, String snippet, DateTime receivedAt, EmailCategory category, String? company, String? role, bool isRead, bool isArchived
});




}
/// @nodoc
class __$RecruitmentEmailModelCopyWithImpl<$Res>
    implements _$RecruitmentEmailModelCopyWith<$Res> {
  __$RecruitmentEmailModelCopyWithImpl(this._self, this._then);

  final _RecruitmentEmailModel _self;
  final $Res Function(_RecruitmentEmailModel) _then;

/// Create a copy of RecruitmentEmailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subject = null,Object? from = null,Object? snippet = null,Object? receivedAt = null,Object? category = null,Object? company = freezed,Object? role = freezed,Object? isRead = null,Object? isArchived = null,}) {
  return _then(_RecruitmentEmailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as EmailCategory,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
