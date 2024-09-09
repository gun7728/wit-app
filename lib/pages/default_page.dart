import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/location/location_bloc.dart' as location_bloc;
import 'package:wit_app/bloc/location/location_event.dart';
import 'package:wit_app/bloc/position/position_bloc.dart' as position_bloc;
import 'package:wit_app/bloc/location/location_state.dart' as location_state;
import 'package:wit_app/bloc/position/position_event.dart';
import 'package:wit_app/bloc/position/position_state.dart' as position_state;
import 'package:wit_app/components/main_category_list.dart';
import 'package:wit_app/components/main_location_live_event_list.dart';
import 'package:wit_app/components/main_search_bar.dart';
import 'package:wit_app/components/main_location_list.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  void initState() {
    super.initState();

    final positionBloc = BlocProvider.of<position_bloc.PositionBloc>(context);
    final currentState = positionBloc.state;

    if (currentState is position_state.Empty) {
      positionBloc.add(InitPositionEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<position_bloc.PositionBloc,
        position_state.PositionState>(
      listener: (context, positionState) {
        if (positionState is position_state.Loaded) {
          final position = positionState.position;
          context.read<location_bloc.LocationBloc>().add(
                ListLocationsEvent(
                  position: position,
                  type: 15,
                ),
              );
        }
      },
      builder: (context, positionState) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const MainSearchBar(),
                const SizedBox(height: 20),
                const MainCategoryList(),
                BlocBuilder<location_bloc.LocationBloc,
                    location_state.LocationState>(
                  builder: (context, locationState) {
                    if (locationState is location_state.Loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (locationState is location_state.Loaded) {
                      return MainLocationLiveEventList(
                          locations: locationState.locations);
                    } else if (locationState is location_state.Error) {
                      return Center(child: Text(locationState.message));
                    }
                    return const Center(child: Text('No data'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
