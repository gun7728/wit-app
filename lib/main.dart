import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/data/respository/position/position_repository.dart';
import 'package:wit_app/data/respository/spot/spot_repository.dart';
import 'package:wit_app/presentation/home/bloc/option_cubit.dart';
import 'package:wit_app/presentation/home/bloc/page_cubit.dart';
import 'package:wit_app/presentation/home/bloc/page_state.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/selected_spot_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/components/search/text/text_search_list.dart';
import 'package:wit_app/presentation/home/pages/home.dart';
import 'package:wit_app/presentation/map/pages/map_page.dart';
import 'package:wit_app/widget/default_bottom_nav.dart';
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
  int _currentIndex = -1;
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
      const Home(),
      TextSearchList(setCurrentIndex: setCurrentIndex),
      const MapPage(),
    ];

    dynamic appBarCall(currentIndex) {
      if (currentIndex == 0) {
        return const MainAppBar();
      } else {
        return null;
      }
    }

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(200, 0, 0, 0),
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
            create: (context) => SelectedSpotCubit(),
          ),
          BlocProvider(
            create: (context) =>
                PositionCubit(positionRepository: positionRepository),
          ),
          BlocProvider(
            create: (context) => OptionCubit(),
          ),
          BlocProvider(
            create: (context) => PageCubit(),
          ),
        ],
        child: BlocListener<PageCubit, PageState>(
          listener: (context, pageIndex) {
            // Update _currentIndex when PageCubit state changes
            if (pageIndex is PageLoaded) {
              setCurrentIndex(pageIndex.currentPage);
            }
          },
          child: BlocBuilder<PageCubit, PageState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: const Color.fromARGB(255, 249, 249, 249),
                appBar: appBarCall(_currentIndex),
                body: _currentIndex == -1
                    ? Splash(setCurrentIndex: setCurrentIndex)
                    : pages[_currentIndex], // Display the selected page
                bottomNavigationBar: (_currentIndex >= 0 && _currentIndex != 3)
                    ? DefaultBottomNav(
                        currentIndex: _currentIndex,
                        setCurrentIndex: setCurrentIndex,
                      )
                    : null,
              );
            },
          ),
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
