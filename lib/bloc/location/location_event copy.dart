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
