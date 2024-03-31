import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smartpay/app/model/auth/error_response.dart';

enum HttpRequestType { get, post, patch, put }

mixin BaseRequest {
  final baseUrl = 'https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1';

  Future<http.Response> request({
    required String serviceUrl,
    HttpRequestType type = HttpRequestType.get,
    Map? body,
    String? token,
  }) async {
    late http.Response response;
    if (type == HttpRequestType.post) {
      log("REquest");

      log(body.toString());
      response = await http.post(
        Uri.parse('$baseUrl/$serviceUrl'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
    } else if (type == HttpRequestType.get) {
      ///GET call
      response = await http.get(
        Uri.parse('$baseUrl/$serviceUrl'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );
    }

    if (response.statusCode >= 400) {
      final res = ErrorResponse.fromJson(jsonDecode(response.body));

      String message = res.errors?.email![0] ?? res.message!;
      throw HttpException(message);
    }

    return response;
  }
}
