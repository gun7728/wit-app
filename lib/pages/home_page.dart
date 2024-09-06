import 'package:flutter/material.dart';
import 'package:wit_app/model/location_model.dart';
import 'package:wit_app/servcies/api_service.dart';
import 'package:wit_app/widget/location_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Future<List<LocationModel>> eventLists =
      ApiService().getDefaultEventList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find things to do',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ),
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
                                  color: Theme.of(context).colorScheme.primary,
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
        ],
      ),
    );
  }

  Widget makePageView(AsyncSnapshot<List<LocationModel>> snapshot) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return SizedBox(
      height: 200, // 높이를 더 줄일 수도 있습니다
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
