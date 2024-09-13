import 'package:flutter/material.dart';
import 'package:wit_app/data/models/spot.dart';

class InfiniteListItem extends StatelessWidget {
  final Spot spot;
  const InfiniteListItem({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Single image filling the width
          if (spot.firstimage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                spot.firstimage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/noImg.webp',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 10),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              spot.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          // Address
          if (spot.addr1.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      spot.addr1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('No address information'),
            ),
          const SizedBox(height: 5),
          // Telephone
          if (spot.tel.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      spot.tel,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('No contact information'),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
