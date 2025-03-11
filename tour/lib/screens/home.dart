import 'package:flutter/material.dart';
import 'package:tour/widgets/visitor_information_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final Function(int) onButtonPressed;
  const HomePage({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align everything to the left
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
                height:
                    16), // Adds some space between the title and the divider
            Container(
              width: 200.0, // Set the desired width for the divider
              child: Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
                height:
                    8), // Adds some space between the divider and the button
            Text(
                'This self-guided tour will help you explore the history of women’s contributions to Yale. At each point on the tour, you will be able to read text or listen to audio.'),
            SizedBox(
                height:
                    16), // Adds some space between the divider and the button
            VisitorInformationButton(),
            SizedBox(
                height: 16), // Adds some space between the button and the cards

            // Cards
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Distribute cards evenly
              children: [
                GestureDetector(
                  onTap: () {
                    onButtonPressed(1);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      // padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/TourImage.png', // Replace with your image asset
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Women at Yale: A Walking Tour',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Second Card - Navigate to another route
                GestureDetector(
                  onTap: () {
                    onButtonPressed(2);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      // padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Portrait.png', // Replace with your image asset
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Tour Sites',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Third Card - Launch URL
                GestureDetector(
                  onTap: () {
                    _launchURL();
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 110,
                      // padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Logo.png', // Replace with your image asset
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Women\'s Faculty Forum',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURL() async {
  Uri uri = Uri.parse("https://wff.yale.edu/");
  await launchUrl(uri);
}


