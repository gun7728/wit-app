import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';

class SpotCubit extends Cubit<SpotState> {
  final SpotRepository spotRepository;

  SpotCubit({required this.spotRepository}) : super(SpotEmpty());

  void getSpotDetail(String contentId, String type) async {
    emit(SpotLoading());
    try {
      // locationRepository에서 위치 데이터를 가져옴
      final spotDetail = await spotRepository.getSpotDetail(
        contentId: contentId,
        type: type,
      );

      // 데이터를 성공적으로 가져왔을 때의 상태
      emit(SpotLoaded(spot: spotDetail)); // locations 데이터 전달
    } catch (error) {
      // 에러가 발생했을 때의 상태
      emit(SpotError(message: "Failed to load locations: $error"));
    }
  }
}
