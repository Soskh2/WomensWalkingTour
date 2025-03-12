import 'package:http/http.dart' as http;
import 'package:tour/static/static_values.dart';

class NetworkService {
  const NetworkService._();

  static Map<String, String> _getHeaders() => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${StaticValues.airtableKey}'
  };

  static Future<http.Response> _createRequest({
    required Uri uri,
    Map<String, String>? headers,
  }) {
    return http.get(uri, headers: headers);
  }

  static Future<http.Response?> sendRequest({
    required Uri uri,
    Map<String, String>? headers,
  }) async {

    try {
      final header = _getHeaders();
      final response = await _createRequest(uri: uri, headers: header);
      return response;
    } catch (e) {
      print("Error - $e");
      return null;
    }

  }
}