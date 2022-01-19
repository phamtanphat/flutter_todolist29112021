import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/app_resources.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_events.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_states.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/repositories/post_repository.dart';

class PostBloc{
  StreamController<PostEventBase> _eventController = StreamController();
  StreamController<PostStateBase> _stateController = StreamController();

  Sink<PostEventBase> get event => _eventController.sink;

  Stream<PostStateBase> get state => _stateController.stream;

  late PostRepository _postRepository;

  PostBloc(PostRepository postRepository){
    _postRepository = postRepository;

    _eventController.stream.listen((event) {
        if(event is FetchListPostEvent){
          _handleFetchList(event);
        }
    });
  }

  void _handleFetchList(FetchListPostEvent event) async{
    try{
      Response response = await _postRepository.getListPost();
      if(response.statusCode == 200){
        List<PostModel> listModel = (response.data as List).map((e){
          return PostModel.fromJson(e);
        }).toList();
        _stateController.sink.add(PostResult(data: AppResources.success(listModel)));
      }
    }catch(e){
      _stateController.sink.add(PostResult(data: AppResources.error(e.toString())));
    }
  }

}