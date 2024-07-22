import 'package:dio/dio.dart';

class DataProvider {
  static Future<Response> getRequest({required String endpoint}) async {
    final Dio dio = Dio();

    try {
      final response = await dio.get(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> deleteRequest({required String endpoint}) async {
    final Dio dio = Dio();

    try {
      final response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> postRequest(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final Dio dio = Dio();

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
    final Dio dio = Dio();

    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
