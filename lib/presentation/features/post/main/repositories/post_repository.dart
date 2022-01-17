import 'package:dio/dio.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/api/post_request_api.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';

class PostRepository{
  late PostRequestApi _api;

  PostRepository(PostRequestApi api){
    _api = api;
  }

  Future<Response<dynamic>> getListPost(){
    return _api.getListPosts();
  }
}