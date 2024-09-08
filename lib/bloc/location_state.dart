import 'package:equatable/equatable.dart';
import 'package:wit_app/models/location.dart';

abstract class LocationState extends Equatable {}

class Empty extends LocationState {
  @override
  List<Object?> get props => [];
}

class Loading extends LocationState {
  @override
  List<Object?> get props => [];
}

class Error extends LocationState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loaded extends LocationState {
  final List<Location> locations;

  Loaded({required this.locations});

  @override
  List<Object?> get props => [locations];
}
