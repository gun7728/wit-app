import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {}

class Position {
  final double latitude;
  final double longitude;

  Position({required this.latitude, required this.longitude});
}

class ListLocationsEvent extends LocationEvent {
  final Position position;
  final String type;

  ListLocationsEvent(
      {required this.position, required this.type}); // named parameters로 수정

  @override
  List<Object?> get props => [position, type];
}
