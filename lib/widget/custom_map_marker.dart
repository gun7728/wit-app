import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wit_app/data/models/spots.dart';

class CustomMapMarker extends StatelessWidget {
  final Spots spot;
  final VoidCallback onTap;

  const CustomMapMarker({super.key, required this.spot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: spot.firstimage.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: spot.firstimage,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 20,
                      height: 20,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 16,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
