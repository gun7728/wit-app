import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';

class SpotDetail extends StatelessWidget {
  final String firstimage;
  const SpotDetail({super.key, required this.firstimage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotCubit, SpotState>(
      builder: (context, SpotState state) {
        if (state is SpotLoaded) {
          if (state.spot == null) {
            Navigator.of(context).pop();
          } else if (state.spot != null) {
            return Skeletonizer(
              enabled: false,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Flexible(
                        flex: 6,
                        child: CachedNetworkImage(
                          imageUrl: firstimage,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: imageProvider,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.colorBurn)),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              'assets/noImg.webp',
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitHeight,
                            );
                          },
                        )),
                    Flexible(
                      flex: 4,
                      child: Container(color: Colors.amber),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
