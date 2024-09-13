import 'package:equatable/equatable.dart';
import 'package:wit_app/data/models/spot.dart';

abstract class InfiniteSpotState extends Equatable {}

class InfiniteSpotEmpty extends InfiniteSpotState {
  @override
  List<Object?> get props => [];
}

class InfiniteSpotLoading extends InfiniteSpotState {
  @override
  List<Object?> get props => [];
}

class InfiniteSpotError extends InfiniteSpotState {
  final String message;

  InfiniteSpotError({required this.message});

  @override
  List<Object?> get props => [message];
}

class InfiniteSpotLoaded extends InfiniteSpotState {
  final List<Spot> spots;
  final int totalCount;

  InfiniteSpotLoaded({required this.totalCount, required this.spots});

  @override
  List<Object?> get props => [spots, totalCount];
}
