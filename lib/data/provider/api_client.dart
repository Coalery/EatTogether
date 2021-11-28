import 'dart:convert';

import 'package:eat_together/global/auth.controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String backendUrl = 'http://192.168.0.2:8000';

  Future<Map<String, dynamic>> get(
    String path, {Map<String, String>? headers}
  ) async {
    String? token = Get.find<AuthController>().token.value;

    if(token == null) return {};
    if(!path.startsWith('/')) path = '/$path';

    return await _parseToMap(http.get(
      Uri.parse('$backendUrl$path'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...(headers ?? {})
      }
    ));
  }

  Future<Map<String, dynamic>> post(
    String path, {Map<String, String>? headers, Object? body, Encoding? encoding}
  ) async {
    String? token = Get.find<AuthController>().token.value;

    if(token == null) return {};
    if(!path.startsWith('/')) path = '/$path';

    return await _parseToMap(http.post(
      Uri.parse('$backendUrl$path'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...(headers ?? {})
      },
      body: body,
      encoding: encoding
    ));
  }

  Future<Map<String, dynamic>> put(
    String path, {Map<String, String>? headers, Object? body, Encoding? encoding}
  ) async {
    String? token = Get.find<AuthController>().token.value;

    if(token == null) return {};
    if(!path.startsWith('/')) path = '/$path';

    return await _parseToMap(http.put(
      Uri.parse('$backendUrl$path'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...(headers ?? {})
      },
      body: body,
      encoding: encoding
    ));
  }

  Future<Map<String, dynamic>> delete(
    String path, {Map<String, String>? headers, Object? body, Encoding? encoding}
  ) async {
    String? token = Get.find<AuthController>().token.value;

    if(token == null) return {};
    if(!path.startsWith('/')) path = '/$path';

    return await _parseToMap(http.delete(
      Uri.parse('$backendUrl$path'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...(headers ?? {})
      },
      body: body,
      encoding: encoding
    ));
  }

  Future<Map<String, dynamic>> _parseToMap(Future<http.Response> req) async {
    http.Response response = await req;
    return jsonDecode(response.body);
  }
}