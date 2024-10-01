import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/components/all/infinite_list_item.dart';
import 'package:wit_app/presentation/home/components/detail/spot_detail.dart';

class TextSearchList extends StatefulWidget {
  final Function(int)? setCurrentIndex;
  const TextSearchList({super.key, this.setCurrentIndex});

  @override
  _TextSearchListState createState() => _TextSearchListState();
}

class _TextSearchListState extends State<TextSearchList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  List<Spots> _displayedSpots = [];
  int _currentMax = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoading) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    setState(() {
      _isLoading = true;
    });

    // Delay added to simulate fetching new data (remove for real-time data)
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _currentMax += 10;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                height: 45,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<SpotsCubit, SpotsState>(
        builder: (context, state) {
          List<Spots> spotList = [];

          if (state is SpotsLoaded) {
            spotList = state.spots;

            if (_searchQuery.isNotEmpty) {
              spotList = spotList
                  .where((spot) => spot.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  .toList();
            }

            // Load only a subset of spots based on _currentMax for pagination
            _displayedSpots = spotList.take(_currentMax).toList();
          }

          return Column(
            children: [
              Expanded(
                child: _displayedSpots.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _displayedSpots.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contextLoginScreen) {
                                  return MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: BlocProvider.of<PageCubit>(
                                              context),
                                        ),
                                        BlocProvider.value(
                                          value: BlocProvider.of<
                                              SelectedSpotCubit>(context),
                                        ),
                                      ],
                                      child: SpotDetail(
                                          spot: _displayedSpots[index]));
                                }),
                              );
                            },
                            child: MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<SelectedSpotCubit>(
                                        context),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<PageCubit>(context),
                                  ),
                                ],
                                child: InfiniteListItem(
                                    spot: _displayedSpots[index])),
                          );
                        },
                      ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
