import 'package:equatable/equatable.dart';
import 'package:wit_app/data/models/selected_spot.dart';

abstract class SelectedSpotState extends Equatable {}

class SelectedSpotEmpty extends SelectedSpotState {
  @override
  List<Object?> get props => [];
}

class SelectedSpotLoading extends SelectedSpotState {
  @override
  List<Object?> get props => [];
}

class SelectedSpotSelect extends SelectedSpotState {
  final SelectedSpot selectedSpot;

  SelectedSpotSelect({required this.selectedSpot});

  @override
  List<Object?> get props => [selectedSpot];
}
