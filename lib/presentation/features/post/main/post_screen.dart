import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/api/post_request_api.dart';
import 'package:flutter_todolist29112021/data/model/post_model.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/bloc/post_states.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/repositories/post_repository.dart';
import 'package:provider/provider.dart';

import 'bloc/post_bloc.dart';
import 'bloc/post_events.dart';

class PostScreen extends StatefulWidget {

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
      ),
      body: MultiProvider(
        providers: [
          Provider(create: (context) => PostRequestApi()),
          ProxyProvider<PostRequestApi, PostRepository>(
            create: (context) => PostRepository(context.read<PostRequestApi>()),
            update: (context, api, repository) {
              return PostRepository(api);
            },
          ),
          ProxyProvider<PostRepository, PostBloc>(
            create: (context) => PostBloc(context.read<PostRepository>()),
            update: (context, repository, bloc) {
              return PostBloc(repository);
            },
          )
        ],
        child: PostContainerWidget(),
      ),
    );
  }
}


class PostContainerWidget extends StatefulWidget {
  const PostContainerWidget({Key? key}) : super(key: key);

  @override
  _PostContainerWidgetState createState() => _PostContainerWidgetState();
}

class _PostContainerWidgetState extends State<PostContainerWidget> {
  late PostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<PostBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.event.add(FetchListPostEvent());

    Future.delayed(Duration(seconds: 4) ,() => bloc.event.add(FetchListPostEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostStateBase>(
      initialData: null,
      stream: bloc.state,
      builder: (context, snapshot) {
        if(snapshot.data is PostResult){
          return (snapshot.data as PostResult)
              .data
              .when(
                success: (postModel){
                  return Text(postModel[0].userId.toString());
                },
                error: ([String? message]){
                  return Text(message!);
                }
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

