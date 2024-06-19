part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoadingState extends CommentState {}

final class CommentListSuccessState extends CommentState {
  final List<CommentModel> commentList;

  CommentListSuccessState({required this.commentList});
}

final class CommentFailureState extends CommentState {
  final String errorMessage;

  CommentFailureState({required this.errorMessage});
}

final class CommentCreatedSuccessState extends CommentState {}
