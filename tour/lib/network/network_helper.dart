import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tour/network/network_enums.dart';
import 'package:tour/network/network_typedef.dart';


class NetworkHelper {
  const NetworkHelper._();

  static R filterResponse<R>({
    required NetworkCallBack callBack,
    required http.Response? response,
    required NetworkOnFailureCallBackWithMessage onFailureCallbackWithMessage,
    CallBackParameterName parameterName = CallBackParameterName.all
  }) {
    try {
      if (response == null) {
        return onFailureCallbackWithMessage(NetworkResponseErrorType.exception, 'Empty response');
      }

      var json = jsonDecode(response.body);
      debugPrint("API Response Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return callBack(parameterName.getJson(json));
      }
      else if (response.statusCode == 1700) {
        return onFailureCallbackWithMessage(NetworkResponseErrorType.socket, "socket");
      }
      else {
        return onFailureCallbackWithMessage(NetworkResponseErrorType.didNotSucceed, "Failed ${response.statusCode}");
      }

    } catch (e) {
      return onFailureCallbackWithMessage(NetworkResponseErrorType.exception, 'Exception $e');
    }
  }
}