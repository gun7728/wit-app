import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/components/all_list_trigger.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
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
  List<Spots> showSpot = [];

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
      if (context.read<SpotsCubit>().state is! SpotsLoading) {
        context
            .read<SpotsCubit>()
            .getSpots(positionState.position, typeState.currentType);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MultiBlocListener(
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
                  return Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const SearchInput(searchable: false),
                        const SizedBox(height: 20),
                        const MainCategoryList(),
                        const SizedBox(height: 20),
                        const AllListTrigger(),
                        const SizedBox(height: 20),
                        BlocBuilder<SpotsCubit, SpotsState>(
                          builder: (context, state) {
                            if (state is SpotsLoading) {
                              isLoading = true;
                            } else if (state is SpotsLoaded) {
                              isLoading = false;
                              showSpot = state.spots;
                            } else if (state is SpotsError) {
                              showSpot = [];
                            }
                            return showSpot.isEmpty
                                ? const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text('No Datas'),
                                    ),
                                  )
                                : Skeletonizer(
                                    enabled: isLoading,
                                    child: PreviewList(
                                        spots: showSpot, isLoading: isLoading));
                            // return const Center(child: Text('No data'));
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Positioned(
            left: 20,
            bottom: 50,
            child: Container(
              width: 20,
              height: 20,
              color: Colors.black,
            ))
      ],
    );
  }
}
