import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spot_state.dart';
import 'package:wit_app/presentation/home/components/detail/spot_detail.dart';

class PreviewListItem extends StatelessWidget {
  final String title;
  final String addr1;
  final String tel;
  final String firstimage;
  final String contentid;
  final String contenttypeid;
  final bool isLoading;

  const PreviewListItem({
    super.key,
    required this.title,
    required this.addr1,
    required this.tel,
    required this.firstimage,
    required this.contentid,
    required this.contenttypeid,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpotCubit(spotRepository: SpotRepository()),
      child: Builder(
        builder: (context) => BlocListener<SpotCubit, SpotState>(
          listener: (context, state) {
            if (state is SpotLoaded) {
              if (state.spot != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (contextLoginScreen) {
                    return BlocProvider.value(
                      value: BlocProvider.of<SpotCubit>(context),
                      child: SpotDetail(firstimage: firstimage),
                    );
                  }),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No detail'),
                    duration: Duration(milliseconds: 200),
                  ),
                );
              }
            } else if (state is SpotError) {
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
              context.read<SpotCubit>().getSpotDetail(contentid, contenttypeid);
            },
            child: Stack(
              children: [
                // Blurred background
                Container(
                  width: 300,
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: firstimage != ''
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(firstimage),
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
                            width: 300,
                            height: 380,
                            child: firstimage != ''
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: firstimage,
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
                if (!isLoading)
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
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                addr1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
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
