import 'package:equatable/equatable.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/app_resources.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';

abstract class PostStateBase extends Equatable{

}

class PostStateInit extends PostStateBase{
  @override
  List<Object?> get props => [];

}

class PostResult extends PostStateBase{
  late AppResources<List<PostModel>> data;

  PostResult({required this.data});

  @override
  List<Object?> get props => [data];
}