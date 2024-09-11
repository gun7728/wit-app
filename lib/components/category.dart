import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_state.dart';
import 'package:wit_app/common/types/category_type.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> cateogryList = categoryType.keys.toList();

    return BlocBuilder<TypeCubit, TypeState>(
      builder: (context, TypeState state) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cateogryList.length,
            itemBuilder: (context, index) {
              String? category = categoryType[cateogryList[index]];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BlocBuilder<SpotCubit, SpotState>(
                    builder: (context, spotState) {
                      return TextButton(
                        onPressed: () {
                          if (spotState is SpotLoading) return;
                          if (state is TypeLoaded) {
                            context.read<TypeCubit>().setType(
                                state.currentType == cateogryList[index]
                                    ? 0
                                    : cateogryList[index]);
                          }
                        },
                        child: Text(
                          '$category',
                          style: TextStyle(
                            color: state is TypeLoaded &&
                                    state.currentType == cateogryList[index]
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
