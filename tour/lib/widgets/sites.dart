import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add the provider import
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/providers/sites_provider.dart'; // Import the provider

class Sites extends StatelessWidget {
  const Sites({super.key, required this.onSiteChanged});

  final Function onSiteChanged;

  @override
  Widget build(BuildContext context) {
    // We use a Consumer to listen to changes in sitesProvider
    return Consumer<SitesProvider>(
      builder: (context, sitesProvider, child) {
        if (sitesProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (sitesProvider.errorMessage != null) {
          return Center(child: Text("Error: ${sitesProvider.errorMessage}"));
        }
        if (sitesProvider.locations.isEmpty) {
          return const Center(child: Text("No Data Available"));
        }
        final List<Field> fields = sitesProvider.locations;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
            child: ListView.builder(
              itemCount: fields.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: Row(
                          children: [
                            fields[index].image != null &&
                                    fields[index].image!.isNotEmpty &&
                                    fields[index].image?[0].url != null
                                ? Image.network(
                                    fields[index].image![0].url!,
                                    width: 135,
                                    height: 130,
                                    fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/images/placeholder.png',
                                    width: 135,
                                    height: 130,
                                    fit: BoxFit.cover),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      "${fields[index].index! + 1} - ${fields[index].name}",
                                      style: const TextStyle(fontSize: 16),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: TextButton(
                                      onPressed: () {
                                        onSiteChanged(fields[index].index);
                                      },
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor, // Border color
                                        ),
                                      ),
                                      child: Text(
                                        'View Page >',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor, // Text color
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
