import 'dart:convert';
import 'dart:developer';

import 'package:ecom_project_using_rest_api/data/model/response_data.dart';
import 'package:ecom_project_using_rest_api/presentation/state_holders/auth_controller.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token} ) async {
    log(url);
    final Response response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-type' : 'application/json'
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final decodeResponse = jsonDecode(response.body);
      log(response.body);
      if (decodeResponse['msg'] == 'success') {
        return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeResponse,
            errorMessage: decodeResponse['msg']);
      } else {
        return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodeResponse,
            errorMessage: decodeResponse['msg']
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
  Future<ResponseData> postRequest(String url, {Map<String, dynamic>? body, String? token}) async {
    log(url);
    log(body.toString());
    final Response response = await post(Uri.parse(url), body: jsonEncode(body),headers: {
      'token':token.toString(),
      'Content-type' : 'application/json'
    });
    log(response.headers.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final decodeResponse = jsonDecode(response.body);
      if (decodeResponse['msg'] == 'success') {
        return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeResponse,
            errorMessage: decodeResponse['msg']);
      } else {
        return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            responseData: decodeResponse,
            errorMessage: decodeResponse['msg']
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
