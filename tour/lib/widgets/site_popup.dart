import 'package:flutter/material.dart';
import 'package:tour/models/tour_record_model.dart';

class SitePopup extends StatelessWidget {
  const SitePopup(
      {super.key,
      required this.site,
      required this.onNext,
      required this.onPrev,
      required this.onSiteSelect});

  final Field site;
  final Function onNext;
  final Function onPrev;
  final Function onSiteSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, top: 42.0, right: 16.0, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          site.image != null &&
                  site.image!.isNotEmpty &&
                  site.image?[0].url != null
              ? Image.network(site.image![0].url!,
                  width: 300, height: 200, fit: BoxFit.cover)
              : const SizedBox(width: 135),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  onPrev();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Theme.of(context)
                          .secondaryHeaderColor,
                      width: 1, 
                    )),
                child: const Text(
                  '<',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Text(
                "${site.index! + 1}",
                style: const TextStyle(fontSize: 28),
              ),
              ElevatedButton(
                onPressed: () {
                  onNext();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Theme.of(context)
                          .secondaryHeaderColor, 
                      width: 1, 
                    )),
                child: const Text(
                  '>',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16), 
          Text(
            site.name,
            style: const TextStyle(fontSize: 20),
          ),

          const SizedBox(height: 16),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  
                  onSiteSelect(site.index);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  foregroundColor: Theme.of(context).secondaryHeaderColor,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color:
                        Theme.of(context).secondaryHeaderColor,
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Details',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 15), 
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Theme.of(context)
                          .secondaryHeaderColor,
                      width: 1, 
                    )),
                child: const Text(
                  'Directions',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
