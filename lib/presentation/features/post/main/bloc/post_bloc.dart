import 'dart:async';

import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_events.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_states.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/repositories/post_repository.dart';

class PostBloc{
  StreamController<PostEventBase> _eventController = StreamController();
  StreamController<PostStateBase> _stateController = StreamController();

  Sink get event => _eventController.sink;

  Stream<PostStateBase> get state => _stateController.stream;

  late PostRepository _postRepository;

  PostBloc(PostRepository postRepository){
    _postRepository = postRepository;

    _eventController.stream.listen((event) {

    });
  }

}