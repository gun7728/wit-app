import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';

class Splash extends StatefulWidget {
  final Function(int) setCurrentIndex;
  const Splash({super.key, required this.setCurrentIndex});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllSpots();
  }

  Future<void> getAllSpots() async {
    setState(() {
      isLoading = true;
    });

    context.read<SpotsCubit>().getAllSpots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpotsCubit, SpotsState>(
      listener: (context, SpotsState state) {
        if (state is SpotsLoaded) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/splash.png'), // 배경 이미지
          ),
        ),
        child: Stack(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120,
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    'Trip',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 60,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0, // 그림자 흐림
                            color: Colors.black, // 그림자 색상
                            offset: Offset(3.0, 3.0), // 그림자가 얼마나 표시될지
                          )
                        ],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    'To',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 60,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0, // 그림자 흐림
                            color: Colors.black, // 그림자 색상
                            offset: Offset(3.0, 3.0), // 그림자가 얼마나 표시될지
                          )
                        ],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    'Seoul',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: .8,
                        color: Colors.white,
                        fontSize: 80,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0, // 그림자 흐림
                            color: Colors.black, // 그림자 색상
                            offset: Offset(3.0, 3.0), // 그림자가 얼마나 표시될지
                          )
                        ],
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 15,
              right: 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 50.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.black.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Greatest Spots in Seoul",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Travel destinations based on data provided by the Korea Tourism Organization',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF106DF4),
                                ),
                                height: 50,
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    widget.setCurrentIndex(0);
                                  },
                                  child: isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Start',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
