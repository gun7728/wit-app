import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wit_app/servcies/api_service.dart';
import 'package:wit_app/servcies/location_service.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _MainAppBarState extends State<MainAppBar> {
  String currentLocation = '';
  onPressLocaiton() async {
    Position position = await LocationService().getCurrentPosition();
    final result = await ApiService()
        .getCurrentLocation(position.longitude, position.latitude);
    setState(() {
      currentLocation = result['structure']['level4A'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      toolbarHeight: 80,
      centerTitle: false,
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 1.5),
                child: Text(
                  'Explore',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  onPressLocaiton();
                },
                icon: const Icon(
                  Icons.my_location,
                  size: 15,
                  color: Color(0xfff106df4),
                ),
                label: Text(
                  currentLocation,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  'Korea',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    height: 0.7,
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
