import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wit_app/data/models/position.dart';
import 'package:wit_app/data/models/selected_spot.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_state.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/widget/custom_map_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;
  double _currentZoom = 13.0; // Start with the initial zoom level
  final double _markerVisibilityZoomThreshold =
      16.5; // Set your desired threshold
  SelectedSpot? selectedSpot; // 지역변수로 선택된 스팟 저장

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    var state = context.read<SelectedSpotCubit>().state;

    if (state is SelectedSpotSelect) {
      selectedSpot = state.selectedSpot;
    }
  }

  getCurrentLocation(position) async {
    setState(() {
      mapController.move(
        LatLng(position.latitude, position.longitude),
        15.0,
      );
    });
  }

  List<Marker> getMarkers() {
    List<Marker> markerList = [];
    var spotState = context.read<SpotsCubit>().state;

    if (spotState is SpotsLoaded) {
      for (var spot in spotState.spots) {
        Marker marker = Marker(
          point: LatLng(double.parse(spot.yCoord), double.parse(spot.xCoord)),
          child: GestureDetector(
            onTap: () {
              // 마커 클릭 시 지도의 위치와 줌을 설정
              mapController.move(
                LatLng(double.parse(spot.yCoord), double.parse(spot.xCoord)),
                16.5, // 줌 레벨 설정
              );
            },
            child: _currentZoom >= _markerVisibilityZoomThreshold
                ? CustomMapMarker(
                    spot: spot,
                    onTap: () {
                      mapController.move(
                        LatLng(double.parse(spot.yCoord),
                            double.parse(spot.xCoord)),
                        16.5,
                      );
                    },
                  ) // 줌이 기준 이상일 때 커스텀 마커
                : const Icon(Icons.location_on, color: Colors.blue), // 기본 아이콘
          ),
        );
        markerList.add(marker);
      }
    }

    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PositionCubit, PositionState>(
      listener: (context, PositionState state) {
        if (state is PositionLoaded) {
          getCurrentLocation(state.position);
        }
      },
      builder: (context, positionState) {
        var currentPosition = positionState is PositionLoaded
            ? positionState.position
            : Position(latitude: 37.568477, longitude: 126.981611);

        if (selectedSpot != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            mapController.move(
              LatLng(double.parse(selectedSpot!.yCoord),
                  double.parse(selectedSpot!.xCoord)),
              17, // 줌 레벨 설정
            );
            selectedSpot = null; // 이동 후 selectedSpot을 null로 설정
          });
        }
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  currentPosition.latitude,
                  currentPosition.longitude,
                ),
                initialZoom: 13.0,
                onPositionChanged: (position, bool hasGesture) {
                  setState(() {
                    _currentZoom = position.zoom;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: getMarkers(),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  getCurrentLocation(currentPosition);
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
