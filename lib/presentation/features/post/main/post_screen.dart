import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todolist29112021/data/datasources/remote/api/post_request_api.dart';
import 'package:flutter_todolist29112021/presentation/features/post/main/repositories/post_repository.dart';
import 'package:provider/provider.dart';

import 'bloc/post_bloc.dart';
import 'bloc/post_events.dart';
import 'bloc/post_states.dart';

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
    bloc.add(FetchListPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc,PostStateBase>(
        bloc: bloc,
        builder: (context , state){
          if(state is PostResult){
            return state.data
                .when(
                success: (postModel){
                  return Text(postModel[0].title.toString());
                },
                error: ([String? message]){
                  return Text(message!);
                }
            );
          }
          return CircularProgressIndicator();
        },
        listener: (context , state){

        }
    );
  }


}

