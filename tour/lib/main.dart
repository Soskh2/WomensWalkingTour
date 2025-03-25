import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/providers/location_provider.dart';
import 'package:tour/screens/details.dart';
import 'package:tour/screens/home.dart';
import 'package:tour/screens/map.dart';
import 'package:tour/screens/sites.dart';
import 'package:tour/widgets/header.dart';
import 'widgets/navbar.dart';
import 'constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16, 33, 49, 1),
        secondaryHeaderColor: Color.fromRGBO(2, 53, 108, 1),
        scaffoldBackgroundColor: Color.fromRGBO(243, 243, 243, 1),
        useMaterial3: true,
        fontFamily: "JacquesFrancois",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = HOME;
  int? _currentMapIndex;
  int _currentSiteIndex = HOME;

  List _navigationStack = [];

  late Future<List<Field>?> _locationsFuture;

  @override
  void initState() {
    super.initState();
    Provider.of<LocationsProvider>(context, listen: false).fetchLocations();
  }

  void _onTabChanged(int index) {
    _navigationStack.add(_currentIndex);
    _changeIndex(index);
  }

  void _changeIndex(int index) {
    print("changing index");
    setState(() {
      _currentIndex = index;
      _currentMapIndex = null;
    });
  }

  int _onBack() {
    if (_navigationStack.isNotEmpty) {
      var index = _navigationStack.removeLast();
      print("Index: $index");
      _changeIndex(index);
      return index;
    }
    return -1;
  }

  void _onBackButton(int mapIndex) {
    int pageIndex = _onBack();
    if (pageIndex == MAP) {
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
    _onTabChanged(DETAILS);
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
      Details(siteIndex: _currentSiteIndex, onBackPressed: _onBackButton,),
    ];
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
          child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                print("Going back");
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
}
