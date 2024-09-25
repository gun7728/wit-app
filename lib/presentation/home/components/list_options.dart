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
    List<String> optionList = listOptions.keys.toList();

    return BlocBuilder<OptionCubit, OptionState>(
      builder: (context, OptionState state) {
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: optionList.length,
            itemBuilder: (context, index) {
              String option = listOptions[optionList[index]] as String;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: BlocBuilder<SpotsCubit, SpotsState>(
                  builder: (context, spotState) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: state is OptionLoaded &&
                                        state.currentOption == optionList[index]
                                    ? Colors.black // 배경색
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // 테두리 둥글게
                                ),
                                overlayColor: Colors.black),
                            onPressed: () {
                              if (state is! OptionLoading) {
                                context
                                    .read<OptionCubit>()
                                    .setOption(optionList[index]);
                              }
                            },
                            child: Text(
                              textAlign: TextAlign.center,
                              option,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: state is OptionLoaded &&
                                          state.currentOption ==
                                              optionList[index]
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  },
                ),
              );
              return null;
            },
          ),
        );
      },
    );
  }
}
