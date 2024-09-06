import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/pages/home_page.dart';
import 'package:wit_app/pages/map_page.dart';
import 'package:wit_app/pages/my_page.dart';
import 'package:wit_app/widget/default_bottom_nav.dart';
import 'package:wit_app/widget/main_app_bar.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  String currentLocation = '현위치';

  final List<Widget> _pages = [
    HomePage(),
    const MyPage(),
    const MapPage(),
  ];

  setCurrentIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        // Define your custom colors here
        // You can also define these colors in the colorScheme
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF106DF4),
          secondary: const Color(0xFFFFBF5D),
          surface: const Color(0xFFECECEA),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const MainAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: _pages[_currentIndex], // Display the selected page
            ),
          ],
        ),
        bottomNavigationBar: DefaultBottomNav(
          currentIndex: _currentIndex,
          setCurrentIndex: setCurrentIndex,
        ),
      ),
    );
  }
}
