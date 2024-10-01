import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';

class DefaultBottomNav extends StatelessWidget {
  const DefaultBottomNav({
    super.key,
    required this.currentIndex,
    required this.setCurrentIndex,
  });

  final int currentIndex;
  final Function(int) setCurrentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // 높이를 명시적으로 설정
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        selectedItemColor: Colors.grey[800],
        unselectedItemColor: Colors.grey[500],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: (index) {
          context.read<PageCubit>().setPage(index);
          setCurrentIndex(index);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
        ],
      ),
    );
  }
}
