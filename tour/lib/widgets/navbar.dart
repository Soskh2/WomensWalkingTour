// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:tour/screens/home.dart';
import 'package:tour/screens/map.dart';
import 'package:tour/screens/sites.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),  // HomePage at index 0
    MapPage(),  // TestPage at index 1
    SitesPage(),  // TestPage at index 1
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;  // Update the index when a bottom navigation item is tapped
    });
  }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110), // Custom height for the AppBar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          toolbarHeight: 110.0,
          title: Align(
            alignment: Alignment.centerLeft, // Align to the left
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
              crossAxisAlignment: CrossAxisAlignment.start, // Align text and divider to the left
              children: [
                Text(
                  'Yale University', // Top text
                  style: TextStyle(fontSize: 20),
                ),
                Divider(
                  color: Colors.white, // Divider color (white)
                  thickness: 1, // Thickness of the line
                  indent: 0, // No indent for the divider
                  endIndent: 0, // No end indent for the divider
                ),
                Text(
                  'Women at Yale: A Walking Tour', // Bottom text
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex],  // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,  
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Test',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Sites',
        ),
      ],
      ),
    );
  }
}
