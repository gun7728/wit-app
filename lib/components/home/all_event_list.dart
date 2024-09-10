import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/location/location_bloc.dart';
import 'package:wit_app/pages/home_page.dart';
import 'package:wit_app/respository/location/location_repository.dart';

class MainAllLocationList extends StatelessWidget {
  const MainAllLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    final locationRepository = LocationRepository();

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            LocationBloc(locationRepository: locationRepository),
      ),
    ], child: const HomePage());
  }
}
