import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/bloc/position/position_bloc.dart';
import 'package:wit_app/bloc/position/position_event.dart';
import 'package:wit_app/bloc/position/position_state.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionBloc, PositionState>(
      builder: (context, PositionState state) {
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
                      context.read<PositionBloc>().add(GetPositionEvent());
                    },
                    icon: const Icon(
                      Icons.my_location,
                      size: 15,
                      color: Color(0xfff106df4),
                    ),
                    label: Text(
                      state is Loaded
                          ? (state.positionKor != null
                              ? '${state.positionKor}'
                              : 'Current Location')
                          : 'Current Location',
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
      },
    );
  }
}
