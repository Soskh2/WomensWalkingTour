import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/providers/sites_provider.dart';
import 'package:tour/providers/user_location_provider.dart';
import 'package:tour/widgets/site_popup.dart'; // Import the provider

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.onSiteSelect, this.siteIndex});

  final int? siteIndex;
  final Function onSiteSelect;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  LatLng? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    // Stop location tracking when leaving the page
    Provider.of<LocationProvider>(context, listen: false)
        .stopLocationTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SitesProvider, LocationProvider>(
      builder: (context, sitesProvider, locationProvider, child) {
        // Fetch the list of locations from the provider
        List<Field> locations = sitesProvider.locations;

        _createMarkers(locations);

        print("location position: ${locationProvider.currentPosition}");
        if (locationProvider.currentPosition != null) {
          _currentLocation = LatLng(locationProvider.currentPosition!.latitude,
              locationProvider.currentPosition!.longitude);
        }

        // Create a marker for the user's current location
        Set<Marker> userLocationMarker = {};
        if (_currentLocation != null) {
          userLocationMarker.add(Marker(
            markerId: MarkerId('user_location'),
            position: _currentLocation!,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ));
        }

        return StreamBuilder<Position>(
            stream: Geolocator.getPositionStream(),
            builder:
                (context, snapshot) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation ?? const LatLng(41.309, -72.927),
                    zoom: 16.0,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              );
            });
      },
    );
  }

  void _showSiteModal(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          color: const Color.fromRGBO(253, 253, 253, 1),
          child: SitePopup(
            site: Provider.of<SitesProvider>(context, listen: false)
                .locations[index],
            onNext: () {
              // Navigate to next site
              int nextIndex = (index + 1) %
                  Provider.of<SitesProvider>(context, listen: false)
                      .locations
                      .length;
              Navigator.pop(context);
              _showSiteModal(nextIndex);
            },
            onPrev: () {
              // Navigate to previous site
              int prevIndex = (index -
                      1 +
                      Provider.of<SitesProvider>(context, listen: false)
                          .locations
                          .length) %
                  Provider.of<SitesProvider>(context, listen: false)
                      .locations
                      .length;
              Navigator.pop(context);
              _showSiteModal(prevIndex);
            },
            onSiteSelect: (selectedIndex) {
              Navigator.pop(context);
              widget.onSiteSelect(selectedIndex);
            },
          ),
        );
      },
    );
  }

  Future<Uint8List> getBytesFromCanvas(
      int customNum, int width, int height) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Create a paint object for the marker's background color (let's use blue)
    final Paint paint = Paint()..color = Color.fromARGB(255, 11, 99, 199);
    final path = Path();

    // Draw the marker shape
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width / 2;

    // Move to the starting point of the top half circle
    canvas.drawCircle(Offset(width / 2, height / 2), radius - 2, paint);
    path.moveTo(centerX - 3, radius + 3);

    // Draw left curve from top half circle to the bottom tip
    path.quadraticBezierTo(
      width * 0.05,
      height * 0.5 + 3,
      centerX,
      height * 1 + 3,
    );

    // Draw right curve from the bottom tip to join the top half circle
    path.quadraticBezierTo(
        width * 0.95, height * 0.5 + 3, centerX + radius, radius + 3);

    // Close the path
    path.close();

    canvas.drawPath(path, paint);

    // Create a TextPainter to draw the custom number (or text)
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: customNum.toString(), // Your custom number or text here
      style: TextStyle(
          fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.normal),
    );

    // Layout the text
    painter.layout();

    // Calculate the position for the text (center it in the marker)
    painter.paint(
      canvas,
      Offset(
        (width * 0.5) - (painter.width * 0.5), // Center horizontally
        ((height - 2) * 0.5) - (painter.height * 0.5), // Center vertically
      ),
    );

    // Convert the canvas to an image
    final img = await pictureRecorder.endRecording().toImage(width, height);

    // Convert the image to byte data and return
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<void> _createMarkers(locations) async {
    Set<Marker> markers = {};

    for (var location in locations) {
      if (location.lat != null && location.lon != null) {
        // Call the createCustomMarker function to create a marker with text
        Uint8List customIcon =
            await getBytesFromCanvas(location.index! + 1, 30, 30);

        // Create the marker with the custom icon
        markers.add(Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.lat!, location.lon!),
          icon: BitmapDescriptor.bytes(customIcon),
          onTap: () {
            _showSiteModal(location.index!);
          },
        ));
      }
    }

    setState(() {
      _markers = markers;
    });
  }
}
