import 'package:api_call_concept/blocs/post_bloc/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPostLoadingState extends GetPostState {}

class GetPostLoadedState extends GetPostState {
  final List<PostModel> posts;

  GetPostLoadedState(this.posts);

  @override
  List<Object> get props => [posts];
}

class GetPostErrorState extends GetPostState {
  final String error;

  GetPostErrorState(this.error);

  @override
  List<Object> get props => [error];
}
