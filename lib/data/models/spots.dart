import 'package:freezed_annotation/freezed_annotation.dart';

part 'spots.freezed.dart';
part 'spots.g.dart';

@freezed
class Spots with _$Spots {
  factory Spots({
    @Default("") dynamic contentId,
    @Default("") dynamic contentTypeId,
    @Default("") dynamic title,
    @Default("") dynamic createTime,
    @Default("") dynamic modifiedTime,
    @Default("") dynamic tel,
    @Default("") dynamic telNm,
    @Default("") dynamic hmpg,
    @Default("") dynamic areaCd,
    @Default("") dynamic signguCd,
    @Default("") dynamic emdCd,
    @Default("") dynamic cat1,
    @Default("") dynamic cat2,
    @Default("") dynamic cat3,
    @Default("") dynamic zpCd,
    @Default("") dynamic addr1,
    @Default("") dynamic addr2,
    @Default("") dynamic showFlag,
    @Default("") dynamic bookTour,
    @Default("") dynamic outl,
    @Default("") dynamic firstImage,
    @Default("") dynamic firstImage2,
    @Default("") dynamic firstImage3,
    @Default("") dynamic mapImage,
    @Default("") dynamic wayGuide,
    @Default("") dynamic imterArea,
    @Default("") dynamic insideArea,
    @Default("") dynamic shuttle,
    @Default("") dynamic withFlag,
    @Default("") dynamic readCount,
    @Default("") dynamic xCoord,
    @Default("") dynamic yCoord,
  }) = _Spots;

  factory Spots.fromJson(Map<String, dynamic> json) => _$SpotsFromJson(json);
}
