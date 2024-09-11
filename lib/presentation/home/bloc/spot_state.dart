import 'package:equatable/equatable.dart';
import 'package:wit_app/data/models/spot.dart';

abstract class SpotState extends Equatable {}

class SpotEmpty extends SpotState {
  @override
  List<Object?> get props => [];
}

class SpotLoading extends SpotState {
  @override
  List<Object?> get props => [];
}

class SpotError extends SpotState {
  final String message;

  SpotError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SpotLoaded extends SpotState {
  final List<Spot> spots;

  SpotLoaded({required this.spots});

  @override
  List<Object?> get props => [spots];
}
