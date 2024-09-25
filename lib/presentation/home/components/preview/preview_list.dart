import 'package:flutter/material.dart';
import 'package:wit_app/presentation/home/components/preview/preview_list_item.dart';
import 'package:wit_app/data/models/spots.dart';

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
                    width: 10,
                  ),
                  PreviewListItem(
                    title: locationData.title,
                    addr1: locationData.addr1,
                    tel: locationData.tel,
                    firstimage: locationData.firstimage,
                    contentid: locationData.contentid,
                    contenttypeid: locationData.contenttypeid,
                  ),
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
