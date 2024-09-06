import 'package:flutter/material.dart';

class DefaultBottomNav extends StatelessWidget {
  const DefaultBottomNav(
      {super.key, required this.currentIndex, required this.setCurrentIndex});

  final int currentIndex;
  final Function(int) setCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setCurrentIndex(index),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'mypage',
          ),
        ]);
  }
}
