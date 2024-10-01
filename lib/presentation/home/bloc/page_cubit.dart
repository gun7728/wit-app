// index_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageLoaded(currentPage: 0));

  void setPage(int index) {
    emit(PageLoading());
    emit(PageLoaded(currentPage: index));
  }
}
