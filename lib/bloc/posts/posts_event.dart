import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class PostFetched extends PostsEvent{}

class SearchItem extends PostsEvent{

  final String stSearch;

  SearchItem(this.stSearch);
}