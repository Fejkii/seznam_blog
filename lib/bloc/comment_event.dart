part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class GetCommentListByPostIdEvent extends CommentEvent {
  final int postId;

  GetCommentListByPostIdEvent({required this.postId});
}

class PostNewCommentEvent extends CommentEvent {}
