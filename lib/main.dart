import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/data/respository/position/position_repository.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/infinite_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/pages/home.dart';
import 'package:wit_app/presentation/map/pages/map_page.dart';
import 'package:wit_app/presentation/my/my_page.dart';
import 'package:wit_app/widget/main_app_bar.dart';
import 'package:wit_app/widget/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  bool isLoading = true;
  String currentLocation = '현위치';

  setCurrentIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final spotRepository = SpotRepository();
    final positionRepository = PositionRepository();

    final List<Widget> pages = [
      Splash(setCurrentIndex: setCurrentIndex),
      const Home(),
      const MyPage(),
      const MapPage(),
    ];

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'Pretendard',
        // Define your custom colors here
        // You can also define these colors in the colorScheme
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF106DF4),
          secondary: const Color(0xFFFFBF5D),
          surface: const Color.fromARGB(255, 249, 249, 249),
          onSurfaceVariant: const Color.fromARGB(255, 241, 241, 241),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SpotsCubit(spotRepository: spotRepository),
          ),
          BlocProvider(
            create: (context) =>
                PositionCubit(positionRepository: positionRepository),
          ),
          BlocProvider(
            create: (context) => TypeCubit(),
          ),
          BlocProvider(
            create: (context) =>
                InfiniteSpotCubit(spotRepository: spotRepository),
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 249, 249, 249),
          appBar: _currentIndex != 0 ? const MainAppBar() : null,
          body: pages[_currentIndex], // Display the selected page
          // bottomNavigationBar: DefaultBottomNav(
          //   currentIndex: _currentIndex,
          //   setCurrentIndex: setCurrentIndex,
          // ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
