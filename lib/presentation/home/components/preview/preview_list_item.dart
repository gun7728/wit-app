import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PreviewListItem extends StatelessWidget {
  final String title;
  final String addr1;
  final String tel;
  final String firstimage;
  final String contentid;
  final bool isLoading;

  const PreviewListItem({
    super.key,
    required this.title,
    required this.addr1,
    required this.tel,
    required this.firstimage,
    required this.contentid,
    required this.isLoading,
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
            child: firstimage != ''
                ? CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: firstimage,
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
                  )
                : Image.asset(
                    'assets/noImg.webp',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        !isLoading
            ? Positioned(
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
              )
            : const SizedBox.shrink(),
        if (addr1 != '' && !isLoading)
          Positioned(
            left: 5,
            bottom: 45,
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
