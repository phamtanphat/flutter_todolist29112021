import 'package:dio/dio.dart';
import 'package:flutter_todolist29112021/common/network/dio_client.dart';

class PostRequestApi{
  late Dio _dio;

  PostRequestApi(){
    _dio = DioClient.instance.dio;
  }

  Future getListPosts(){
    return _dio.get("posts");
  }
}