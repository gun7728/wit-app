import 'dart:ui';

import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final Function(int) setCurrentIndex;
  const Splash({super.key, required this.setCurrentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
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
                  height: 280,
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
                          fontSize: 29.5,
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
                                onPressed: () {},
                                child: const Text(
                                  'Sign up',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Log in',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {
                                          setCurrentIndex(1);
                                        },
                                        child: const Text(
                                          'Continue as guest',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }
}
