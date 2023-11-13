import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:verve/api/base_api_service.dart';
import 'package:verve/api/endpoints.dart';
import 'package:verve/models/api/error.dart';
import 'package:verve/models/api/response.dart';

class ApiService extends BaseApiService {
  // Send an HTTP request and handle the response
  Future<ApiResponse> _sendRequest({
    required String method,
    required String endpoint,
    required bool mustAuthenticated,
    Map<String, dynamic>? data,
  }) async {
    try {
      var url = Uri.parse("${EndPoints.baseURL}$endpoint");

      var request = http.Request(method, url)
        ..headers.addAll(await getHeaders(mustAuthenticated));

      if (data != null) {
        request.body = jsonEncode(data);
      }
      // Debugging output for request and response
      debugPrint("=======");
      debugPrint("🗣️ Sending $method request to $url");
      debugPrint("🗣️ Sending data $data");

      http.StreamedResponse response = await request.send();
      var resData = await response.stream.bytesToString();

      debugPrint("🗣️ Status code: ${response.statusCode}");
      debugPrint("🗣️ Body: $resData");
      debugPrint("=======");

      // Handle unauthenticated responses and check for success or failure
      handleUnAuthenticated(response.statusCode , mustAuthenticated);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful response
        return ApiResponse(
          status: RequestStatus.success,
          data: jsonDecode(resData),
        );
      }

      // Failed response
      throw ApiError(message: jsonDecode(resData)['error']);
    } on SocketException {
      // Handle network connectivity errors
      throw ApiError(message: "Unable to connect to the server");
    } on TimeoutException {
      // Handle request timeout
      throw ApiError(message: 'The request is timed out');
    } catch (e) {
      // Handle other errors
      debugPrint('An error thrown : $e');
      if (e.runtimeType == ApiError) {
        rethrow;
      }
      throw ApiError(message: "Something went wrong");
    }
  }

  // GET Request
  Future<ApiResponse> get({
    required String endpoint,
    required bool mustAuthenticated,
    Map<String, dynamic>? data,
  }) async {
    return _sendRequest(
      method: "GET",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // PUT Request
  Future<ApiResponse> put(
      {required Map<String, dynamic> data,
      required String endpoint,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "PUT",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // DELETE Request
  Future<ApiResponse> delete(
      {required Map<String, dynamic> data,
      required String endpoint,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "DELETE",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }

  // POST Request
  Future<ApiResponse> post(
      {required Map<String, dynamic> data,
      required String endpoint,
      String? baseURL,
      required bool mustAuthenticated}) async {
    return _sendRequest(
      method: "POST",
      endpoint: endpoint,
      data: data,
      mustAuthenticated: mustAuthenticated,
    );
  }
}
