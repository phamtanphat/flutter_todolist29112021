
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/app_resources.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_events.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_states.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/repositories/post_repository.dart';

class PostBloc extends Bloc<PostEventBase,PostStateBase>{
  late PostRepository _repository;
  PostBloc(PostRepository postRepository) : super(PostStateInit()){
    _repository = postRepository;

    on<FetchListPostEvent>((event, emit) async{
      try{
        Response response = await _repository.getListPost();
        if(response.statusCode == 200){
          List<PostModel> listModel = (response.data as List).map((e){
            return PostModel.fromJson(e);
          }).toList();
          emit(PostResult(data: AppResources.success(listModel)));
        }
      }catch(e){
        emit(PostResult(data: AppResources.error(e.toString())));
      }
    });
  }

}