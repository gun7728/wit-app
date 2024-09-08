import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/models/location.dart';

class LocationRepository {
  final Dio _dio = Dio(); // Dio 인스턴스 생성
  final publicKey = dotenv.get('TOUR_API_ECD_KEY');
  final baseUrl = dotenv.get('BASE_URL');

  get http => null;

  Future<List<Location>> listLocations({position, type}) async {
    final mapX = position.longitude;
    final mapY = position.latitude;

    final locationBasedListUrl =
        'locationBasedList1?serviceKey=$publicKey&numOfRows=10&pageNo=0&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&mapX=$mapX&mapY=$mapY&radius=1000&contentTypeId=$type';

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
              .map((item) => Location.fromJson(item as Map<String, dynamic>))
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
}
