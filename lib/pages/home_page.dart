import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/position/position_bloc.dart';
import 'package:wit_app/bloc/position/position_event.dart';
import 'package:wit_app/models/location.dart';
import 'package:wit_app/servcies/api_service.dart';
import 'package:wit_app/types/category_type.dart';
import 'package:wit_app/components/main_location_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCategory = 15;
  late Future<List<Location>> eventLists;

  String currentLocation = '현위치';

  List<int> cateogryList = categoryType.keys.toList();

  @override
  void initState() {
    super.initState();
    eventLists = ApiService().getEventList(_currentCategory);
  }

  void setCurrentCategory(int category) {
    setState(() {
      _currentCategory = category;
      eventLists = ApiService().getEventList(_currentCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: FutureBuilder(
                future: eventLists,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                child: Text(
                                  'Live Event',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 340,
                          child: makePageView(snapshot),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 400,
            )
          ],
        ),
      ),
    );
  }

  Widget makePageView(AsyncSnapshot<List<Location>> snapshot) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var locationData = snapshot.data![index];
          return Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              LocationList(
                title: locationData.title,
                addr1: locationData.addr1,
                tel: locationData.tel,
                firstimage: locationData.firstimage,
                contentid: locationData.contentid,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
