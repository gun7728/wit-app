import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';
import 'package:wit_app/components/category.dart';
import 'package:wit_app/components/home/search_bar.dart';

class MainAllLocationList extends StatelessWidget {
  const MainAllLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const MainSearchBar(),
          const SizedBox(
            height: 20,
          ),
          const MainCategoryList(),
          BlocBuilder<SpotCubit, SpotState>(
            builder: (context, SpotState state) {
              if (state is SpotLoaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.spots.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(state.spots[index].title),
                          const SizedBox(
                            height: 200,
                          )
                        ],
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
