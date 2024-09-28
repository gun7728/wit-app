import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/option_state.dart';

class OptionCubit extends Cubit<OptionState> {
  OptionCubit() : super(OptionLoaded(currentOption: ''));

  void setOption(String currentOption) async {
    emit(OptionLoading());
    try {
      emit(OptionLoaded(currentOption: currentOption));
    } catch (error) {
      emit(OptionError(message: '$error'));
    }
  }
}
