import 'package:bloc/bloc.dart';
import 'package:wit_app/bloc/location/location_event.dart';
import 'package:wit_app/bloc/location/location_state.dart';
import 'package:wit_app/respository/location/location_repository.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc({
    required this.locationRepository,
  }) : super(Empty()) {
    on<ListLocationsEvent>(_onListLocationsEvent);
    on<AllListLocationEvent>(_onAllListLocationEvent);
  }

  void _onListLocationsEvent(
      ListLocationsEvent event, Emitter<LocationState> emit) async {
    // 로딩 상태를 emit
    emit(Loading());

    try {
      // locationRepository에서 위치 데이터를 가져옴
      final locations = await locationRepository.listLocations(
        position: event.position,
        type: event.type,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(Loaded(locations: locations)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(Error(message: "Failed to load locations: $error"));
    }
  }

  void _onAllListLocationEvent(
      AllListLocationEvent event, Emitter<LocationState> emit) async {
    // 로딩 상태를 emit
    emit(Loading());

    try {
      // locationRepository에서 위치 데이터를 가져옴
      final locations = await locationRepository.listLocations(
        position: event.position,
        type: event.type,
        page: event.page,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(Loaded(locations: locations)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(Error(message: "Failed to load locations: $error"));
    }
  }
}
