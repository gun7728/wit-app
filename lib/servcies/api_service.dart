import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wit_app/model/location_model.dart';
import 'package:http/http.dart' as http;
import 'package:wit_app/servcies/location_service.dart';

class ApiService {
  final baseUrl = dotenv.get('BASE_URL');
  final publicKey = dotenv.get('TOUR_API_ECD_KEY');

  Future getCurrentLocation(x, y) async {
    final baseUrl = dotenv.get('VWORLD_BASE_URL');
    final key = dotenv.get('VWORLD_KEY');
    final reverseGeocoding =
        '/req/address?service=address&request=getAddress&crs=epsg:4326&format=json&type=both&zipcode=true&simple=false&key=$key&point=$x,$y';

    final url = Uri.parse('$baseUrl/$reverseGeocoding');
    final response = await http.get(url);
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

    return responseBody['response']['result'][0];
  }

  Future<List<LocationModel>> getDefaultEventList() async {
    List<LocationModel> locationDataInstances = [];
    try {
      Position position = await LocationService().getCurrentPosition();

      final mapX = position.longitude;
      final mapY = position.latitude;

      final locationBasedListUrl =
          'locationBasedList1?serviceKey=$publicKey&numOfRows=10&pageNo=0&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&mapX=$mapX&mapY=$mapY&radius=1000&contentTypeId=15';

      final url = Uri.parse('$baseUrl/$locationBasedListUrl');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

        if (responseBody.containsKey('response') &&
            responseBody['response'].containsKey('body') &&
            responseBody['response']['body'].containsKey('items')) {
          final locationBasedList = responseBody['response']['body']['items'];

          if (locationBasedList != null &&
              locationBasedList is Map &&
              locationBasedList.containsKey('item')) {
            var items = locationBasedList['item'];

            if (items is List) {
              for (var locationData in items) {
                final instance = LocationModel.fromJson(locationData);
                locationDataInstances.add(instance);
              }
            }
          }
        }
        return locationDataInstances;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch location data');
    }
  }
}
