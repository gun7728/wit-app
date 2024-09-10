import 'package:equatable/equatable.dart';
import 'package:wit_app/models/position.dart';

abstract class LocationEvent extends Equatable {}

class ListLocationsEvent extends LocationEvent {
  final Position position;
  final int type;

  ListLocationsEvent({
    required this.position,
    required this.type,
  });

  @override
  List<Object?> get props => [position, type];
}

class AllListLocationEvent extends LocationEvent {
  final Position position;
  final int type;
  final int page;

  AllListLocationEvent(
      {required this.position, required this.type, required this.page});

  @override
  List<Object?> get props => [position, type, page];
}
