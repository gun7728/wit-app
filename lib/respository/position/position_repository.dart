import 'package:geolocator/geolocator.dart';
import 'package:wit_app/models/position.dart' as custom_position;

class PositionRepository {
  Future<custom_position.Position?> setPostion({longitude, latitude}) async {
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
}
