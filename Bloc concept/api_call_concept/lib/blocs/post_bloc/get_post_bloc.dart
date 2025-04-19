import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'get_post_event.dart';
import 'get_post_states.dart';
import 'package:api_call_concept/blocs/post_bloc/post_model.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  GetPostBloc() : super(GetPostLoadingState()) {
    on<FetchPostsEvent>(_fetchPosts);
  }
  Future<void> _fetchPosts(
      FetchPostsEvent event, Emitter<GetPostState> emit) async {
    emit(GetPostLoadingState());
    try {
      final dio = Dio();
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        print("jsonplaceholder $response");
        List<PostModel> posts = (response.data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        emit(GetPostLoadedState(posts));
      } else {
        emit(GetPostErrorState("Failed to load posts"));
      }
    } catch (e) {
      emit(GetPostErrorState(e.toString()));
    }
  }
}
