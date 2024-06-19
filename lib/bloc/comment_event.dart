// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class GetServerCommentListByPostIdEvent extends CommentEvent {
  final int postId;

  GetServerCommentListByPostIdEvent({required this.postId});
}

class GetLocalCommentListByPostIdEvent extends CommentEvent {
  final int postId;

  GetLocalCommentListByPostIdEvent({required this.postId});
}

class PostNewCommentEvent extends CommentEvent {
  final CommentModel commentModel;

  PostNewCommentEvent({
    required this.commentModel,
  });
}
