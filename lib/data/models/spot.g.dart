// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotImpl _$$SpotImplFromJson(Map<String, dynamic> json) => _$SpotImpl(
      contentid: json['contentid'] as String? ?? "",
      contenttypeid: json['contenttypeid'] as String? ?? "",
      serialnum: json['serialnum'] as String? ?? "",
      infoname: json['infoname'] as String? ?? "",
      infotext: json['infotext'] as String? ?? "",
      fldgubun: json['fldgubun'] as String? ?? "",
    );

Map<String, dynamic> _$$SpotImplToJson(_$SpotImpl instance) =>
    <String, dynamic>{
      'contentid': instance.contentid,
      'contenttypeid': instance.contenttypeid,
      'serialnum': instance.serialnum,
      'infoname': instance.infoname,
      'infotext': instance.infotext,
      'fldgubun': instance.fldgubun,
    };
