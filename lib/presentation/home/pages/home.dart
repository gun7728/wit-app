import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // SearchInput(searchable: false),
                SizedBox(height: 20),
                ListOptions(),
                SizedBox(height: 20),
                AllListTrigger(),
                SizedBox(height: 20),
              ],
            ),
          ),
          BlocBuilder<SpotsCubit, SpotsState>(
            builder: (context, state) {
              if (state is SpotsLoaded) {
                return state.spots.isEmpty
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('No Datas'),
                        ),
                      )
                    : PreviewList(spots: state.spots.sublist(0, 5));
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
