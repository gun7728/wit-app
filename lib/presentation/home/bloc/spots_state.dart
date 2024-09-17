import 'package:equatable/equatable.dart';
import 'package:wit_app/data/models/spots.dart';

abstract class SpotsState extends Equatable {}

class SpotsEmpty extends SpotsState {
  @override
  List<Object?> get props => [];
}

class SpotsLoading extends SpotsState {
  @override
  List<Object?> get props => [];
}

class SpotsError extends SpotsState {
  final String message;

  SpotsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SpotsLoaded extends SpotsState {
  final List<Spots> spots;

  SpotsLoaded({required this.spots});

  @override
  List<Object?> get props => [spots];
}
