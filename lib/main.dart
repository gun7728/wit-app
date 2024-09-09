import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/bloc/location/location_bloc.dart';
import 'package:wit_app/bloc/position/position_bloc.dart';
import 'package:wit_app/pages/default_page.dart';
import 'package:wit_app/pages/map_page.dart';
import 'package:wit_app/pages/my_page.dart';
import 'package:wit_app/respository/location/location_repository.dart';
import 'package:wit_app/respository/position/position_repository.dart';
import 'package:wit_app/widget/default_bottom_nav.dart';
import 'package:wit_app/widget/main_app_bar.dart';

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
  String currentLocation = '현위치';

  final List<Widget> _pages = [
    const DefaultPage(),
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
    final locationRepository = LocationRepository();
    final positionRepository = PositionRepository();

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LocationBloc(locationRepository: locationRepository),
          ),
          BlocProvider(
            create: (context) =>
                PositionBloc(positionRepository: positionRepository),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _currentIndex != 2 ? const MainAppBar() : null,
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
      ),
    );
  }
}
