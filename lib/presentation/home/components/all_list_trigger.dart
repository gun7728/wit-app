import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/option_cubit.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/components/all/infinite_list.dart';

class AllListTrigger extends StatelessWidget {
  const AllListTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          child: Text(
            'Events',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
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
                      value: BlocProvider.of<OptionCubit>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<SelectedSpotCubit>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<PositionCubit>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<SpotsCubit>(context),
                    ),
                    BlocProvider.value(
                      value: BlocProvider.of<PageCubit>(context),
                    ),
                  ],
                  child: const InfiniteList(),
                );
              }),
            );
          },
          child: Text(
            'View all',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
