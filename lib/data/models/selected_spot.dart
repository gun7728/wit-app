import 'package:freezed_annotation/freezed_annotation.dart';

part 'selected_spot.freezed.dart';
part 'selected_spot.g.dart';

@freezed
class SelectedSpot with _$SelectedSpot {
  factory SelectedSpot({
    @Default("") String addr1,
    @Default("") String addr2,
    @Default("") String areacode,
    @Default("") String booktour,
    @Default("") String cat1,
    @Default("") String cat2,
    @Default("") String cat3,
    @Default("") String contentid,
    @Default("") String contenttypeid,
    @Default("") String cpyrht,
    @Default("") String createdtime,
    @Default("") String dist,
    @Default("") String firstimage,
    @Default("") String firstimage2,
    @Default("") String mapx,
    @Default("") String mapy,
    @Default("") String mlevel,
    @Default("") String modifiedtime,
    @Default("") String sigungucode,
    @Default("") String tel,
    @Default("") String title,
  }) = _SelectedSpot;

  factory SelectedSpot.fromJson(Map<String, dynamic> json) =>
      _$SelectedSpotFromJson(json);
}
