import 'package:flutter/material.dart';
import 'package:tour/screens/home.dart';
import 'package:tour/screens/map.dart';
import 'package:tour/screens/sites.dart';
import 'package:tour/widgets/header.dart';
import 'widgets/navbar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16,33,49, 1),
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

  int _currentIndex = 0;

  // This method updates the current index when called from HomePage
  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onButtonPressed: _onTabChanged),
      MapPage(),
      SitesPage(),
    ];
    return Scaffold(
      appBar: Header(),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavBar(onTabChanged: _onTabChanged, currentIndex: _currentIndex,),
    );
  }
}
