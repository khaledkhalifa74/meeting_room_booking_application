import 'package:dio/dio.dart';

class ApiService{
  final Dio _dio;
  final baseUrl = "https://employeevoice.hub2.icall.com.eg";

  ApiService(this._dio);

  Future<Map<String,dynamic>> get({required String endPoint, Map<String, dynamic>? queryParameters})async{
    var response = await _dio.get('$baseUrl$endPoint',queryParameters: queryParameters);

    return response.data;
  }
}