import 'package:flutter/material.dart';

class VisitorInformationButton extends StatelessWidget {
  const VisitorInformationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: double
                  .infinity, // Make button span the full width of the parent
              child: ElevatedButton(
                onPressed: () {
                  _showPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).secondaryHeaderColor, // Set background color
                  foregroundColor: Colors.white, // Set text color
                ),
                child: Text('Visitor Information'),
              ),
            );
  }
}

void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Visitor Information'),
          content:
              Text('We will give visitors some information about the locations.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
    },
  );
}