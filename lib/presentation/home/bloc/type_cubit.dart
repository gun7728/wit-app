import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/type_state.dart';

class TypeCubit extends Cubit<TypeState> {
  TypeCubit() : super(TypeEmpty());

  void setType(int currentType) async {
    emit(TypeLoading());
    try {
      emit(TypeLoaded(currentType: currentType));
    } catch (error) {
      emit(TypeError(message: '$error'));
    }
  }
}
