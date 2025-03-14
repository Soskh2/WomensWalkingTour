import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/providers/location_provider.dart';
import 'package:tour/widgets/site_popup.dart'; // Import the provider

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.onSiteSelect, this.siteIndex});

  final int? siteIndex;
  final Function onSiteSelect;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
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

        void _showSiteModal(int index) {
          // Show the modal with the initial site
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  color: Color.fromRGBO(253, 253, 253, 1),
                  child: SitePopup(
                    site: locations[index], // Pass the current site
                    onNext: () {
                      // If there is a next site, show the next one
                      if (index + 1 < locations.length) {
                        index = index + 1;
                      } else {
                        index = 0;
                      }
                      Navigator.pop(context); // Close the current bottom sheet
                      _showSiteModal(index);
                    },
                    onPrev: () {
                      // If there is a next site, show the next one
                      if (index - 1 >= 0) {
                        index = index - 1;
                      } else {
                        index = locations.length - 1;
                      }
                      Navigator.pop(context); // Close the current bottom sheet
                      _showSiteModal(index);
                    },
                    onSiteSelect: (index) {
                      Navigator.pop(context);
                      widget.onSiteSelect(index);
                    },
                  ));
            },
          );
        }

        if (widget.siteIndex != null) {
          Future.delayed(Duration.zero, () {
            _showSiteModal(widget.siteIndex!);
          });
        }

        // Create markers for each location
        Set<Marker> markers = locations
            .map((location) {
              // Ensure latitude and longitude are available
              if (location.lat != null && location.lon != null) {
                return Marker(
                    markerId: MarkerId(location.name),
                    position: LatLng(location.lat!, location.lon!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure),
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
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
            markers: markers, // Set markers on the map
          ),
        );
      },
    );
  }
}
