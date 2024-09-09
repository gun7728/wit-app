import 'package:flutter/material.dart';

class LocationList extends StatelessWidget {
  final String title;
  final String addr1;
  final String tel;
  final String firstimage;
  final String contentid;

  const LocationList({
    super.key,
    required this.title,
    required this.addr1,
    required this.tel,
    required this.firstimage,
    required this.contentid,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: 220,
          height: 320,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              firstimage,
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace) {
                // 네트워크 이미지 로딩 실패 시 대체 이미지 표시
                return Image.asset(
                  'assets/noImg.webp',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitHeight,
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 5,
          bottom: 40,
          child: ConstrainedBox(
            // width: 180,
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
        Positioned(
          left: 5,
          bottom: 5,
          child: ConstrainedBox(
            // width: 180,
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
    );
  }
}
