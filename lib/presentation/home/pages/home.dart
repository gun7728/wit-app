import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/option_cubit.dart';
import 'package:wit_app/presentation/home/bloc/option_state.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/components/all_list_trigger.dart';
import 'package:wit_app/presentation/home/components/list_options.dart';
import 'package:wit_app/presentation/home/components/preview/preview_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Spots> originSpotList = [];
  List<Spots> optionSpotList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Column(
            children: [
              SizedBox(height: 20),
              ListOptions(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: AllListTrigger(),
              ),
              SizedBox(height: 20),
            ],
          ),
          BlocBuilder<SpotsCubit, SpotsState>(
            builder: (context, SpotsState state) {
              if (state is SpotsLoaded) {
                originSpotList = state.spots;
              }

              return BlocBuilder<OptionCubit, OptionState>(
                  builder: (context, OptionState state) {
                if (state is OptionLoaded) {
                  if (state.currentOption.isNotEmpty) {
                    optionSpotList = originSpotList
                        .where((spot) =>
                            spot.cat2.toString() ==
                            state.currentOption.toString())
                        .toList();
                  } else {
                    optionSpotList = originSpotList;
                  }
                }
                return optionSpotList.isEmpty
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('No Datas'),
                        ),
                      )
                    : PreviewList(
                        spots: optionSpotList.length >= 5
                            ? optionSpotList.sublist(0, 5)
                            : optionSpotList);
              });
            },
          ),
        ],
      ),
    );
  }
}
