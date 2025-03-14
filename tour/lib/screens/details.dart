import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:tour/providers/location_provider.dart';
import 'package:tour/models/tour_record_model.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.siteIndex});

  final int siteIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationsProvider>(
      builder: (context, locationsProvider, child) {
        // Fetch the location based on the siteIndex
        if (locationsProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // If there was an error fetching locations, show an error message
        if (locationsProvider.errorMessage != null) {
          return Center(child: Text(locationsProvider.errorMessage!));
        }

        // Fetch the location using the siteIndex
        Field location;
        try {
          location = locationsProvider.locations[siteIndex];
        } catch (e) {
          return Center(child: Text("Invalid site index."));
        }

        return SingleChildScrollView(
          // Use SingleChildScrollView to ensure scrolling for long content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              location.image != null &&
                      location.image!.isNotEmpty &&
                      location.image?[0].url != null
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        location.image![0].url ??
                            'https://via.placeholder.com/600x200', // Use location's image URL or fallback
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const SizedBox(width: 135),

              // Some Text Below Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment:
                      Alignment.center, // This centers the text horizontally
                  child: Text(
                    "${location.index! + 1} - ${location.name}",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),

              // Audio Section (Only if available)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (location.audio != null &&
                        location.audio!.isNotEmpty &&
                        location.audio![0].url !=
                            null) // Check if audio URL is available
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Audio Description:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          // Replace with an actual audio player widget using location.audioUrl
                          Icon(Icons.play_arrow,
                              size: 50), // Replace with actual player
                          SizedBox(height: 8),
                          Text(
                            'Click the play button above to listen to the audio file.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // More Text Section (Long Paragraphs)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  location.description ?? 'No detailed information available.',
                  style: TextStyle(fontSize: 14),
                ),
              ),

              // Image Carousel Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 250, // Adjust height as needed
                  child: Swiper(
                    itemCount: location.image?.length ??
                        5, // Use location's image URLs if available
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        location.image?[index].url ??
                            'https://via.placeholder.com/600x250?text=Image+${index + 1}', // Replace with actual image URLs
                        fit: BoxFit.cover,
                      );
                    },
                    pagination: SwiperPagination(), // Show page indicators
                    control:
                        SwiperControl(), // Optionally, show left/right controls
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
