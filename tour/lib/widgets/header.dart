import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  Header({super.key}) : preferredSize = Size.fromHeight(kToolbarHeight + 40);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      toolbarHeight: 110.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yale University',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              Text(
                'Women at Yale: A Walking Tour',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
