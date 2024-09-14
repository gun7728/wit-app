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

class InfiniteList extends StatefulWidget {
  const InfiniteList({
    super.key,
  });

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final scrollController = ScrollController();
  List<Spot> showList = [];

  late InfiniteSpotCubit infiniteSpotCubit;
  late PositionCubit positionCubit;
  late TypeCubit typeCubit;
  int page = 1;
  int totalCount = 0;
  bool isLoading = false;
  bool newDataLoaded = false;
  bool isSearching = false;

  String searchWord = '';

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
        automaticallyImplyLeading:
            !isSearching, // isSearching이 true일 때 기본 뒤로가기 버튼 숨기기
        leading: isSearching
            ? null // isSearching이 true면 leading을 숨김
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: isSearching
            ? SizedBox(
                height: 40,
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Search Spot',
                      hintStyle: const TextStyle(color: Colors.black)),
                  // controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchWord = value;
                    });
                  },
                ),
              )
            : const Text("View all"),
        actions: [
          IconButton(
            icon: isSearching
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  isSearching = false;
                  searchWord = '';
                } else {
                  isSearching = true;
                }
              });
            },
          )
        ],
      ),
      body: BlocBuilder<InfiniteSpotCubit, InfiniteSpotState>(
        builder: (context, InfiniteSpotState state) {
          if (state is InfiniteSpotLoading) {
            isLoading = true;
            newDataLoaded = true;
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
            if (newDataLoaded) {
              totalCount = state.totalCount;
              showList = [...showList, ...state.spots];
              newDataLoaded = false;
            }
          }
          final filteredList = showList
              .where((spot) =>
                  spot.title.toUpperCase().contains(searchWord.toUpperCase()))
              .toList();
          final filteredLength = filteredList.length;

          return ListView.builder(
            itemCount: filteredLength + 1,
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= filteredLength) {
                return filteredLength == totalCount
                    ? const SizedBox.shrink()
                    : (isSearching
                        ? const SizedBox.shrink()
                        : const BottomLoader());
              } else {
                return Skeletonizer(
                  enabled: isLoading,
                  child: InfiniteListItem(spot: filteredList[index]),
                );
              }
            },
          );
        },
      ),
    );
  }
}
