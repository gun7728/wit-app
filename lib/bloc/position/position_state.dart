import 'package:equatable/equatable.dart';
import 'package:wit_app/models/position.dart';

abstract class PositionState extends Equatable {}

class Empty extends PositionState {
  @override
  List<Object?> get props => [];
}

class Loading extends PositionState {
  @override
  List<Object?> get props => [];
}

class Error extends PositionState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loaded extends PositionState {
  final Position position;

  Loaded({required this.position});

  @override
  List<Object?> get props => [position];
}
