import 'package:flutter/material.dart';

const listOptions = {
  'R': 'Latest',
  'O': 'Title',
  'Q': 'Modification',
};
// const Map<String, String> categoryString = {
//   'A01': '자연',
//   'A02': '인문(문화 / 예술 / 역사)',
//   'C01': '추천코스',
//   'A03': '레포츠',
//   'B02': '숙박',
//   'A04': '쇼핑',
//   'A05': '음식',
// };

const Map<String, String> categoryString = {
  'A0101': '자연관광지',
  'A0102': '관광자원',
  'A0201': '역사관광지',
  'A0202': '휴양관광지',
  'A0203': '체험관광지',
  'A0204': '산업관광지',
  'A0205': '건축/조형물',
  'A0206': '문화시설',
  'A0207': '축제',
  'A0208': '공연/행사',
  'A0301': '레포츠소개',
  'A0302': '육상레포츠',
  'A0303': '수상레포츠',
  'A0304': '항공레포츠',
  'A0305': '복합레포츠',
  'A0401': '쇼핑',
  'A0502': '음식점',
};

const Map<String, IconData> categoryIcon = {
  'A0101': (Icons.park), // 자연관광지
  'A0102': (Icons.landscape), // 관광자원
  'A0201': (Icons.account_balance), // 역사관광지
  'A0202': (Icons.spa), // 휴양관광지
  'A0203': (Icons.hiking), // 체험관광지
  'A0204': (Icons.factory), // 산업관광지
  'A0205': (Icons.location_city), // 건축/조형물
  'A0206': (Icons.museum), // 문화시설
  'A0207': (Icons.celebration), // 축제
  'A0208': (Icons.event), // 공연/행사
  'A0301': (Icons.sports), // 레포츠소개
  'A0302': (Icons.directions_run), // 육상레포츠
  'A0303': (Icons.pool), // 수상레포츠
  'A0304': (Icons.airplanemode_active), // 항공레포츠
  'A0305': (Icons.sports_soccer), // 복합레포츠
  'A0401': (Icons.shopping_bag), // 쇼핑
  'A0502': (Icons.restaurant), // 음식점
};
