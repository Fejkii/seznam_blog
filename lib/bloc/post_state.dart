part of 'post_bloc.dart';

sealed class PostState {}

final class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostListSuccessState extends PostState {
  final List<PostModel> postList;

  PostListSuccessState({required this.postList});
}

class PostFailureState extends PostState {
  final String errorMessage;

  PostFailureState({required this.errorMessage});
}
