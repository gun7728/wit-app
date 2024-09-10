import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wit_app/bloc/position/position_bloc.dart';
import 'package:wit_app/bloc/position/position_state.dart';
import 'package:wit_app/models/position.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  getCurrentLocation(position) async {
    // Position position = await LocationService().getCurrentPosition();
    setState(() {
      mapController.move(
        LatLng(position.latitude, position.longitude),
        15.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PositionBloc, PositionState>(
      listener: (context, state) {
        if (state is Loaded) {
          getCurrentLocation(state.position);
        }
      },
      builder: (context, state) {
        var currentPositon = state is Loaded
            ? state.position
            : Position(latitude: 37.568477, longitude: 126.981611);
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentPositon.latitude,
                  currentPositon.longitude,
                ),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        currentPositon.latitude,
                        currentPositon.longitude,
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
                  getCurrentLocation(currentPositon);
                },
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
