import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align everything to the left
          children: [
            // Title Text
            Text(
              'Welcome', // Change this to your desired title
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16), // Adds some space between the title and the divider
            
            // Divider
            Divider(
              thickness: 0.5,
              color: Theme.of(context).primaryColor,
              endIndent: 50,
            ),
            SizedBox(height: 16), // Adds some space between the divider and the button
            
            // Button
            ElevatedButton(
              onPressed: () {
                // Add your button functionality here
                print('Button pressed!');
              },
              child: Text('Press Me'),
            ),
            SizedBox(height: 16), // Adds some space between the button and the cards
            
            // Cards Section
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute cards evenly
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(child: Text('Card 1')),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(child: Text('Card 2')),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(child: Text('Card 3')),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}