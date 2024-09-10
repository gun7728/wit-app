import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/category/category_bloc.dart' as category_bloc;
import 'package:wit_app/bloc/category/category_event.dart';
import 'package:wit_app/bloc/category/category_state.dart' as category_state;
import 'package:wit_app/bloc/position/position_bloc.dart' as position_bloc;
import 'package:wit_app/bloc/position/position_event.dart';
import 'package:wit_app/bloc/position/position_state.dart' as position_state;
import 'package:wit_app/bloc/spot/spot_bloc.dart' as spot_bloc;
import 'package:wit_app/bloc/spot/spot_event.dart';
import 'package:wit_app/bloc/spot/spot_state.dart' as spot_state;
import 'package:wit_app/components/category.dart';
import 'package:wit_app/components/home/preview/preview_list.dart';
import 'package:wit_app/components/home/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final positionBloc = BlocProvider.of<position_bloc.PositionBloc>(context);
    if (positionBloc.state is position_state.Empty) {
      positionBloc.add(InitPositionEvent());
    }
    final categoryBloc = BlocProvider.of<category_bloc.CategoryBloc>(context);
    if (categoryBloc.state is category_state.Empty) {
      categoryBloc.add(SetCateogryEvnet(currentCategory: 15));
    }
  }

  void _updateLocations(BuildContext context) {
    final positionState = context.read<position_bloc.PositionBloc>().state;
    final categoryState = context.read<category_bloc.CategoryBloc>().state;

    if (positionState is position_state.Loaded &&
        categoryState is category_state.Loaded) {
      context.read<spot_bloc.SpotBloc>().add(
            GetSpotList(
              position: positionState.position,
              type: categoryState.currentCategory,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<position_bloc.PositionBloc, position_state.PositionState>(
          listener: (context, positionState) {
            if (positionState is position_state.Loaded) {
              _updateLocations(context);
            }
          },
        ),
        BlocListener<category_bloc.CategoryBloc, category_state.CategoryState>(
          listener: (context, categoryState) {
            if (categoryState is category_state.Loaded) {
              _updateLocations(context);
            }
          },
        ),
      ],
      child:
          BlocBuilder<position_bloc.PositionBloc, position_state.PositionState>(
        builder: (context, positionState) {
          return BlocBuilder<category_bloc.CategoryBloc,
              category_state.CategoryState>(
            builder: (context, categoryState) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const MainSearchBar(),
                      const SizedBox(height: 20),
                      const MainCategoryList(),
                      BlocBuilder<spot_bloc.SpotBloc, spot_state.SpotState>(
                        builder: (context, locationState) {
                          if (locationState is spot_state.Loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (locationState is spot_state.Loaded) {
                            return PreviewList(spots: locationState.spots);
                          } else if (locationState is spot_state.Error) {
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
        },
      ),
    );
  }
}
