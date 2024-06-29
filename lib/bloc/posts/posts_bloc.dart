import 'package:api_with_bloc/bloc/posts/posts_event.dart';
import 'package:api_with_bloc/bloc/posts/posts_state.dart';
import 'package:api_with_bloc/repository/post_repository.dart';
import 'package:bloc/bloc.dart';

import '../../model/post_model.dart';
import '../../utils/enums.dart';

class PostsBloc extends Bloc<PostsEvent , PostsState>{

  List<PostModel> tempPostList =[];

  PostRepository postRepository = PostRepository();
  PostsBloc(): super( PostsState()){
    on<PostFetched>(fetchPostApi);
    on<SearchItem>(_filterList);
  }

  void fetchPostApi(PostFetched event , Emitter <PostsState> emit)async{

    await postRepository.fetchPost().then((value){
      emit(state.copyWith(postStatus: PostStatus.success,postList: value,message: 'Success'));

    }).onError((error,  stackTrace){
      emit(state.copyWith(postStatus: PostStatus.failure,message:error.toString()));
    });
  }

  void _filterList(SearchItem event , Emitter <PostsState> emit)async{

    if (event.stSearch.isEmpty){
      emit(state.copyWith(tempPostList: [],searchMessage: ''));

    }
    else{
    // tempPostList  = state.postList.where((element)=> element.email.toString() ==event.stSearch.toString()).toList();
    tempPostList  = state.postList.where((element)=> element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();

    if(tempPostList.isEmpty){

    emit(state.copyWith(tempPostList: tempPostList,searchMessage: 'No Data Found'));
    }
    else{
      emit(state.copyWith(tempPostList: tempPostList,searchMessage: ''));


    }
    }


  }
}