import 'dart:convert';

import 'package:dio/dio.dart';

class DataProvider {
  static final Dio _dio = Dio()
    ..options.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('test:pass'))}';

  static Dio get dio => _dio;

  static Future<Response> getRequest({required String endpoint}) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> deleteRequest({required String endpoint}) async {
    try {
      final response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> updateRequest({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
