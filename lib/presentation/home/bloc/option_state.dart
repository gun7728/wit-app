import 'package:equatable/equatable.dart';

abstract class OptionState extends Equatable {}

class OptionEmpty extends OptionState {
  @override
  List<Object?> get props => [];
}

class OptionLoading extends OptionState {
  @override
  List<Object?> get props => [];
}

class OptionError extends OptionState {
  final String message;

  OptionError({required this.message});
  @override
  List<Object?> get props => [message];
}

class OptionLoaded extends OptionState {
  final String currentOption;

  OptionLoaded({required this.currentOption});

  @override
  List<Object?> get props => [currentOption];
}
