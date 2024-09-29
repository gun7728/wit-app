import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/selected_spot.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_state.dart';

class SelectedSpotCubit extends Cubit<SelectedSpotState> {
  SelectedSpotCubit() : super(SelectedSpotEmpty());

  void setSelectedSpot(Spots spot) async {
    emit(SelectedSpotLoading());
    emit(
        SelectedSpotSelect(selectedSpot: SelectedSpot.fromJson(spot.toJson())));
  }
}
