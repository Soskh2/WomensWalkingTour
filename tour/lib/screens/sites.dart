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
    return Scaffold(
      appBar: AppBar(title: Text('Locations')),
      // body: locations.isEmpty
      //     ? Center(child: CircularProgressIndicator())
      //     : ListView.builder(
      //         itemCount: locations.length,
      //         itemBuilder: (context, index) {
      //           final location = locations[index];
      //           return ListTile(
      //             title: Text(location.title),
      //             leading: Image.asset(location.imagePath, width: 100, height: 100,),
      //           );
      //         },
      //       ),
    );
  }
}

// class AirtableRecord {
//   final String id;
//   final String name; // Example fields, adjust based on your Airtable schema
//   final String order_number; // Example fields, adjust based on your Airtable schema

//   AirtableRecord({required this.id, required this.name});

//   // Factory constructor to create an AirtableRecord from a JSON object
//   factory AirtableRecord.fromJson(Map<String, dynamic> json) {
//     return AirtableRecord(
//       id: json['id'],
//       name: json['fields']['name'], // Adjust based on your Airtable schema
//     );
//   }
// }
