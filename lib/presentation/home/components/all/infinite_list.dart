import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/infinite_spot_cubit.dart';
import 'package:wit_app/presentation/home/components/all/infinite_screen.dart';

class InfiniteList extends StatelessWidget {
  const InfiniteList({super.key});

  @override
  Widget build(BuildContext context) {
    SpotRepository spotRepository = SpotRepository();
    return BlocProvider(
        create: (_) => InfiniteSpotCubit(spotRepository: spotRepository),
        child: const InfiniteScreen());
  }
}
