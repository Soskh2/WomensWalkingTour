import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tour/models/tour_record_model.dart';
import 'package:tour/network/network_enums.dart';
import 'package:tour/network/network_helper.dart';
import 'package:tour/network/network_service.dart';

class SitesProvider with ChangeNotifier {
  List<Field> _locations = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Field> get locations => _locations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch data from API
  Future<void> fetchLocations() async {
    _errorMessage = null;
    try {
      Uri uri = kIsWeb
          ? Uri.parse("${dotenv.env['AIRTABLE_BASE_URL']}")
          : Uri.parse("${FlutterConfig.get('AIRTABLE_BASE_URL')}");

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
        _locations[i].index = i;
      }
    } catch (e) {
      _errorMessage = 'Failed to load data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Field> _listOfFieldsFromJson(json) {
    json = json as List;
    List<Field> fields = (json).map((e) {
      return Field.fromJson(e['fields'] as Map<String, dynamic>);
    }).toList();
    return fields;
  }
}
