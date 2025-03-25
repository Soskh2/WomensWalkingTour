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

  // Variable to store the current location of the user
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    // Start location tracking when the page is loaded
    Provider.of<LocationProvider>(context, listen: false).startLocationTracking();
  }

  @override
  void dispose() {
    // Stop location tracking when leaving the page
    Provider.of<LocationProvider>(context, listen: false).stopLocationTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SitesProvider, LocationProvider>(
      builder: (context, sitesProvider, locationProvider, child) {
        // Fetch the list of locations from the provider
        List<Field> locations = sitesProvider.locations;

        // Update the map when the user's location changes
        if (locationProvider.currentPosition != null) {
          _currentLocation = LatLng(locationProvider.currentPosition!.latitude, locationProvider.currentPosition!.longitude);
        }

        // Create markers for each location
        Set<Marker> markers = locations
            .map((location) {
              // Ensure latitude and longitude are available
              if (location.lat != null && location.lon != null) {
                return Marker(
                    markerId: MarkerId(location.name),
                    position: LatLng(location.lat!, location.lon!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                    onTap: () {
                      _showSiteModal(location.index!);
                    });
              }
              return null;
            })
            .whereType<Marker>()
            .toSet(); // Filter out any null markers


        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? const LatLng(41.309, -72.927), // Default to a center if location is not available
              zoom: 16.0,
            ),
            markers: markers, // Set markers on the map
            myLocationEnabled: true, // Enable the "my location" button
            myLocationButtonEnabled: true, // Show the "my location" button
          ),
        );
      },
    );
  }

  // Function to show the site modal
  void _showSiteModal(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          color: const Color.fromRGBO(253, 253, 253, 1),
          child: SitePopup(
            site: Provider.of<SitesProvider>(context, listen: false).locations[index], // Pass the current site
            onNext: () {
              // Navigate to next site
              int nextIndex = (index + 1) % Provider.of<SitesProvider>(context, listen: false).locations.length;
              Navigator.pop(context);
              _showSiteModal(nextIndex);
            },
            onPrev: () {
              // Navigate to previous site
              int prevIndex = (index - 1 + Provider.of<SitesProvider>(context, listen: false).locations.length) %
                  Provider.of<SitesProvider>(context, listen: false).locations.length;
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
}
