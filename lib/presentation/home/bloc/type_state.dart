import 'package:equatable/equatable.dart';

abstract class TypeState extends Equatable {}

class TypeEmpty extends TypeState {
  @override
  List<Object?> get props => [];
}

class TypeLoading extends TypeState {
  @override
  List<Object?> get props => [];
}

class TypeError extends TypeState {
  final String message;

  TypeError({required this.message});
  @override
  List<Object?> get props => [message];
}

class TypeLoaded extends TypeState {
  final int currentType;

  TypeLoaded({required this.currentType});

  @override
  List<Object?> get props => [currentType];
}
