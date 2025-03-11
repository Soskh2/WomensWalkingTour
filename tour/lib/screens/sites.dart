// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';  // To work with paths
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:dart_airtable/dart_airtable.dart';
import 'package:tour/widgets/visitor_information_button.dart';




class SitesPage extends StatefulWidget {
  const SitesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SitesPageState createState() => _SitesPageState();
}

class _SitesPageState extends State<SitesPage> {
  late Future<Map<String, dynamic>> locations;

  @override
  void initState() {
    super.initState();
    locations = fetchLocations();
  }


  Future<Map<String, dynamic>> fetchLocations() async {
    Uri uri = Uri.parse("https://api.airtable.com/v0/appUtdtFoLD8wowBS/Tour?filterByFormula=Included+%3D+TRUE()");
    Map<String, String> header = {"Authorization": "Bearer patnOVix5R5wsTz8C.92580deda957e6f6da50f28ad387509eefc23c22ab1ed9afe2efed4ef0e33818"};

    print("calling");
    var response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> result = json.decode(response.body);
    print("result");
    print(result);
    return result; 
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    throw Exception('Failed to load');
  }
  }


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
              'Sites',
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
                'Click on any point below to get more information about a stop on the walking tour.'),
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

