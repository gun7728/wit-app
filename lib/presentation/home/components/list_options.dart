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
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;

        return SizedBox(
          height: screenHeight * 0.22, // 2줄을 위한 높이
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (categoryList.length / 2).ceil(),
            itemBuilder: (context, columnIndex) {
              return SizedBox(
                width: screenWidth * 0.18, // 각 열의 너비
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // 위쪽 정렬
                  children: [
                    _buildCategoryItem(
                        context, state, categoryList, columnIndex * 2),
                    if (columnIndex * 2 + 1 < categoryList.length)
                      _buildCategoryItem(
                          context, state, categoryList, columnIndex * 2 + 1)
                    else
                      const Spacer(), // 홀수 아이템일 경우 하단에 빈 공간 추가
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(BuildContext context, OptionState state,
      List<String> categoryList, int index) {
    if (index >= categoryList.length) return const SizedBox();

    String option = categoryString[categoryList[index]] as String;
    IconData icon = categoryIcon[categoryList[index]] ?? Icons.help;

    return SizedBox(
      height: 70, // 각 아이템의 높이를 고정
      child: BlocBuilder<SpotsCubit, SpotsState>(
        builder: (context, spotState) {
          return GestureDetector(
            onTap: () {
              if (state is OptionLoaded) {
                if (state.currentOption == categoryList[index]) {
                  context.read<OptionCubit>().setOption('');
                } else {
                  context.read<OptionCubit>().setOption(categoryList[index]);
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: state is OptionLoaded &&
                            state.currentOption == categoryList[index]
                        ? Colors.grey[800]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: state is OptionLoaded &&
                            state.currentOption == categoryList[index]
                        ? Colors.white
                        : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  option,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: state is OptionLoaded &&
                            state.currentOption == categoryList[index]
                        ? Colors.black
                        : Colors.grey[500],
                    fontWeight: state is OptionLoaded &&
                            state.currentOption == categoryList[index]
                        ? FontWeight.w800
                        : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
