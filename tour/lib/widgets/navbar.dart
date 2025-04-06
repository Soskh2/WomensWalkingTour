import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key, required this.onTabChanged, required this.currentIndex});

  final Function(int) onTabChanged;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final int totalNavItems = 3;
    final int validIndex =
        (currentIndex >= 0 && currentIndex < totalNavItems) ? currentIndex : 0;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      currentIndex: validIndex,
      onTap: (index) {
        onTabChanged(index);
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Tour',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Sites',
        ),
      ],
    );
  }
}
