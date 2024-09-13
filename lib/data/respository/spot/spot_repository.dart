import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/data/models/spot.dart';

class SpotRepository {
  final Dio _dio = Dio(); // Dio 인스턴스 생성
  final publicKey = dotenv.get('TOUR_API_ECD_KEY');
  final baseUrl = dotenv.get('BASE_URL');

  get http => null;

  Future<List<Spot>> getSpotList({position, type, page = 1}) async {
    final mapX = position.longitude;
    final mapY = position.latitude;

    var typeString = type == 0 ? '' : '&contentTypeId=$type';

    final locationBasedListUrl =
        'locationBasedList1?serviceKey=$publicKey&numOfRows=10&pageNo=$page&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&mapX=$mapX&mapY=$mapY&radius=1000$typeString';

    final String url = '$baseUrl/$locationBasedListUrl';

    try {
      final response = await _dio.get(url.toString());

      if (response.statusCode == 200) {
        final responseBody = response.data;

        // 응답 구조에 따라 데이터 추출
        final items = responseBody['response']['body']['items']['item'];

        if (items is List) {
          // List<Location>로 변환
          return items
              .map((item) => Spot.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Expected a List of items');
        }
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching locations');
    }
  }

  Future<Map<String, dynamic>> getInfiniteSpotList(
      {position, type, page}) async {
    final mapX = position.longitude;
    final mapY = position.latitude;

    var typeString = type == 0 ? '' : '&contentTypeId=$type';

    final locationBasedListUrl =
        'locationBasedList1?serviceKey=$publicKey&numOfRows=10&pageNo=$page&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&mapX=$mapX&mapY=$mapY&radius=1000$typeString';

    final String url = '$baseUrl/$locationBasedListUrl';
    print(url);

    try {
      final response = await _dio.get(url.toString());

      if (response.statusCode == 200) {
        final responseBody = response.data;

        // 응답 구조에 따라 데이터 추출
        final items = responseBody['response']['body']['items']['item'];
        final totalCount = responseBody['response']['body']['totalCount'];

        if (items is List) {
          return {
            'data': items
                .map((item) => Spot.fromJson(item as Map<String, dynamic>))
                .toList(),
            'totalCount': totalCount,
          };
        } else {
          throw Exception('Expected a List of items');
        }
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching locations');
    }
  }
}
