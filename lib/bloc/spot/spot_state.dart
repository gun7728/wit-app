import 'package:equatable/equatable.dart';
import 'package:wit_app/models/spot.dart';

abstract class SpotState extends Equatable {}

class Empty extends SpotState {
  @override
  List<Object?> get props => [];
}

class Loading extends SpotState {
  @override
  List<Object?> get props => [];
}

class Error extends SpotState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loaded extends SpotState {
  final List<Spot> spots;

  Loaded({required this.spots});

  @override
  List<Object?> get props => [spots];
}
