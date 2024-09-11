import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spot.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';
import 'package:wit_app/presentation/home/components/all/all_list_item.dart';
import 'package:wit_app/presentation/home/components/category.dart';

class AllList extends StatefulWidget {
  const AllList({super.key});

  @override
  _AllListState createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  bool _isSearching = false;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: _isSearching
            ? TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
                autofocus: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              )
            : const Text(
                'View all',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching)
                  _searchQuery = ''; // Clear search when exiting search mode
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              size: 35,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const MainCategoryList(),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<SpotCubit, SpotState>(
            builder: (context, SpotState state) {
              if (state is SpotLoaded) {
                // Filter the list based on the search query
                final filteredSpots = state.spots.where((spot) {
                  return spot.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                return AllListItem(filteredSpots: filteredSpots);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
