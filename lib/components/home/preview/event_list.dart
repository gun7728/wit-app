import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/category/category_bloc.dart';
import 'package:wit_app/bloc/position/position_bloc.dart';
import 'package:wit_app/components/home/all_event_list.dart';
import 'package:wit_app/components/home/live/live_event_list_item.dart';
import 'package:wit_app/models/location.dart';

class MainLocationLiveEventList extends StatelessWidget {
  final List<Location> locations;
  const MainLocationLiveEventList({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
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
                  'Events',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (contextLoginScreen) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<CategoryBloc>(context),
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<PositionBloc>(context),
                          )
                        ],
                        child: const MainAllLocationList(),
                      );
                    }),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
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
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              var locationData = locations[index];
              return Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  LiveEventListItem(
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
        ),
      ],
    );
  }
}
