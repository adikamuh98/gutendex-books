// ignore_for_file: unused_field, implementation_imports

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;
  final String _baseUrl;

  DioClient({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) : _baseUrl = baseUrl,
       _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           contentType: 'application/json',
           headers: {'Accept': 'application/json'},
         ),
       ) {
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(PrettyDioLogger());
  }
}
