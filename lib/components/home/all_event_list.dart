import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/spot/spot_bloc.dart';
import 'package:wit_app/pages/home_page.dart';
import 'package:wit_app/respository/spot/spot_repository.dart';

class MainAllLocationList extends StatelessWidget {
  const MainAllLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    final spotRepository = SpotRepository();

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => SpotBloc(spotRepository: spotRepository),
      ),
    ], child: const HomePage());
  }
}
