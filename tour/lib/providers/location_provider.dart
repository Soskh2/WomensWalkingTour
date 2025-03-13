import 'package:flutter/material.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/network/network_enums.dart';
import 'package:tour/network/network_helper.dart';
import 'package:tour/network/network_service.dart';

class LocationsProvider with ChangeNotifier {
  List<Field> _locations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Field> get locations => _locations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch data from API
  Future<void> fetchLocations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();  // Notify listeners that the state has changed

    try {
      Uri uri = Uri.parse(
          "https://api.airtable.com/v0/appUtdtFoLD8wowBS/Tour?filterByFormula=Included+%3D+TRUE()");
      Map<String, String> header = {
        "Authorization":
            "Bearer patnOVix5R5wsTz8C.92580deda957e6f6da50f28ad387509eefc23c22ab1ed9afe2efed4ef0e33818"
      };
      final response = await NetworkService.sendRequest(uri: uri);

      _locations = NetworkHelper.filterResponse(
        callBack: _listOfFieldsFromJson,
        response: response,
        parameterName: CallBackParameterName.fields,
        onFailureCallbackWithMessage: (errorType, msg) {
          return [];
        },
      );

      // Sort locations after fetching
      _locations.sort((a, b) {
        if (a.orderNumber == null && b.orderNumber == null) {
          return 0;
        } else if (a.orderNumber == null) {
          return 1;
        } else if (b.orderNumber == null) {
          return -1;
        } else {
          return a.orderNumber!.compareTo(b.orderNumber!);
        }
      });

      
      for (int i = 0; i < _locations.length; i++) {
        _locations[i].index = i; // Add the 'index' property
      }
      
      
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();  // Notify listeners after data is loaded or error occurs
    }
  }

  List<Field> _listOfFieldsFromJson(json) {
    json = json as List;
    List<Field> fields = (json as List).map((e) {
      return Field.fromJson(e['fields'] as Map<String, dynamic>);
    }).toList();
    return fields;
  }
}
