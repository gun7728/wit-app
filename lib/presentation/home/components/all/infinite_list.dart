import 'package:flutter/material.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({
    super.key,
  });

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  String searchWord = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
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
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchWord = '';
              });
            },
          )
        ],
      ),
    );
  }
}
