import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tour/providers/sites_provider.dart';
import 'package:tour/providers/user_location_provider.dart';
import 'package:tour/screens/details.dart';
import 'package:tour/screens/home.dart';
import 'package:tour/screens/map.dart';
import 'package:tour/screens/sites.dart';
import 'package:tour/static/static_values.dart';
import 'package:tour/widgets/header.dart';
import 'widgets/navbar.dart';
import 'states.dart';

void main() async {
  if (kIsWeb) {
    await dotenv.load(fileName: ".env"); 
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterConfig.loadEnvVariables();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SitesProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women\'s Walking Tour',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16, 33, 49, 1),
        secondaryHeaderColor: Color.fromRGBO(2, 53, 108, 1),
        scaffoldBackgroundColor: Color.fromRGBO(243, 243, 243, 1),
        useMaterial3: true,
        fontFamily: "JacquesFrancois",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = StaticValues.HOME;
  int? _currentMapIndex;
  int _currentSiteIndex = StaticValues.HOME;

  final List _navigationStack = [];

  @override
  void initState() {
    super.initState();
    Provider.of<SitesProvider>(context, listen: false).fetchLocations();
  }

  void _onTabChanged(int index) {
    _navigationStack.add(_currentIndex);
    _changeIndex(index);
  }

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
      _currentMapIndex = null;
    });
    if (index == StaticValues.MAP) {
      _checkLocationPermissions();
    }
  }

  int _onBack() {
    if (_navigationStack.isNotEmpty) {
      var index = _navigationStack.removeLast();
      _changeIndex(index);
      return index;
    }
    return -1;
  }

  void _onBackButton(int mapIndex) {
    int pageIndex = _onBack();
    if (pageIndex == StaticValues.MAP) {
      _currentMapIndex = mapIndex;
    }
  }

  Future<void> _onPop() async {
    if (_navigationStack.isNotEmpty) {
      _onBack();
    } else {
      SystemNavigator.pop();
    }
  }

  // Function to take user to site popup for site of given index

  // void _onMapSelect(int index) {
  //   _onTabChanged(1);
  //   setState(() {
  //     _currentMapIndex = index;
  //   });
  // }

  void _onSiteSelect(int index) {
    _onTabChanged(StaticValues.DETAILS);
    setState(() {
      _currentSiteIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onButtonPressed: _onTabChanged),
      MapPage(
        siteIndex: _currentMapIndex,
        onSiteSelect: _onSiteSelect,
      ),
      SitesPage(onSiteChanged: _onSiteSelect),
      Details(
        siteIndex: _currentSiteIndex,
        onBackPressed: _onBackButton,
      ),
    ];
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
          child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                await _onPop();
              },
              child: IndexedStack(
                index: _currentIndex,
                children: pages,
              ))),
      bottomNavigationBar: NavBar(
        onTabChanged: _onTabChanged,
        currentIndex: _currentIndex,
      ),
    );
  }

  void _checkLocationPermissions() async {
    var permission = await Geolocator.checkPermission();
    debugPrint("Current Location Permission: $permission");
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Request permission if it's denied
      debugPrint("Requesting Permission");
      permission = await Geolocator.requestPermission();
      debugPrint("Permission after Asking: $permission");
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Provider.of<LocationProvider>(context, listen: false)
          .startLocationTracking();
      showLocation = true;
    }
  }
}
