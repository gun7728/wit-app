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
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          children: [
            // 전체 내용을 담는 Column
            Column(
              children: [
                const Column(
                  children: [
                    SizedBox(height: 10),
                    ListOptions(),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: AllListTrigger(),
                    ),
                    SizedBox(height: 10),
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
                              height: 120,
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
            // 배너 추가
            Positioned(
              bottom: 10, // 리스트와 내비게이션 바 사이에 위치하도록 조정
              left: 0,
              right: 0,
              child: Container(
                height: 60, // 배너의 높이 설정
                decoration: const BoxDecoration(
                  color: Color(0xFF106DF4),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Text(
                        '이미지 검색을 시도해보세요!',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
