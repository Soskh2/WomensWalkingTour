import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:tour/providers/sites_provider.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/widgets/audio_player.dart';

class Details extends StatelessWidget {
  const Details(
      {super.key, required this.siteIndex, required this.onBackPressed});

  final int siteIndex;
  final Function onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<SitesProvider>(
      builder: (context, sitesProvider, child) {
        if (sitesProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (sitesProvider.errorMessage != null) {
          return Center(child: Text(sitesProvider.errorMessage!));
        }
        Field location;
        try {
          location = sitesProvider.locations[siteIndex];
        } catch (e) {
          return Center(child: Text("Invalid site"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 12.0), 
                child: ElevatedButton.icon(
                  onPressed: () => onBackPressed(siteIndex),
                  icon: Icon(Icons.arrow_back),
                  label: Text('Back'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    iconColor: Theme.of(context).secondaryHeaderColor,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              location.image != null &&
                      location.image!.isNotEmpty &&
                      location.image?[0].url != null
                  ? Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        location.image![0].url ??
                            'https://via.placeholder.com/600x200',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      ),
                    )
                  : const SizedBox(width: 135),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${location.index! + 1} - ${location.name}",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),

              // Audio Section (Only if available)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (location.audio != null &&
                        location.audio!.isNotEmpty &&
                        location.audio![0].url != null)
                      AudioPlayerWidget(url: location.audio![0].url!),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  location.description ?? 'No detailed information available.',
                  style: TextStyle(fontSize: 14),
                ),
              ),

              (location.image?.length ?? 0) >
                      1 // Only show the carousel if images are more than 1
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 250,
                        child: Swiper(
                          itemCount: (location.image?.length ?? 0) > 0
                              ? location.image!.length - 1
                              : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return location.image?[index + 1].url != null
                                ? Image.network(
                                    location.image![index + 1].url!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/images/placeholder.png');
                          },
                          pagination: SwiperPagination(),
                          control: SwiperControl(),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
