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
                Container(
                  alignment: Alignment.center,
                  width: 220,
                  height: 320,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: firstimage != ''
                        ? CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: firstimage,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                'assets/noImg.webp',
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fitHeight,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/noImg.webp',
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                ),
                if (!isLoading)
                  Positioned(
                    left: 5,
                    bottom: 5,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 180,
                      ),
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4D5653),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (addr1 != '' && !isLoading)
                  Positioned(
                    left: 5,
                    bottom: 45,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 180,
                      ),
                      child: IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4D5653),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              addr1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            ),
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
