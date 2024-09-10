import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class SetCateogryEvnet extends CategoryEvent {
  final int currentCategory;

  SetCateogryEvnet({
    required this.currentCategory,
  });

  @override
  List<Object?> get props => [currentCategory];
}
