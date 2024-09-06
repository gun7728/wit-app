import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:wit_app/servcies/location_service.dart';

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  LocationModel? currentLocation;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  getCurrentLocation() async {
    Position position = await LocationService().getCurrentPosition();
    setState(() {
      currentLocation = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        15.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(
              currentLocation?.latitude ?? 37.568477,
              currentLocation?.longitude ?? 126.981611,
            ),
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                if (currentLocation != null)
                  Marker(
                    point: LatLng(
                      currentLocation!.latitude,
                      currentLocation!.longitude,
                    ),
                    child: const Icon(
                      Icons.home,
                    ),
                  ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              // 버튼 클릭 시 실행할 동작
              getCurrentLocation();
            },
            child: Icon(
              Icons.my_location,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
