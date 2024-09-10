import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {}

class Empty extends CategoryState {
  @override
  List<Object?> get props => [];
}

class Loading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class Error extends CategoryState {
  final String message;

  Error({required this.message});
  @override
  List<Object?> get props => [message];
}

class Loaded extends CategoryState {
  final int currentCategory;

  Loaded({required this.currentCategory});

  @override
  List<Object?> get props => [currentCategory];
}
