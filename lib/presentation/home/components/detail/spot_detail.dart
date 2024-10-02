import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';

class SpotDetail extends StatefulWidget {
  final Spots spot;
  final Function(bool)? mapOpen;
  const SpotDetail({super.key, required this.spot, this.mapOpen});

  @override
  State<SpotDetail> createState() => _SpotDetailState();
}

class _SpotDetailState extends State<SpotDetail> {
  final Dio dio = Dio(); // Dio 인스턴스 생성
  List<String> imageList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    imageList.add(widget.spot.firstImage); // 초기 이미지는 spot.firstImage

    // 이미지를 비동기로 가져오기
    fetchImages();
  }

  Future<void> fetchImages() async {
    final key = dotenv.get('TOUR_API_ECD_KEY');
    final baseUrl = dotenv.get('BASE_URL');

    var url =
        'detailImage1?MobileOS=ios&MobileApp=wit&contentId=${widget.spot.contentId}&imageYN=Y&subImageYN=Y&serviceKey=$key&_type=json';

    try {
      final response = await dio.get('$baseUrl/$url');
      if (response.statusCode == 200) {
        var items = response.data['response']['body']['items']['item'];
        if (items != null) {
          setState(() {
            for (var item in items) {
              imageList.add(item['originimgurl']);
            }
          });
        }
      }
    } catch (e) {
      print("Error fetching images: $e");
    }
  }

  String cleanString(htmlString) {
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PageView.builder(
                        itemCount: imageList.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: imageList[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.map_outlined, color: Colors.black),
                      onPressed: () {
                        context.read<PageCubit>().setPage(2);
                        context
                            .read<SelectedSpotCubit>()
                            .setSelectedSpot(widget.spot);
                        Navigator.pop(context);
                        widget.mapOpen!(true);
                      },
                    ),
                  ),
                ),
                // 인디케이터 추가
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${currentIndex + 1} / ${imageList.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.spot.title}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: screenWidth * 0.02),
                      Text(
                        '${widget.spot.addr1}',
                        style: TextStyle(fontSize: screenWidth * 0.02),

                        overflow:
                            TextOverflow.ellipsis, // 텍스트가 넘칠 경우 '...'으로 표시
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cleanString(widget.spot.outl),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
