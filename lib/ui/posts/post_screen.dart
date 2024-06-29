import 'package:api_with_bloc/bloc/posts/posts_bloc.dart';
import 'package:api_with_bloc/bloc/posts/posts_event.dart';
import 'package:api_with_bloc/bloc/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState() {

    super.initState();

    context.read<PostsBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Post API's"),
        backgroundColor: Colors.grey[300],
      ),
      body: BlocBuilder<PostsBloc , PostsState>(
        builder: (context,state){

            switch (state.postStatus){
              case PostStatus.loading:
                return CircularProgressIndicator();

              case PostStatus.failure:
                return Center(child: Text(state.message.toString()));

              case PostStatus.success:
                return Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Search with email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search)
                        ),
                        onChanged: (filterKey){
                          context.read<PostsBloc>().add(SearchItem(filterKey));

                        },
                      ),
                    ),

                    Expanded(
                      child: state.searchMessage.isNotEmpty ?  Center(child: Text(state.searchMessage.toString())) :ListView.builder(
                        itemCount: state.tempPostList.isEmpty ? state.postList.length : state.tempPostList.length,
                          itemBuilder: (context,index) {

                          if (state.tempPostList.isNotEmpty){

                            final item = state.tempPostList[index];
                            return Card(
                              child: ListTile(
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),
                                leading: Icon(Icons.camera),

                              ),
                            );
                          }
                          else{

                            final item = state.postList[index];
                            return Card(
                              child: ListTile(
                                leading: Icon(Icons.camera),
                                title: Text(item.email.toString()),
                                subtitle: Text(item.body.toString()),

                              ),
                            );
                          }



                          }),

                    ),
                  ],
                );();

            }

        },
      ),
    );
  }
}
