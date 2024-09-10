import 'package:equatable/equatable.dart';
import 'package:wit_app/models/position.dart';

abstract class SpotEvent extends Equatable {}

class GetSpotList extends SpotEvent {
  final Position position;
  final int type;

  GetSpotList({
    required this.position,
    required this.type,
  });

  @override
  List<Object?> get props => [position, type];
}

class GetAllSpotList extends SpotEvent {
  final Position position;
  final int type;
  final int page;

  GetAllSpotList(
      {required this.position, required this.type, required this.page});

  @override
  List<Object?> get props => [position, type, page];
}
