import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wit_app/data/models/spot.dart';
import 'package:wit_app/presentation/home/components/all_list_trigger.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';
import 'package:wit_app/presentation/home/components/category.dart';
import 'package:wit_app/presentation/home/components/preview/preview_list.dart';
import 'package:wit_app/presentation/home/components/search_input.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<Spot> showSpot = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final positionBloc = BlocProvider.of<PositionCubit>(context);
      final typeCubit = BlocProvider.of<TypeCubit>(context);

      if (positionBloc.state is PositionEmpty) {
        positionBloc.initPosition();
      }
      if (typeCubit.state is TypeEmpty) {
        typeCubit.setType(15);
      }
    });
  }

  void _updateLocations(BuildContext context) {
    final positionState = context.read<PositionCubit>().state;
    final typeState = context.read<TypeCubit>().state;

    if (positionState is PositionLoaded && typeState is TypeLoaded) {
      if (context.read<SpotCubit>().state is! SpotLoading) {
        context
            .read<SpotCubit>()
            .getSpots(positionState.position, typeState.currentType);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PositionCubit, PositionState>(
          listener: (context, positionState) {
            if (positionState is PositionLoaded) {
              _updateLocations(context);
            }
          },
        ),
        BlocListener<TypeCubit, TypeState>(
          listener: (context, typeState) {
            if (typeState is TypeLoaded) {
              _updateLocations(context);
            }
          },
        ),
      ],
      child: BlocBuilder<PositionCubit, PositionState>(
        builder: (context, positionState) {
          return BlocBuilder<TypeCubit, TypeState>(
            builder: (context, categoryState) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const SearchInput(searchable: false),
                      const SizedBox(height: 20),
                      const MainCategoryList(),
                      const SizedBox(height: 20),
                      const AllListTrigger(),
                      BlocBuilder<SpotCubit, SpotState>(
                        builder: (context, state) {
                          if (state is SpotLoading) {
                            isLoading = true;
                          } else if (state is SpotLoaded) {
                            isLoading = false;
                            showSpot = state.spots;
                          } else if (state is SpotError) {
                            showSpot = [];
                          }
                          return Skeletonizer(
                              enabled: isLoading,
                              child: PreviewList(
                                  spots: showSpot, isLoading: isLoading));
                          // return const Center(child: Text('No data'));
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
