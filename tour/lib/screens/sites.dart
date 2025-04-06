// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tour/widgets/sites.dart';
import 'package:tour/widgets/visitor_information_button.dart';

class SitesPage extends StatefulWidget {
  const SitesPage({super.key, required this.onSiteChanged});

  final Function onSiteChanged;

  @override
  SitesPageState createState() => SitesPageState();
}

class SitesPageState extends State<SitesPage> {
  late Future<Map<String, dynamic>> locations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sites',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 200.0,
              child: Divider(
                thickness: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
                'Click on any point below to get more information about a stop on the walking tour.'),
            SizedBox(height: 16),
            VisitorInformationButton(),
            SizedBox(height: 16),
          ],
        ),
      ),
      Sites(onSiteChanged: widget.onSiteChanged),
    ]);
  }
}
