import 'package:flutter/material.dart';
import 'package:wit_app/data/models/spots.dart';
import 'package:wit_app/presentation/home/components/preview/preview_list_item.dart';

class PreviewList extends StatelessWidget {
  final List<Spots> spots;
  const PreviewList({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 380,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: spots.length,
            itemBuilder: (context, index) {
              var locationData = spots[index];
              return Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  PreviewListItem(spot: locationData),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
