import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/providers/location_provider.dart'; // Import the provider

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    final LatLng _center = const LatLng(41.309, -72.927);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Consumer<LocationsProvider>(
      builder: (context, locationsProvider, child) {
        // Fetch the list of locations
        List<Field> locations = locationsProvider.locations;

        // Create markers for each location
        Set<Marker> markers = locations.map((location) {
          // Ensure latitude and longitude are available
          if (location.lat != null && location.lon != null) {
            return Marker(
              markerId: MarkerId(location.name),
              position: LatLng(location.lat!, location.lon!),
              infoWindow: InfoWindow(
                title: location.name ?? 'No Name',
                snippet: 'Latitude: ${location.lat}, Longitude: ${location.lon}',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            );
          }
          return null;
        }).whereType<Marker>().toSet(); // Filter out any null markers

        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            markers: markers, // Set markers on the map
          ),
        );
      },
    );
  }
}
