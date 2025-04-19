import 'package:api_call_concept/blocs/post_bloc/get_post_event.dart';
import 'package:api_call_concept/blocs/post_bloc/get_post_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/post_bloc/get_post_bloc.dart';

class Homepage extends StatelessWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
 
  var getPostBloc = GetPostBloc();
  // @override
  // void initState() {
  //   super.initState();
  //  getPostBloc.add(FetchPostsEvent());
  //context.read<GetPostBloc>().add(FetchPostsEvent());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts with BLoC")),
      body: BlocProvider(
        create: (_) => getPostBloc..add(FetchPostsEvent()),
        child: BlocConsumer<GetPostBloc, GetPostState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            if (state is GetPostLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetPostLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                leading: const Icon(Icons.list),
                title: Text(state.posts[index].title!));
                },
              );
            } else if (state is GetPostErrorState) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Center(child: Text("Fetching posts..."));
          },
        ),
      ),
    );
  }
}
