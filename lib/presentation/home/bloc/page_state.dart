import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {}

class PageLoading extends PageState {
  @override
  List<Object?> get props => [];
}

class PageLoaded extends PageState {
  final int currentPage;

  PageLoaded({required this.currentPage});

  @override
  List<Object?> get props => [currentPage];
}
