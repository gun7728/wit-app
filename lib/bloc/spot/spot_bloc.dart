import 'package:bloc/bloc.dart';
import 'package:wit_app/bloc/spot/spot_event.dart';
import 'package:wit_app/bloc/spot/spot_state.dart';
import 'package:wit_app/respository/spot/spot_repository.dart';

class SpotBloc extends Bloc<SpotEvent, SpotState> {
  final SpotRepository spotRepository;

  SpotBloc({
    required this.spotRepository,
  }) : super(Empty()) {
    on<GetSpotList>(_onGetSpotList);
    on<GetAllSpotList>(_onGetAllSpotListt);
  }

  void _onGetSpotList(GetSpotList event, Emitter<SpotState> emit) async {
    // 로딩 상태를 emit
    emit(Loading());

    try {
      // locationRepository에서 위치 데이터를 가져옴
      final spots = await spotRepository.getSpotList(
        position: event.position,
        type: event.type,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(Loaded(spots: spots)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(Error(message: "Failed to load locations: $error"));
    }
  }

  void _onGetAllSpotListt(GetAllSpotList event, Emitter<SpotState> emit) async {
    // 로딩 상태를 emit
    emit(Loading());

    try {
      // locationRepository에서 위치 데이터를 가져옴
      final spots = await spotRepository.getSpotList(
        position: event.position,
        type: event.type,
        page: event.page,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(Loaded(spots: spots)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(Error(message: "Failed to load locations: $error"));
    }
  }
}
