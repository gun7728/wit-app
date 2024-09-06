import 'package:flutter/material.dart';

class DefaultBottomNav extends StatelessWidget {
  const DefaultBottomNav(
      {super.key, required this.currentIndex, required this.setCurrentIndex});

  final int currentIndex;
  final Function(int) setCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (index) => setCurrentIndex(index),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: 'mypage'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
        ]);
  }
}
