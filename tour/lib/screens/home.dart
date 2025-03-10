import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align everything to the left
              children: [
                Text(
                  'Welcome', 
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 16), // Adds some space between the title and the divider
                Container(
                  width: 200.0,  // Set the desired width for the divider
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 8), // Adds some space between the divider and the button
                Text('This self-guided tour will help you explore the history of women’s contributions to Yale. At each point on the tour, you will be able to read text or listen to audio.'),
                SizedBox(height: 16), // Adds some space between the divider and the button
                Container(
                    width: double.infinity, // Make button span the full width of the parent
                    child: ElevatedButton(
                      onPressed: () {
                        // Button action here
                        print('Button pressed!');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(2, 53, 108, 1), // Set background color
                        foregroundColor: Colors.white, // Set text color
                      ),
                      child: Text('Visitor Information'),
                    ),
                  ),
                SizedBox(height: 16), // Adds some space between the button and the cards
                
                // Cards 
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
      ),
    );
  }
}