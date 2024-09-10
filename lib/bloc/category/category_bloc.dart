import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/category/category_event.dart';
import 'package:wit_app/bloc/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(Empty()) {
    on<SetCateogryEvnet>(_onSetCateogryEvnet);
  }

  void _onSetCateogryEvnet(
      SetCateogryEvnet event, Emitter<CategoryState> emit) async {
    emit(Loading());

    try {
      emit(Loaded(currentCategory: event.currentCategory));
    } catch (error) {
      emit(Error(message: '$error'));
    }
  }
}
