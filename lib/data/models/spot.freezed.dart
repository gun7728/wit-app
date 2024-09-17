// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Spot _$SpotFromJson(Map<String, dynamic> json) {
  return _Spot.fromJson(json);
}

/// @nodoc
mixin _$Spot {
  String get contentid => throw _privateConstructorUsedError;
  String get contenttypeid => throw _privateConstructorUsedError;
  String get serialnum => throw _privateConstructorUsedError;
  String get infoname => throw _privateConstructorUsedError;
  String get infotext => throw _privateConstructorUsedError;
  String get fldgubun => throw _privateConstructorUsedError;

  /// Serializes this Spot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotCopyWith<Spot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotCopyWith<$Res> {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) then) =
      _$SpotCopyWithImpl<$Res, Spot>;
  @useResult
  $Res call(
      {String contentid,
      String contenttypeid,
      String serialnum,
      String infoname,
      String infotext,
      String fldgubun});
}

/// @nodoc
class _$SpotCopyWithImpl<$Res, $Val extends Spot>
    implements $SpotCopyWith<$Res> {
  _$SpotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentid = null,
    Object? contenttypeid = null,
    Object? serialnum = null,
    Object? infoname = null,
    Object? infotext = null,
    Object? fldgubun = null,
  }) {
    return _then(_value.copyWith(
      contentid: null == contentid
          ? _value.contentid
          : contentid // ignore: cast_nullable_to_non_nullable
              as String,
      contenttypeid: null == contenttypeid
          ? _value.contenttypeid
          : contenttypeid // ignore: cast_nullable_to_non_nullable
              as String,
      serialnum: null == serialnum
          ? _value.serialnum
          : serialnum // ignore: cast_nullable_to_non_nullable
              as String,
      infoname: null == infoname
          ? _value.infoname
          : infoname // ignore: cast_nullable_to_non_nullable
              as String,
      infotext: null == infotext
          ? _value.infotext
          : infotext // ignore: cast_nullable_to_non_nullable
              as String,
      fldgubun: null == fldgubun
          ? _value.fldgubun
          : fldgubun // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpotImplCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$$SpotImplCopyWith(
          _$SpotImpl value, $Res Function(_$SpotImpl) then) =
      __$$SpotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contentid,
      String contenttypeid,
      String serialnum,
      String infoname,
      String infotext,
      String fldgubun});
}

/// @nodoc
class __$$SpotImplCopyWithImpl<$Res>
    extends _$SpotCopyWithImpl<$Res, _$SpotImpl>
    implements _$$SpotImplCopyWith<$Res> {
  __$$SpotImplCopyWithImpl(_$SpotImpl _value, $Res Function(_$SpotImpl) _then)
      : super(_value, _then);

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentid = null,
    Object? contenttypeid = null,
    Object? serialnum = null,
    Object? infoname = null,
    Object? infotext = null,
    Object? fldgubun = null,
  }) {
    return _then(_$SpotImpl(
      contentid: null == contentid
          ? _value.contentid
          : contentid // ignore: cast_nullable_to_non_nullable
              as String,
      contenttypeid: null == contenttypeid
          ? _value.contenttypeid
          : contenttypeid // ignore: cast_nullable_to_non_nullable
              as String,
      serialnum: null == serialnum
          ? _value.serialnum
          : serialnum // ignore: cast_nullable_to_non_nullable
              as String,
      infoname: null == infoname
          ? _value.infoname
          : infoname // ignore: cast_nullable_to_non_nullable
              as String,
      infotext: null == infotext
          ? _value.infotext
          : infotext // ignore: cast_nullable_to_non_nullable
              as String,
      fldgubun: null == fldgubun
          ? _value.fldgubun
          : fldgubun // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotImpl implements _Spot {
  _$SpotImpl(
      {this.contentid = "",
      this.contenttypeid = "",
      this.serialnum = "",
      this.infoname = "",
      this.infotext = "",
      this.fldgubun = ""});

  factory _$SpotImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotImplFromJson(json);

  @override
  @JsonKey()
  final String contentid;
  @override
  @JsonKey()
  final String contenttypeid;
  @override
  @JsonKey()
  final String serialnum;
  @override
  @JsonKey()
  final String infoname;
  @override
  @JsonKey()
  final String infotext;
  @override
  @JsonKey()
  final String fldgubun;

  @override
  String toString() {
    return 'Spot(contentid: $contentid, contenttypeid: $contenttypeid, serialnum: $serialnum, infoname: $infoname, infotext: $infotext, fldgubun: $fldgubun)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotImpl &&
            (identical(other.contentid, contentid) ||
                other.contentid == contentid) &&
            (identical(other.contenttypeid, contenttypeid) ||
                other.contenttypeid == contenttypeid) &&
            (identical(other.serialnum, serialnum) ||
                other.serialnum == serialnum) &&
            (identical(other.infoname, infoname) ||
                other.infoname == infoname) &&
            (identical(other.infotext, infotext) ||
                other.infotext == infotext) &&
            (identical(other.fldgubun, fldgubun) ||
                other.fldgubun == fldgubun));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contentid, contenttypeid,
      serialnum, infoname, infotext, fldgubun);

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      __$$SpotImplCopyWithImpl<_$SpotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotImplToJson(
      this,
    );
  }
}

abstract class _Spot implements Spot {
  factory _Spot(
      {final String contentid,
      final String contenttypeid,
      final String serialnum,
      final String infoname,
      final String infotext,
      final String fldgubun}) = _$SpotImpl;

  factory _Spot.fromJson(Map<String, dynamic> json) = _$SpotImpl.fromJson;

  @override
  String get contentid;
  @override
  String get contenttypeid;
  @override
  String get serialnum;
  @override
  String get infoname;
  @override
  String get infotext;
  @override
  String get fldgubun;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
