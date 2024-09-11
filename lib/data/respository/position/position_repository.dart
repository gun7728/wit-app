import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wit_app/data/models/position.dart' as custom_position;

class PositionRepository {
  final Dio _dio = Dio(); // Dio 인스턴스 생성

  Future<custom_position.Position?> getPostion() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    var getPosition = await Geolocator.getCurrentPosition();

    // 가져온 위치 데이터를 custom_position.Position 객체로 변환하여 반환
    return custom_position.Position(
      longitude: getPosition.longitude,
      latitude: getPosition.latitude,
    );
  }

  Future<String> getPostionKor() async {
    var getPosition = await Geolocator.getCurrentPosition();

    final baseUrl = dotenv.get('VWORLD_BASE_URL');
    final key = dotenv.get('VWORLD_KEY');
    final reverseGeocoding =
        '/req/address?service=address&request=getAddress&crs=epsg:4326&format=json&type=both&zipcode=true&simple=false&key=$key&point=${getPosition.longitude},${getPosition.latitude}';

    final String url = '$baseUrl/$reverseGeocoding';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final positionKor =
            response.data['response']['result'][0]['structure']['level4L'] == ''
                ? response.data['response']['result'][0]['structure']['level4A']
                : response.data['response']['result'][0]['structure']
                    ['level4L'];

        return positionKor;
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching locations');
    }
  }
}
