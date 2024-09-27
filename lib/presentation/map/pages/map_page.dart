import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';
import 'package:wit_app/data/models/position.dart';

class MapPage extends StatefulWidget {
  final Spots? spot;
  const MapPage({super.key, this.spot});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late KakaoMapController mapController;
  Set<Marker> markers = {}; // 마커 변수

  @override
  void initState() {
    super.initState();
  }

  getCurrentLocation(position) async {
    context.read<PositionCubit>().getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PositionCubit, PositionState>(
      listener: (context, state) {
        if (state is PositionLoaded) {
          mapController.setCenter(
              LatLng(state.position.latitude, state.position.longitude));
        }
      },
      builder: (context, state) {
        var currentPositon = state is PositionLoaded
            ? state.position
            : Position(latitude: 37.568477, longitude: 126.981611);
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            KakaoMap(
              onMapCreated: ((controller) async {
                mapController = controller;

                markers.add(Marker(
                  markerId: UniqueKey().toString(),
                  latLng: await mapController.getCenter(),
                ));

                setState(() {});
              }),
              markers: markers.toList(),
              center: LatLng(37.3608681, 126.9306506),
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
