import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
}
