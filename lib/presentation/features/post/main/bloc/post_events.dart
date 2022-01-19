import 'package:equatable/equatable.dart';

abstract class PostEventBase extends Equatable{

}

class FetchListPostEvent extends PostEventBase{

  @override
  List<Object?> get props => [];
}