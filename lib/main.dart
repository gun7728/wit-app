import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wit_app/bloc/location_bloc.dart';
import 'package:wit_app/bloc/location_event.dart';
import 'package:wit_app/pages/home_page.dart';
import 'package:wit_app/pages/map_page.dart';
import 'package:wit_app/pages/my_page.dart';
import 'package:wit_app/respository/location_repository.dart';
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
    const HomePage(),
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wit_app/bloc/location_bloc.dart';
// import 'package:wit_app/bloc/location_event.dart';
// import 'package:wit_app/bloc/location_state.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:wit_app/respository/location_repository.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(); // 환경 변수 로드

//   final locationRepository = LocationRepository();

//   runApp(MyApp(locationRepository: locationRepository));
// }

// class MyApp extends StatelessWidget {
//   final LocationRepository locationRepository;

//   const MyApp({super.key, required this.locationRepository});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Location App',
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) =>
//                 LocationBloc(locationRepository: locationRepository),
//           ),
//           // 다른 BlocProvider 추가 가능
//         ],
//         child: const LocationScreen(),
//       ),
//     );
//   }
// }

// class LocationScreen extends StatelessWidget {
//   const LocationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Location List'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 BlocProvider.of<LocationBloc>(context).add(
//                   ListLocationsEvent(
//                     position: Position(
//                         latitude: 37.4980, longitude: 127.0276), // 서울 강남
//                     type: "12", // 예시로 콘텐츠 타입 지정
//                   ),
//                 );
//               },
//               child: const Text('Load Locations'),
//             ),
//             BlocBuilder<LocationBloc, LocationState>(
//               builder: (context, state) {
//                 if (state is Loading) {
//                   return const CircularProgressIndicator();
//                 } else if (state is Loaded) {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: state.locations.length,
//                       itemBuilder: (context, index) {
//                         final location = state.locations[index];
//                         return ListTile(
//                           title: Text(location.title),
//                           subtitle: Text(location.addr1),
//                         );
//                       },
//                     ),
//                   );
//                 } else if (state is Error) {
//                   return Text('Error: ${state.message}');
//                 } else {
//                   return const Text('No locations loaded');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
