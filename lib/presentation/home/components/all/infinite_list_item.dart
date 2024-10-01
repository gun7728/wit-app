import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';

class InfiniteListItem extends StatelessWidget {
  final Spots spot;
  const InfiniteListItem({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 370,
        width: double.infinity,
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: spot.firstImage,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            'assets/noImg.webp',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: Text(
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            spot.title,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              child: Icon(
                                Icons.location_on_sharp,
                                color: Colors.black45,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black45,
                                ),
                                spot.addr1,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.read<SelectedSpotCubit>().setSelectedSpot(spot);
                      context.read<PageCubit>().setPage(2);
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.map_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
