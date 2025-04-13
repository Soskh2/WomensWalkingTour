import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService._();

  static Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
        'Authorization': kIsWeb
            ? 'Bearer ${dotenv.env['AIRTABLE_KEY']}'
            : 'Bearer ${FlutterConfig.get('AIRTABLE_KEY')}',
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
      debugPrint("Error - $e");
      return null;
    }
  }
}
