import 'package:dio/dio.dart';

class DioClient {
  Dio? _dio;
  static final BaseOptions _options = BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com/",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static final DioClient instance = DioClient._internal();

  DioClient._internal() {
    if (_dio == null){
      _dio = Dio(_options);
      _dio!.interceptors.add(LogInterceptor(requestBody: true));
    }
  }

  Dio get dio => _dio!;
}