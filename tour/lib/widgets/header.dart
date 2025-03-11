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
        );
      //   ),
      // );
  }
}