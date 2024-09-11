import 'package:equatable/equatable.dart';
import 'package:wit_app/data/models/position.dart';

abstract class PositionState extends Equatable {}

class PositionEmpty extends PositionState {
  @override
  List<Object?> get props => [];
}

class PositionLoading extends PositionState {
  @override
  List<Object?> get props => [];
}

class PositionError extends PositionState {
  final String message;

  PositionError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PositionLoaded extends PositionState {
  final Position position;
  final String? positionKor;

  PositionLoaded({required this.position, this.positionKor});

  @override
  List<Object?> get props => [position, positionKor];
}
