import 'package:equatable/equatable.dart';

abstract class PositionEvent extends Equatable {}

class SetPositionEvent extends PositionEvent {
  final double longitude;
  final double latitude;

  SetPositionEvent({
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object?> get props => [longitude, latitude];
}

class GetPositionEvent extends PositionEvent {
  @override
  List<Object?> get props => [];
}

class EmptyPositionEvent extends PositionEvent {
  @override
  List<Object?> get props => [];
}

class InitPositionEvent extends PositionEvent {
  @override
  List<Object?> get props => [];
}
