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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 200, // 이미지 최대 높이
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Image.network(
                    firstimage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      // 네트워크 이미지 로딩 실패 시 대체 이미지 표시
                      return Image.asset(
                        'assets/noImg.webp',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      );
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(addr1),
                  const SizedBox(height: 5),
                  Text(tel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
