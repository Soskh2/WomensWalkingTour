import 'package:flutter/material.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/network/network_enums.dart';
import 'package:tour/network/network_helper.dart';
import 'package:tour/network/network_service.dart';

class Sites extends StatelessWidget {
  const Sites({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: Text("No Data Available"));
          } else {
            final List<Field> fields = snapshot.data as List<Field>;

            return Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
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
                            child: Container(
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
                                      : SizedBox(width: 135),
                                  SizedBox(width: 16),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align text to the left
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                            child:
                                      Text(
                                        "${index + 1} - ${fields[index].name!}",
                                        style: TextStyle(fontSize: 16),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      )),
                                      // ),
                                      SizedBox(height: 4),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: TextButton(
                                            onPressed: () {
                                              // Your navigation logic or action on button press
                                            },
                                            style: TextButton.styleFrom(
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor, // Border color
                                              ),
                                              // padding: EdgeInsets.symmetric(
                                              //     vertical: 4, horizontal: 10),
                                            ),
                                            child: Text(
                                              'View Page >',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor, // Text color
                                              ),
                                            ),
                                          ))
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            ));
          }

          // return Text("Loading");
        });
  }

  Future<List<Field>?> getSites() async {
    Uri uri = Uri.parse(
        "https://api.airtable.com/v0/appUtdtFoLD8wowBS/Tour?filterByFormula=Included+%3D+TRUE()");
    Map<String, String> header = {
      "Authorization":
          "Bearer patnOVix5R5wsTz8C.92580deda957e6f6da50f28ad387509eefc23c22ab1ed9afe2efed4ef0e33818"
    };
    final response = await NetworkService.sendRequest(uri: uri);

    return NetworkHelper.filterResponse(
        callBack: _listOfFieldsFromJson,
        response: response,
        parameterName: CallBackParameterName.fields,
        onFailureCallbackWithMessage: (errorType, msg) {
          return null;
        });
  }

  List<Field> _listOfFieldsFromJson(json) {
    json = json as List;
    // Proceed with mapping if json is a list
    List<Field> fields = (json as List).map((e) {
      return Field.fromJson(e['fields'] as Map<String, dynamic>);
    }).toList();
    return fields;
  }
}
