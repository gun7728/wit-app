import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/position/position_event.dart';
import 'package:wit_app/bloc/position/position_state.dart';
import 'package:wit_app/models/position.dart';
import 'package:wit_app/respository/position/position_repository.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final PositionRepository positionRepository;

  PositionBloc({required this.positionRepository}) : super(Empty()) {
    on<SetPositionEvent>(_onSetPosition);
    on<GetPositionEvent>(_onGetPosition);
    on<InitPositionEvent>(_onInitPosition);
  }

  void _onSetPosition(SetPositionEvent event, Emitter<PositionState> emit) {
    final position =
        Position(longitude: event.longitude, latitude: event.latitude);
    emit(Loaded(position: position));
  }

  Future<void> _onGetPosition(
      GetPositionEvent event, Emitter<PositionState> emit) async {
    try {
      emit(Loading());
      final position = await positionRepository.getPostion();
      final positionKor = await positionRepository.getPostionKor();

      if (position != null) {
        emit(Loaded(position: position, positionKor: positionKor));
      } else {
        emit(Error(message: "Failed to retrieve position."));
      }
    } catch (e) {
      emit(Error(message: "Failed to get position: ${e.toString()}"));
    }
  }

  void _onInitPosition(InitPositionEvent event, Emitter<PositionState> emit) {
    emit(Loaded(position: Position(longitude: 126.9648, latitude: 37.5299)));
  }
}
