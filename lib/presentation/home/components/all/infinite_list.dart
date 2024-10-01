import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/option_cubit.dart';
import 'package:wit_app/presentation/home/bloc/option_state.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/components/search/text/text_search_list_item.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({
    super.key,
  });

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SpotsState state = context.read<SpotsCubit>().state;
    List<Spots> displayedSpots = [];

    if (state is SpotsLoaded) {
      displayedSpots = state.spots;
    }

    return Scaffold(
      body: BlocBuilder<SpotsCubit, SpotsState>(
        builder: (context, state) {
          List<Spots> spotList = [];

          if (state is SpotsLoaded) {
            spotList = state.spots;

            final optionState = context.read<OptionCubit>().state;
            // Filter the spotList based on the search query
            if (optionState is OptionLoaded) {
              if (optionState.currentOption.isNotEmpty) {
                displayedSpots = spotList
                    .where((spot) =>
                        spot.cat2.toString() ==
                        optionState.currentOption.toString())
                    .toList();
              } else {
                displayedSpots = spotList;
              }
            }
          }

          return Stack(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: displayedSpots.length,
                  itemBuilder: (context, index) {
                    return TextSearchListItem(spot: displayedSpots[index]);
                  },
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
