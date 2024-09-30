import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_state.dart';
import 'package:wit_app/presentation/home/components/detail/spot_detail.dart';

class PreviewListItem extends StatelessWidget {
  final Spots spot;

  const PreviewListItem({
    super.key,
    required this.spot,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SpotsCubit(spotRepository: SpotRepository()),
      child: Builder(
        builder: (context) => BlocListener<SpotsCubit, SpotsState>(
          listener: (context, state) {
            if (state is SpotsLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contextLoginScreen) {
                  return BlocProvider.value(
                    value: BlocProvider.of<SpotsCubit>(context),
                    child: SpotDetail(firstimage: spot.firstimage),
                  );
                }),
              );
            } else if (state is SpotsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            ),
            onPressed: () {
              context.read<SelectedSpotCubit>().setSelectedSpot(spot);
            },
            child: Stack(
              children: [
                // Blurred background
                Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: spot.firstimage != ''
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(spot.firstimage),
                            fit: BoxFit.cover,
                          )
                        : const DecorationImage(
                            image: AssetImage('assets/noImg.webp'),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                // Edge-blurred main image
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white.withOpacity(0.0)],
                        stops: const [0.9, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [Colors.white, Colors.white.withOpacity(0.0)],
                          stops: const [0.9, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0)
                            ],
                            stops: const [0.9, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.0)
                              ],
                              stops: const [0.9, 1.0],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: SizedBox(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.4,
                            child: spot.firstimage != ''
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: spot.firstimage,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        'assets/noImg.webp',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/noImg.webp',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
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
                            Text(
                              spot.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              spot.addr1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.02,
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
        ),
      ),
    );
  }
}
