import 'package:dio/dio.dart';
import 'package:flutter_todolist29112021/common/network/dio_client.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';

class PostRequestApi{
  late Dio _dio;

  PostRequestApi(){
    _dio = DioClient.instance.dio;
  }

  Future<Response<dynamic>> getListPosts(){
    return _dio.get("posts");
  }
}