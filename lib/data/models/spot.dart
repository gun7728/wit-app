import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot.freezed.dart';
part 'spot.g.dart';

@freezed
class Spot with _$Spot {
  factory Spot({
    @Default("") String contentid,
    @Default("") String contenttypeid,
    @Default("") String serialnum,
    @Default("") String infoname,
    @Default("") String infotext,
    @Default("") String fldgubun,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}
