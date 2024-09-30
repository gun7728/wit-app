import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/common/options/list_options.dart';
import 'package:wit_app/presentation/home/bloc/option_cubit.dart';
import 'package:wit_app/presentation/home/bloc/option_state.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';

class ListOptions extends StatelessWidget {
  const ListOptions({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = categoryString.keys.toList();

    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, OptionState state) {
        double screenWidth = MediaQuery.of(context).size.width;

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              String option = categoryString[categoryList[index]] as String;
              return BlocBuilder<SpotsCubit, SpotsState>(
                builder: (context, spotState) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: screenWidth * 0.2,
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: state is OptionLoaded &&
                                      state.currentOption == categoryList[index]
                                  ? Colors.black // 배경색
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 테두리 둥글게
                              ),
                              overlayColor: Colors.black),
                          onPressed: () {
                            if (state is OptionLoaded) {
                              if (state.currentOption == categoryList[index]) {
                                context.read<OptionCubit>().setOption('');
                              } else {
                                context
                                    .read<OptionCubit>()
                                    .setOption(categoryList[index]);
                              }
                            }
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            option,
                            style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: state is OptionLoaded &&
                                        state.currentOption ==
                                            categoryList[index]
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
