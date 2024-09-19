import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/common/types/category_type.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_state.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> cateogryList = categoryTypeWithIcon.keys.toList();

    return BlocBuilder<TypeCubit, TypeState>(
      builder: (context, TypeState state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cateogryList.length,
              itemBuilder: (context, index) {
                String? category =
                    categoryTypeWithIcon[cateogryList[index]]!['name'];
                IconData? categoryIcon =
                    categoryTypeWithIcon[cateogryList[index]]!['icon'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: BlocBuilder<SpotsCubit, SpotsState>(
                      builder: (context, spotState) {
                        return Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                if (spotState is SpotsLoading) return;
                                if (state is TypeLoaded) {
                                  context.read<TypeCubit>().setType(
                                      state.currentType == cateogryList[index]
                                          ? 0
                                          : cateogryList[index]);
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    categoryIcon,
                                    color: state is TypeLoaded &&
                                            state.currentType ==
                                                cateogryList[index]
                                        ? Colors.black
                                        : Colors.grey[400],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    category!,
                                    style: TextStyle(
                                      color: state is TypeLoaded &&
                                              state.currentType ==
                                                  cateogryList[index]
                                          ? Colors.black
                                          : Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
