import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/position.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/infinite_spot_state.dart';

class InfiniteSpotCubit extends Cubit<InfiniteSpotState> {
  final SpotRepository spotRepository;

  InfiniteSpotCubit({required this.spotRepository})
      : super(InfiniteSpotEmpty());

  void getSpots(Position position, int? type, int page) async {
    if (state is InfiniteSpotLoading) return;

    var beforeSpot = [];

    if (state is InfiniteSpotLoaded) {
      beforeSpot = (state as InfiniteSpotLoaded).spots;
    }
    emit(InfiniteSpotLoading());
    try {
      // locationRepository에서 위치 데이터를 가져옴
      final result = await spotRepository.getInfiniteSpotList(
        position: position,
        type: type,
        page: page,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(InfiniteSpotLoaded(
          spots: result['data'],
          totalCount: result['totalCount'])); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(InfiniteSpotError(message: "Failed to load locations: $error"));
    }
  }
}
