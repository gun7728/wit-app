import 'package:flutter/material.dart';
import 'package:wit_app/types/category_type.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> cateogryList = categoryType.keys.toList();

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cateogryList.length,
        itemBuilder: (context, index) {
          String? category = categoryType[cateogryList[index]];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  // setCurrentCategory(cateogryList[index]);
                },
                child: Text(
                  '$category',
                  style: const TextStyle(
                    color:
                        // _currentCategory ==
                        //         cateogryList[index]
                        //     ? Theme.of(context).colorScheme.primary
                        //     :
                        Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
