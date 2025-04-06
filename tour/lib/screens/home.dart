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
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16),
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
                    16),
            Container(
              width: 200.0, 
              child: Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
                height:
                    8), 
            Text(
                'This self-guided tour will help you explore the history of women’s contributions to Yale. At each point on the tour, you will be able to read text or listen to audio.'),
            SizedBox(
                height:
                    16), 
            VisitorInformationButton(),
            SizedBox(
                height: 16), 

            // Cards
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, 
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/TourImage.png',
                            width: 135,
                            height: 110,
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Portrait.png', 
                            width: 135,
                            height: 110,
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
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Logo.png',
                            width: 135,
                            height: 110,
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
                SizedBox(height: 16),
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


