import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/position.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';

class SpotsCubit extends Cubit<SpotsState> {
  final SpotRepository spotRepository;

  SpotsCubit({required this.spotRepository}) : super(SpotsEmpty());

  void getSpots(Position position, int? type, [int? page]) async {
    emit(SpotsLoading());
    try {
      // locationRepository에서 위치 데이터를 가져옴
      final spots = await spotRepository.getSpotList(
        position: position,
        type: type,
        page: page,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(SpotsLoaded(spots: spots)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(SpotsError(message: "Failed to load locations: $error"));
    }
  }

  void getAllSpots({String option = 'R'}) async {
    emit(SpotsLoading());
    try {
      // locationRepository에서 위치 데이터를 가져옴
      final spots = await spotRepository.getAllSpotList(option);

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(SpotsLoaded(spots: spots)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(SpotsError(message: "Failed to load locations: $error"));
    }
  }
}
