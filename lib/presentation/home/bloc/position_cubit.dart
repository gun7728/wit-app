import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/position.dart';
import 'package:wit_app/data/respository/position/position_repository.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';

class PositionCubit extends Cubit<PositionState> {
  final PositionRepository positionRepository;

  PositionCubit({required this.positionRepository}) : super(PositionEmpty());

  void setPosition(double longitude, double latitude) {
    final position = Position(longitude: longitude, latitude: latitude);
    emit(PositionLoaded(position: position));
  }

  Future<void> getPosition() async {
    try {
      emit(PositionLoading());
      final position = await positionRepository.getPostion();
      final positionKor = await positionRepository.getPostionKor();

      if (position != null) {
        emit(PositionLoaded(position: position, positionKor: positionKor));
      } else {
        emit(PositionError(message: "Failed to retrieve position."));
      }
    } catch (e) {
      emit(PositionError(message: "Failed to get position: ${e.toString()}"));
    }
  }

  void initPosition() {
    emit(PositionLoaded(
        position: Position(longitude: 126.9648, latitude: 37.5299)));
  }
}
