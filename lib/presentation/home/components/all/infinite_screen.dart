import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wit_app/data/models/spot.dart';
import 'package:wit_app/presentation/home/bloc/infinite_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/infinite_spot_state.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_state.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_state.dart';
import 'package:wit_app/presentation/home/components/all/infinite_list_item.dart';
import 'package:wit_app/presentation/home/components/all/bottom_loader.dart';
import 'package:wit_app/presentation/home/components/all/infinite_list_item.dart';

class InfiniteScreen extends StatefulWidget {
  const InfiniteScreen({
    super.key,
  });

  @override
  State<InfiniteScreen> createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen> {
  final scrollController = ScrollController();
  List<Spot> showList = [];

  late InfiniteSpotCubit infiniteSpotCubit;
  late PositionCubit positionCubit;
  late TypeCubit typeCubit;
  int page = 1;
  int totalCount = 0;
  bool isLoading = false;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (!scrollController.hasClients) return;
    if (totalCount == showList.length) return;
    if (infiniteSpotCubit.state is InfiniteSpotLoading) return;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      if (typeCubit.state is TypeLoaded &&
          positionCubit.state is PositionLoaded &&
          infiniteSpotCubit.state is InfiniteSpotLoaded) {
        page++;
        infiniteSpotCubit.getSpots(
            (positionCubit.state as PositionLoaded).position,
            (typeCubit.state as TypeLoaded).currentType,
            page);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    infiniteSpotCubit = BlocProvider.of<InfiniteSpotCubit>(context);
    positionCubit = BlocProvider.of<PositionCubit>(context);
    typeCubit = BlocProvider.of<TypeCubit>(context);

    if (typeCubit.state is TypeLoaded &&
        positionCubit.state is PositionLoaded) {
      infiniteSpotCubit.getSpots(
          (positionCubit.state as PositionLoaded).position,
          (typeCubit.state as TypeLoaded).currentType,
          page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text("View all"),
      ),
      body: BlocBuilder<InfiniteSpotCubit, InfiniteSpotState>(
        builder: (context, InfiniteSpotState state) {
          if (state is InfiniteSpotLoading) {
            isLoading = true;
          } else if (state is InfiniteSpotError) {
            return const Center(
              child: Text('failed to fetch posts'),
            );
          } else if (state is InfiniteSpotLoaded) {
            if (state.spots.isEmpty) {
              return const Center(
                child: Text('no posts'),
              );
            }
            isLoading = false;
            totalCount = state.totalCount;
            showList = [...showList, ...state.spots];
          }
          return ListView.builder(
            itemCount: showList.length + 1,
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= showList.length) {
                return showList.length == totalCount
                    ? const SizedBox.shrink()
                    : const BottomLoader();
              } else {
                return Skeletonizer(
                  enabled: isLoading,
                  child: InfiniteListItem(spot: showList[index]),
                );
              }
            },
          );
        },
      ),
    );
  }
}
